import pymysql
from flask import Flask, request, jsonify
flutter = Flask(__name__)
flutter.secret_key='abc'
con=pymysql.connect(host='localhost',user='root',password='root',port=3306,db='Bus_safety',charset='utf8')
cmd=con.cursor()
@flutter.route("/logincheck",methods=['GET','POST'])
def logincheck():
    print(request.args)
    user=request.args.get("email")
    print(user)
    passw=request.args.get("password")
    print(passw)
    cmd.execute("SELECT * FROM login WHERE username=%s AND password=%s",(user,passw))
    result=cmd.fetchone()
    print(result)
    if result is None:
        return jsonify({'task':"invalid"})
    return jsonify({'task':'success','lid':result[0],'type':result[3]})


@flutter.route("/user", methods=['POST'])
def user():
    data = request.json
    print(f"Received data: {data}")

    # Extract data from the request
    name = data.get("name")
    dob = data.get("dob")
    gender = data.get("gender")
    mstatus = data.get("mstatus")
    phone = data.get("phone")
    username = data.get("username")
    password = data.get("password")
    guard = data.get("guard")
    user_type = data.get("type")

    initial_balance = 10000

    try:
        cmd = con.cursor()

        # Insert into login table
        cmd.execute("INSERT INTO login (username, password, user_type) VALUES (%s,%s,%s)", (username, password, 'user'))
        id = cmd.lastrowid
        print(f"Inserted login ID: {id}")

        # Insert into accountbalance table
        cmd.execute("INSERT INTO account (id, user_id, accountbalance) VALUES (NULL, %s, %s)", (id, initial_balance))

        # Insert into registration table
        cmd.execute(
            "INSERT INTO registration (name, dob, gender, mstatus, phone, guard, type, loginid) VALUES (%s,%s,%s,%s,%s,%s,%s,%s)",
            (name, dob, gender, mstatus, phone, guard, user_type, id))

        # Commit the transaction
        con.commit()
        return {'task': 'success'}

    except Exception as e:
        con.rollback()
        print(f"Error: {e}")
        return {'task': 'error', 'message': str(e)}


@flutter.route("/getprofile", methods=['POST', 'GET'])
def getprofile():
    lid= request.args.get('lid')
    print("lid=",lid)
    # Assuming 'cmd' is your database cursor
    cmd.execute("SELECT * FROM registration WHERE loginid=%s ",(lid,))
    rows = cmd.fetchall()
    print(rows)

    # Get column names from the description of the cursor
    row_headers = [x[0] for x in cmd.description]  # x[0] gives column names

    # Create a list of dictionaries where each dictionary corresponds to a row
    json_data = [dict(zip(row_headers, result)) for result in rows]

    # Return the JSON data as a response
    return jsonify(json_data)
@flutter.route("/getbuslist", methods=['POST', 'GET'])
def getbuslist():
    lid= request.args.get('lid')
    # Assuming 'cmd' is your database cursor
    cmd.execute("SELECT * FROM buslist WHERE id=%s ",(lid,))
    rows = cmd.fetchall()
    print(rows)

    # Get column names from the description of the cursor
    row_headers = [x[0] for x in cmd.description]  # x[0] gives column names

    # Create a list of dictionaries where each dictionary corresponds to a row
    json_data = [dict(zip(row_headers, result)) for result in rows]

    # Return the JSON data as a response
    return jsonify(json_data)
@flutter.route("/locations", methods=['POST', 'GET'])
def locations():

    # Assuming 'cmd' is your database cursor
    cmd.execute("SELECT * FROM bus_details")
    rows = cmd.fetchall()
    print(rows)

    # Get column names from the description of the cursor
    row_headers = [x[0] for x in cmd.description]  # x[0] gives column names

    # Create a list of dictionaries where each dictionary corresponds to a row
    json_data = [dict(zip(row_headers, result)) for result in rows]

    # Return the JSON data as a response
    return jsonify(json_data)


from datetime import datetime

from datetime import datetime
from flask import request, jsonify


@flutter.route("/businfo", methods=['POST', 'GET'])
def businfo():
    source = request.args.get('source')
    destination = request.args.get('destination')
    date = request.args.get('date')

    # Convert the incoming date to a datetime object
    date_obj = datetime.strptime(date, "%Y-%m-%dT%H:%M:%S.%f")  # Account for milliseconds
    date_only = date_obj.date()  # Extract just the date part

    # Format the date as 'YYYY-MM-DD' to match SQL format
    date_str = date_only.strftime("%Y-%m-%d")

    # Query the database
    query = """
        SELECT * 
        FROM bus_details 
        WHERE `from`=%s AND `to`=%s AND DATE(departure) = %s
    """

    cmd.execute(query, (source, destination, date_str))
    rows = cmd.fetchall()

    # Get column names from the cursor description
    row_headers = [x[0] for x in cmd.description]

    # Create a list of dictionaries where each dictionary represents a row
    busDetails = [dict(zip(row_headers, result)) for result in rows]

    # Return the bus details wrapped in a "busDetails" key
    return jsonify({"busDetails": busDetails})


