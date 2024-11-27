import os.path
from datetime import datetime

import pymysql
from flask import Flask, request, jsonify, render_template, session
from werkzeug.utils import secure_filename

bus = Flask(__name__)
bus.secret_key='abc'
con=pymysql.connect(host='localhost',user='root',password='root',port=3306,db='Bus_safety',charset='utf8')
cmd=con.cursor()
@bus.route("/")
def login():
    return render_template("Login.html")
@bus.route("/logincheck",methods=['GET','POST'])
def logincheck():
    print(request.args)
    user=request.form['username']
    print(user)
    passw=request.form['password']
    print(passw)
    cmd.execute("SELECT * FROM login WHERE username=%s AND password=%s",(user,passw))
    result=cmd.fetchone()
    print(result)
    if result is None:
        return '''<script>alert("Invalid username or password"); window.location="/"</script>'''
    user_type=result[3]
    if user_type=='admin':
        return render_template("Admin.html")
    #elif user_type=='user':
      #return render_template("user.html")
    #elif user_type=='moderator':
      #return render_template("moderator.html")
    else:
        return '''<script>alert("Unauthorized user type"); window.location="/"</script>'''
@bus.route("/addbus")
def addbus():
    return render_template("vechiclereg.html")

@bus.route("/addbusdetails", methods=['post'])
def addbusdetails():
    busname=request.form["bus_name"]
    busregnum=request.form["registration_number"]
    ownername = request.form["name_of_owner"]
    mobnu= request.form["monb"]
    username = request.form["username"]
    password= request.form["password"]
    from_location=request.form["from_location"]
    to_location = request.form["to_location"]
    departure = request.form["departure"]
    arrival = request.form["arrival"]
    trh = request.form["trh"]
    fare=request.form["fare"]
    fileupload = request.files["fileField"]
    fi=secure_filename(fileupload.filename)
    fileupload.save(os.path.join("static/images",fi))
    facility=request.form.getlist('facilities')
    fac=','.join(facility)
    cmd.execute("insert into login values(null, '"+username+"','"+password+"','pending')")
    id=cmd.lastrowid
    cmd.execute("insert into bus_details values(null,'"+busname+"','"+busregnum+"','"+ownername+"','"+mobnu+"','"+from_location+"','"+to_location+"','"+departure+"','"+arrival+"','"+trh+"','"+fare+"','"+fi+"','"+fac+"','"+str(id)+"')")
    con.commit()
    return '''<script>alert ("inserted successfully"); window.location="viewbus"</script>'''
@bus.route("/viewbus")
def viewbus():
    cmd.execute("select * from bus_details")
    result=cmd.fetchall()
    print(result)
    return render_template("vehicleview.html",values=result)

@bus.route("/deletebus")
def deletebus():
    id = request.args.get("id")
    print(id)
    cmd.execute("DELETE FROM bus_details WHERE bus_loginid='" + str(id) + "'")
    con.commit()
    return '''<script>alert("bus deleted successfully");window.location="viewbus"</script>'''

@bus.route("/editbus")
def editbus():
    rid=request.args.get("id")
    session["busid"]=rid
    print(rid,'ggggggggggggg')
    cmd.execute("select * from bus_details where bus_loginid='"+str(rid)+"'")
    an=cmd.fetchone()
    print(an)
    return render_template("updatebus.html",val=an)
@bus.route("/updatebus",methods=['post'])
def updatebus(fileupload=None):
    rid=session["busid"]
    busname = request.form["bus_name"]
    busregnum = request.form["registration_number"]
    ownername = request.form["name_of_owner"]
    mobnu = request.form["monb"]
    from_location = request.form["from_location"]
    to_location = request.form["to_location"]

    departure = request.form["departure"]
    arrival = request.form["arrival"]
    trh = request.form["trh"]
    fare = request.form["fare"]
    # fileupload = request.files["fileField"]
    # fi = secure_filename(fileupload.filename)
    # fileupload.save(os.path.join("static/images", fi))

    facility = request.form.getlist('facilities')
    fac = ','.join(facility)

    cmd.execute("UPDATE `bus_details` SET`bus_name`='"+busname+"',`busregnum`='"+busregnum+"',`ownername`='"+ownername+"',`mobnu`='"+mobnu+"',`from`='"+from_location+"',`to`='"+to_location+"',`departure`='"+departure+"',`arrival`='"+arrival+"',`trh`='"+trh+"',`fare`='"+fare+"',`fac`='"+fac+"' WHERE `bus_loginid`='"+rid+"'");
    con.commit()
    return '''<script>alert("updated successfully");window.location="/viewbus"</script>'''
