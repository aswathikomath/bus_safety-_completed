
import 'package:bus_safety/presentation/profileditpage.dart';
import 'package:flutter/material.dart';

class userprofilepage extends StatefulWidget {
  const userprofilepage({super.key,required this.profileData});
  final profileData;
  

  @override
  State<userprofilepage> createState() => _userprofilepageState();
}

class _userprofilepageState extends State<userprofilepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text("Profile",style: TextStyle(color: Colors.white),),
         backgroundColor: Color.fromARGB(255, 34, 63, 93),
        actions: [
          IconButton(
            onPressed: () async{
              // Navigate to the edit profile page
             
   Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProfileEditPage(profileData: widget.profileData), // Pass the current profile data
    ),
  );



            },
            icon: Icon(Icons.edit,color:Colors.white,),
          ),
        ],
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 40),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 2),
              Text(
                "Name",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                (widget.profileData['name'].toString()),
                 style: TextStyle(color: Colors.green, fontSize: 15),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 2),
              Text(
                "Date Of Birth",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                 (widget.profileData['dob'].toString()),
                style: TextStyle(color: Colors.green, fontSize: 15),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 2),
              Text(
                "Gender",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                (widget.profileData['gender'].toString()),
                 style: TextStyle(color: Colors.green, fontSize: 15),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 2),
              Text(
                "Marital Status",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                (widget.profileData['mstatus'].toString()),
                 style: TextStyle(color: Colors.green, fontSize: 15),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 2),
              Text(
                "Phone",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                (widget.profileData['phone'].toString()),
                 style: TextStyle(color: Colors.green, fontSize: 15),
                textAlign: TextAlign.right,
              ),
               SizedBox(height: 2),
               Text(
                "Guardian",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                (widget.profileData['gurd'].toString()),
                 style: TextStyle(color: Colors.green, fontSize: 15),
                textAlign: TextAlign.right,
              ),
               
              
              SizedBox(
                width: 40,
              ),
              SizedBox(height: 2),
              Text(
                "proof",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              ),
              SizedBox(
                width: 40,
              ),
              Text(
                (widget.profileData['type'].toString()),
                 style: TextStyle(color: Colors.green, fontSize: 15),
                textAlign: TextAlign.right,
              ),
             
             
            ],
          ),
        ],
      ),
    );
  }
}
