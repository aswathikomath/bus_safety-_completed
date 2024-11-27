
import 'package:bus_safety/services/deletecomplaintapi.dart';
import 'package:bus_safety/services/previouscomplaintsapi.dart';
import 'package:bus_safety/services/sendcomplaintapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class SendComplaint extends StatefulWidget {
  const SendComplaint({Key? key}) : super(key: key);

  @override
  State<SendComplaint> createState() => _SendComplaintState();
}

class _SendComplaintState extends State<SendComplaint> {
 TextEditingController _complaintController = TextEditingController();

  
  ScrollController _listScrollController = ScrollController();

  
  //  List<Map<String, String>> previousComplaints = [];

  @override
  void initState() {
    
    super.initState();
    getdata();
  }
  
  void getdata()async{
    await previouscomplaints();
    setState(() {
      
    });
  }

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _complaintController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Complaint",style: TextStyle(color: Colors.white),),
       backgroundColor: Color.fromARGB(255, 34, 63, 93),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 50),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 200,
                width: double.maxFinite,
                child: TextFormField(
                  controller: _complaintController, // Assign controller here
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Enter your complaint here',
                    contentPadding: EdgeInsets.fromLTRB(4, 10, 4, 0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 3),
          Center(
            child: Container(
              height: 30,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromARGB(255, 24, 36, 90),
              ),
              child: TextButton(
                onPressed: () {
                  sendComplaint(_complaintController.text,context); 
                  // Handle sending complaint (if needed)
                },
                child: Center(
                  child: Text(
                    "Send",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 80),
          
          Expanded(
            
            child: ListView.builder(
              
              itemCount: complaints.length,
              controller: _listScrollController, // Assign controller here
              scrollDirection: Axis.vertical,
              // itemCount: complaints.length,
              itemBuilder: (BuildContext context, int index) {
                 print(complaints); 
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                             'Complaint Date: ${complaints[index]['date']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                             ),
                            SizedBox(height: 8),
                          Text(
                             'Complaint: ${complaints[index]['complaint']}',
                            // // ),
                            
                            
                        )],
                        ),
                      ),
                      ButtonBar(
                        children: [
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 24, 61, 92),
                            ),
                            child: TextButton(
                              onPressed: ()async {
                                
                                deleteComplaints(context,complaints[index]['id']);
      
                                // setState(() {
                                //    complaints.removeAt(index);
                                // });
                                
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 250, 248, 248),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