@bus.route('/changeimage')
def changeimage():
    return render_template('changeimage.html')
@bus.route('/updateimage',methods=['POST'])
def updateimage():
    rid=session["busid"]
    fileupload = request.files['fileField']
    fi = secure_filename(fileupload.filename)
    fileupload.save(os.path.join("static/images", fi))
    cmd.execute("update bus_details set fi='"+fi+"' where bus_loginid ='"+rid+"'")
    con.commit()
    return '''<script>alert("image updated");window.location='/viewbus'</script>'''
@bus.route('/addhospital')
def addhospital():
    return render_template('hospitalreg.html')
@bus.route('/addhospitaldetails', methods=['post'])
def addhospitaldetails():
    hos_name = request.form["hos_name"]
    hos_plc = request.form["hos_plc"]
    monb = request.form["monb"]
    lati = request.form["lati"]
    longi = request.form["longi"]
    fileupload = request.files['fileField']
    fi = secure_filename(fileupload.filename)
    fileupload.save(os.path.join("static/images", fi))
    cmd.execute( "insert into hospital_details values(null,'" + hos_name + "','" + hos_plc + "','" + monb + "','" + lati + "','" + longi + "','" + fi + "')")
    con.commit()
    return '''<script>alert("inserted successfully");window.location="viewbus"</script>'''
@bus.route('/viewhospital')
def viewhospital():
    cmd.execute("select * from hospital_details")
    result = cmd.fetchall()
    print(result)
    return render_template("hospitalview.html",value=result)
@bus.route("/deleletehospital")
def deleletehospital():
    id = request.args.get("id")
    print(id)
    cmd.execute("DELETE FROM hospital_details WHERE id='" + str(id) + "'")
    con.commit()
    return '''<script>alert("bus deleted successfully");window.location="/viewhospital"</script>'''

@bus.route("/edithospital")
def edithospital():
    rid=request.args.get("id")
    session["id"]=rid
    print(rid)
    cmd.execute("select * from hospital_details where id='"+str(rid)+"'")
    an=cmd.fetchone()
    print(an)
    return render_template("updatehos.html",value=an)
@bus.route("/updatehos",methods=['post'])
def updatehos():
    rid=session["id"]
    hos_name = request.form["hos_name"]

    hos_plc = request.form["hos_plc"]
    monb = request.form["monb"]
    lati = request.form["lati"]
    longi = request.form["longi"]
    cmd.execute( "UPDATE hospital_details SET hos_name='"+hos_name+"', hos_plc='"+hos_plc+"', monb='"+monb+"',lati='"+lati+"',longi='"+longi+"'  WHERE id='"+rid+"'")
    con.commit()
    return '''<script>alert("updated successfully");window.location="/viewhospital"</script>'''
@bus.route('/changeimagehospital')
def changeimagehospital():
    return render_template('changeimagehospitals.html')
@bus.route('/changeimagehos',methods=['POST'])
def changeimagehos():
    rid=session["id"]
    fileupload = request.files['fileField']
    fi = secure_filename(fileupload.filename)
    fileupload.save(os.path.join("static/images", fi))
    cmd.execute("update hospital_details set fi='"+fi+"' where id ='"+rid+"'")
    con.commit()
    return '''<script>alert("image updated");window.location='/viewhospital'</script>'''
@bus.route('/addpolice')
def addpolice():

    return render_template('policestationreg.html')
@bus.route('/addpolicdetails', methods=['post'])
def addpolicdetails():
    pstn_name = request.form["pstn_name"]
    stn_plc = request.form["stn_plc"]
    mob = request.form["mob"]
    lati = request.form["lati"]
    longi = request.form["longi"]
    sid = request.form["sid"]


    cmd.execute( "insert into police_details values(null,'" + pstn_name + "','" + stn_plc + "','" + mob + "','" + lati + "','" + longi + "','" + sid + "')")
    con.commit()
    return '''<script>alert("inserted successfully");window.location="viewbus"</script>'''
@bus.route('/viewpolice')
def viewpolice():
    cmd.execute("select * from police_details")
    result = cmd.fetchall()
    print(result)
    return render_template("policeview.html",value=result)
@bus.route("/deletepolice")
def deletepolice():
    id = request.args.get("id")
    print(id)
    cmd.execute("DELETE FROM police_details WHERE id='" + str(id) + "'")
    con.commit()
    return '''<script>alert("bus deleted successfully");window.location="/viewpolice"</script>'''
