
import 'package:bus_safety/presentation/busdetails.dart';
import 'package:bus_safety/services/busstopsapi.dart';
import 'package:bus_safety/services/searchbusesapi.dart';
import 'package:flutter/material.dart';

class Ticket extends StatefulWidget {
  const Ticket({super.key});

  @override
  State<Ticket> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  String? _selectedSource;
  String? _selectedDestination;
  DateTime? _selectedDate;
  List<Map<String, dynamic>> busList = [];

  @override
  void initState() {
    super.initState();
    fetchh();
  }

  void fetchh() async {
    await fetchLocations();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bus Ticket Booking',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 34, 63, 93),
        elevation: 4,
      ),
      body: Center( // Centering the form inside the screen
        child: Container(
          width: double.infinity, // Makes sure the container fills the width
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white, // Background color for the form
            borderRadius: BorderRadius.circular(12), // Rounded corners
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 2, blurRadius: 5),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Make column take up only necessary space
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Source Dropdown
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blueAccent),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedSource,
                      hint: Text('Select Source'),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                        
                        labelText: 'Source',
                      ),
                      items: sources.map((source) {
                        return DropdownMenuItem<String>(
                          value: source,
                          child: Text(source),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedSource = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Destination Dropdown
              Row(
                children: [
                  Icon(Icons.location_city, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: _selectedDestination,
                      hint: Text('Select Destination'),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                        
                        labelText: 'Destination',
                      ),
                      items: sources.map((destination) {
                        return DropdownMenuItem<String>(
                          value: destination,
                          child: Text(destination),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedDestination = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Date Picker
              GestureDetector(
                onTap: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != _selectedDate) {
                    setState(() {
                      _selectedDate = pickedDate;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: _selectedDate == null
                          ? 'Select Date'
                          : 'Selected Date: ${_selectedDate!.toLocal()}'.split(' ')[0],
                      suffixIcon: Icon(Icons.calendar_today),
                      contentPadding: EdgeInsets.symmetric(vertical: 12.0),
                    
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Search Button
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    busList = await searchbusapi(_selectedSource, _selectedDestination, _selectedDate, context);
                    print("buslist====$busList");
                
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BusTime(busList: busList),
                      ),
                    );
                  },
                  child: Text(
                    'Search Buses',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    textStyle: TextStyle(fontSize: 18),
                    backgroundColor: Color.fromARGB(255, 34, 63, 93),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  
                   minimumSize: Size(200.0, 50.0),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
