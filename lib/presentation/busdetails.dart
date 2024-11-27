import 'package:bus_safety/presentation/payment.dart';

import 'package:flutter/material.dart';

class BusTime extends StatefulWidget {
  const BusTime({super.key, required this.busList});

  final List<Map<String, dynamic>> busList;

  @override
  State<BusTime> createState() => _BusTimeState();
  
}

class _BusTimeState extends State<BusTime> {
  @override
  Widget build(BuildContext context) {
     debugPrint("Bus List: ${widget.busList}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Bus Ticket Information', style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 34, 63, 93),
      ),
      body: widget.busList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: widget.busList.length,
                itemBuilder: (context, index) {
                  final bus = widget.busList[index];
                  return Card(
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bus Details',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: const Color.fromARGB(255, 7, 44, 75)),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text('Bus Name: ${bus['bus_name']}', style: TextStyle(fontSize: 16))),
                              const SizedBox(width: 10),
                              Text('Departure: ${bus['departure']}', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text('Starting Place: ${bus['from']}', style: TextStyle(fontSize: 16)),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Fare:', style: TextStyle(fontSize: 16)),
                              Text(bus['fare'] != null ? '\$${bus['fare']}' : 'N/A', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentScreen(busList: widget.busList[index]),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 34, 63, 93),// Button color
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              minimumSize: Size(200.0, 50.0)
                            ),
                            child: Text('Book Your Ticket', style: TextStyle(fontSize: 16,color:Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          : Center(child: Text('No bus details available.', style: TextStyle(fontSize: 18))),
    );
  }
}