@bus.route("/editpolice")
def editpolice():
    rid=request.args.get("id")
    session["id"]=rid
    print(rid)
    cmd.execute("select * from police_details where id='"+str(rid)+"'")
    an=cmd.fetchone()
    print(an)
    return render_template("updatepolice.html",value=an)
@bus.route("/updatepolicedetails",methods=['post'])
def updatepolicedetails():
    rid=session["id"]
    pstn_name = request.form["po_name"]
    stn_plc = request.form["ps_plc"]
    monb = request.form["monb"]
    lati = request.form["lati"]
    longi = request.form["longi"]
    sid = request.form["sid"]
    cmd.execute( "UPDATE police_details SET pstn_name='"+pstn_name+"',stn_plc='"+stn_plc+"', mob='"+monb+"', lati='"+lati+"',longi='"+longi+"',sid='"+sid+"'  WHERE id='"+rid+"'")
    con.commit()
    return '''<script>alert("updated successfully");window.location="/viewpolice"</script>'''
@bus.route('/blockvehiclefulldetails')
def blockvehiclefulldetails():

    cmd.execute("SELECT `bus_details`.*,`login`.* FROM `login` JOIN `bus_details` WHERE `bus_details`.`bus_loginid`=`login`.`id`")
    result=cmd.fetchall()
    print(result)
    return render_template('blockvehicle.html', value=result)
@bus.route('/blockvehicle')
def blockvehicle():
    did = request.args.get("id")
    print(did,'hhhhhhhhhhh')
    cmd.execute("UPDATE login SET user_type='blocked' WHERE id=%s", (did,))
    con.commit()
    return '''<script>alert("Successfully Blocked");window.location='/blockvehiclefulldetails'</script>'''
@bus.route('/unblockvehicle')
def unblockvehicle():
    cid = request.args.get("id")
    print(cid,'hhhhhhhhh')
    cmd.execute("UPDATE login SET user_type='bus' WHERE id=%s", (cid,))
    con.commit()
    return '''<script>alert("Successfully Unblocked");window.location='/blockvehiclefulldetails'</script>'''
@bus.route('/viewoverspeed')
def viewoverspeed():
    cmd.execute("SELECT * FROM accident_details WHERE speed >55")
    result=cmd.fetchall()
    return render_template('overspeedvechicle.html',value=result)
@bus.route('/sendNotification')
def sendNotification():
    ntid=request.args.get('id')
    print(ntid)
    session['nid']=ntid
    return render_template('sendnotif.html')


@bus.route('/sendnotif', methods=['POST'])
def sendnotif():
    nidd = session['nid']  # Fetch the nid from the session
    notification = request.form['notification']  # Get the notification from the form
    current_date = datetime.now().strftime('%Y-%m-%d')  # Get the current date in YYYY-MM-DD format

    try:
        # Insert data into the notification_table
        query = "INSERT INTO notification_table VALUES (NULL, %s, %s, %s)"
        cmd.execute(query, (current_date, notification, nidd))
        con.commit()
        return '''<script>alert("Successfully sent");window.location='/viewoverspeed'</script>'''
    except Exception as e:
        con.rollback()  # Rollback in case of error
        print(f"Error: {e}")
        return '''<script>alert("Error occurred");window.location='/viewoverspeed'</script>'''
@bus.route('/accidentdetails')
def accidentdetails():
    cmd.execute("select * from accident_details ")
    result=cmd.fetchall()
    return render_template('accidentdetails.html',value=result)
@bus.route('/viewcomplaints')
def viewcomplaints():
    cmd.execute("SELECT `registration`.*,`complaints`.* FROM `complaints` JOIN `registration` ON `complaints`.`user_id`=`registration`.`loginid`")
    result=cmd.fetchall()
    print(result)
    return render_template('viewcomplaints.html',value=result)
@bus.route('/sendreplay')
def sendreplay():
    cid=request.args.get('id')
    print(cid,'kkkkkkkkk')
    session['cid']=cid
    return render_template('sendreplay.html')
@bus.route('/sendreplays',methods=['post'])
def sendreplays():
    comid=session['cid']
    print(comid)
    replay=request.form['replay']
    print(replay)
    cmd.execute("update complaints set replay='"+str(replay)+"' where id='"+str(comid)+"'")
    con.commit()
    return '''<script>alert("sent");window.location="/viewcomplaints"</script>'''
@bus.route('/deletecomplaints')
def deletecomplaints():
    cid= request.args.get("id")
    cmd.execute("delete from complaints  where id='"+str(cid)+"'")
    con.commit()
    return '''<script>alert("Deleted");window.location="/viewcomplaints"</script>'''

bus.run(debug=True)