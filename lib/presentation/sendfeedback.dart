
import 'package:bus_safety/services/sendfeedbackapi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Sendfeedback extends StatefulWidget {
  const Sendfeedback({Key? key}) : super(key: key);

  @override
  State<Sendfeedback> createState() => _SendfeedbackState();
}

class _SendfeedbackState extends State<Sendfeedback> {
 TextEditingController _feedbackController = TextEditingController();

  
  ScrollController _listScrollController = ScrollController();

  
  //  List<Map<String, String>> previousComplaints = [];

  
  

  @override
  void dispose() {
    // Clean up controllers when the widget is disposed
    _feedbackController.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Send Feedback",style: TextStyle(color: Colors.white),),
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
                  controller: _feedbackController, // Assign controller here
                  maxLines: 6,
                  decoration: InputDecoration(
                    hintText: 'Enter your feedback here',
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
                color: Color.fromARGB(255, 16, 52, 92),
              ),
              child: TextButton(
                onPressed: () {
                  sendfeedback(_feedbackController.text,context); 
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
         
        ],
      ),
    );
  }
}
