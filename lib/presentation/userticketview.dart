import 'package:flutter/material.dart';

class BookingStatusPage extends StatelessWidget {
  final List<Map<String, dynamic>> bookingStatuses;

  // Constructor that takes the data as a parameter
  const BookingStatusPage({super.key, required this.bookingStatuses});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Status',style: TextStyle(color:Colors.white),),
         backgroundColor: Color.fromARGB(255, 34, 63, 93),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                SizedBox(height: 16),
                
                // Display the status list or any relevant information
                for (var status in bookingStatuses) 
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('From: ${status['from']}'),
                        Text('To: ${status['to']}'),
                        Text('Date: ${status['departure']}'),
                        
                        Divider(),
                        Text('Passenger: ${status['name']}'),
                        Text('Price: ${status['fare']}'),
                        Text('Amount Status: ${status['status']}'),
                        Divider(),
                      ],
                    ),
                  ),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: TextStyle(fontSize: 18),
                    backgroundColor: Color.fromARGB(255, 34, 63, 93),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  
                   minimumSize: Size(200.0, 50.0),),
                    onPressed: () {
                      // Navigate back
                      Navigator.pop(context);
                    },
                    child: Text('Go Back',style: TextStyle(color:Colors.white),),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