@flutter.route("/userpayment", methods=['POST'])
def userpayment():
    data = request.json
    print(data)

    # Extract data from the request
    uid = data.get("id")
    bus_id = data.get("bus_id")
    amount = data.get("amount")
    payment_mode = data.get("payment_mode")
    upi_id = data.get("upi_id")

    try:
        # Convert amount to a float to avoid comparison issues
        amount = float(amount)
    except ValueError:
        # Handle the case where the amount is not a valid number
        return {'task': 'failure', 'message': 'Invalid amount'}

    # Fetch the current account balance
    cmd.execute("SELECT accountbalance FROM account WHERE user_id = %s", (uid,))
    acnt = cmd.fetchone()

    if acnt:
        # Extract the account balance from the tuple and convert it to float
        balance = float(acnt[0])  # This ensures balance is treated as a number
        print("Current balance:", balance)

        # Check if the balance is sufficient for the payment
        if balance < amount:
            return {'task': 'failure', 'message': 'Insufficient balance'}

        # Deduct the payment amount from the balance
        new_balance = balance - amount

        # Initialize SQL command and values based on payment mode
        if payment_mode == "UPI" and upi_id:
            # If payment_mode is UPI, we need to include the upi_id
            query = """
                INSERT INTO payment_details (user_id, bus_id, amount, upinumber, status, new_account_balance)
                VALUES (%s, %s, %s, %s, 'paid', %s)
            """
            values = (uid, bus_id, amount, upi_id, new_balance)
        else:
            # If payment_mode is not UPI, we do not include upinumber
            query = """
                INSERT INTO payment_details (user_id, bus_id, amount, upinumber, status, new_account_balance)
                VALUES (%s, %s, %s, NULL, 'paid', %s)
            """
            values = (uid, bus_id, amount, new_balance)

        # Execute the payment insertion
        cmd.execute(query, values)

        # Update the user's balance in the account table
        cmd.execute("UPDATE account SET accountbalance = %s WHERE user_id = %s", (new_balance, uid))

        # Commit the transaction
        con.commit()

        # Return a success message
        return {'task': 'success'}
    else:
        # In case no account is found for the given user_id
        return {'task': 'failure', 'message': 'User account not found'}
@flutter.route('/bookingstatus',methods=['POST','GET'])
def bookingstatus():
    print(request.args)
    id=request.args.get("lid")
    print(id,'ggdgdgdg')
    cmd.execute("SELECT payment_details.*, registration.*, bus_details.* FROM  registration JOIN  payment_details ON payment_details.user_id = registration.loginid JOIN bus_details ON bus_details.bus_loginid = payment_details.bus_id WHERE registration.loginid = '"+str(id)+"'")
    rows = cmd.fetchall()
    print(rows)

    # Get column names from the cursor description
    row_headers = [x[0] for x in cmd.description]

    # Create a list of dictionaries where each dictionary represents a row
    bookingdetails = [dict(zip(row_headers, result)) for result in rows]

    return jsonify({"bookingdetails": bookingdetails})
    # Return the bus details wrapped in a "busDeta
@flutter.route("/sendComplaint", methods=['POST'])
def sendComplaint():
    print(request.args)
    complaint = request.args.get("complaint")
    lid = request.args.get("lid")

    try:
        cmd = con.cursor()

        # Insert into login table with current date and null replay field
        cmd.execute("""
            INSERT INTO `complaints` (user_id, complaint, date, replay)
            VALUES (%s, %s, CURDATE(), NULL)
        """, (lid, complaint))

        con.commit()
        return {'task': 'success'}

    except Exception as e:
        con.rollback()
        print(f"Error: {e}")
        return {'task': 'error', 'message': str(e)}

@flutter.route('/previouscomplaints', methods=['POST', 'GET'])
def previouscomplaints():
        print(request.args)
        id = request.args.get("lid")

        cmd.execute("SELECT * from complaints where user_id='"+str(id)+"'")
        rows = cmd.fetchall()
        print(rows)

        # Get column names from the cursor description
        row_headers = [x[0] for x in cmd.description]

        # Create a list of dictionaries where each dictionary represents a row
        complaints = [dict(zip(row_headers, result)) for result in rows]

        return jsonify({"complaints": complaints})
@flutter.route('/sendfeedback', methods=['POST', 'GET'])
def sendfeedback():
        print(request.args)
        user_id = request.args.get("lid")
        feedback=request.args.get("feedback")

        cmd.execute("insert into feedback values(null,'"+user_id+"','"+feedback+"')")
        con.commit()
        return {'task': 'success'}
@flutter.route('/deletecomplaints',methods=['POST','GET'])
def deletecomplaints():
    print(request.args)
    did=request.args.get('cid')
    print(did,'hhhhhhhhhhhh')
    cmd.execute("delete from complaints where  id='"+str(did)+"'")
    con.commit()
    return {'task': 'success'}
@flutter.route('/bus_data', methods=['POST', 'GET'])
def bus_data():
        print(request.args)
        id = request.args.get("lid")

        cmd.execute("SELECT * from accident_details where bus_loginid='"+str(id)+"'")
        rows = cmd.fetchall()
        print(rows)
        row_headers = [x[0] for x in cmd.description]  # x[0] gives column names

        # Create a list of dictionaries where each dictionary corresponds to a row
        json_data = [dict(zip(row_headers, result)) for result in rows]

        # Return the JSON data as a response
        return jsonify(json_data)


flutter.run(host='0.0.0.0',port=8000)