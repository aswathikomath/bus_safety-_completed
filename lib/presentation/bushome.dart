
import 'package:bus_safety/presentation/login.dart';
import 'package:bus_safety/presentation/notificationpage.dart';
import 'package:bus_safety/services/bussppeddoorapi.dart';
import 'package:bus_safety/services/notificationsapi.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'dart:async';

class BusSpeedGauge extends StatefulWidget {
  final double initialSpeed = 0; // Initial speed value

  @override
  _BusSpeedGaugeState createState() => _BusSpeedGaugeState();
}

class _BusSpeedGaugeState extends State<BusSpeedGauge> {
  double currentSpeed = 0.0;
  bool isDoorOpen = false;
  bool isweighthigh = false;
  String? isDoorOpenval;
  String? isweighthighval;
  late Timer _timer; // Timer to periodically fetch the data

  @override
  void initState() {
    super.initState();
    _startPolling();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _startPolling();
    });
  }

  void _startPolling() async {
    // Simulate fetching the data from your bus API
    List<Map<String, dynamic>> data = await bus_data();
    print("data=$data");

    setState(() {
      // Parse the speed value to a double
      currentSpeed = double.parse(data[0]['speed'].toString());
      isDoorOpenval = data[0]['door_status'];
      if(isDoorOpenval=="opened"){
        isDoorOpen=true;
      }
      else{
        isDoorOpen=false;
      }
      isweighthighval = data[0]['weight_status'];
      if(isweighthighval=="low"){
        isweighthigh=false;
      }
      else{
        isweighthigh=true;
      }
    });

    // Trigger overweight alert if speed exceeds 80
    if (currentSpeed > 55) {
      // Optionally show overweight alert here if needed
    
    }
  }

 
  @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when widget is disposed
    super.dispose();
  }
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Are you sure?"),
          content: Text("Do you really want to logout?"),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _logout(); // Proceed with logout
              },
            ),
          ],
        );
      },
    );
  }

  // Logic for logging out
  void _logout() {
    // Here you can clear any user data or authentication tokens if necessary
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Login()), // Redirect to login page
    );
  }

  @override
  Widget build(BuildContext context) {
    // Determine the color based on speed
    Color gaugeColor = currentSpeed > 55 ? Colors.red : Colors.green;

    return Scaffold(
      appBar: AppBar(
        actions: [
//          IconButton(
//   icon: Icon(Icons.notifications), // This is the required icon parameter
//   onPressed: () async {
//     // Fetch notifications when the button is pressed
//     List<Map<String, dynamic>> notifications = await bus_notificationss();

//     // Navigate to NotificationsPage and pass the fetched data
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NotificationsPage(notifications: notifications),
//       ),
//     );
//   },
// ),
IconButton(onPressed: (){
  _showLogoutDialog();

}, icon: Icon(Icons.logout))

        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Radial Gauge for speed
            SfRadialGauge(
              axes: <RadialAxis>[
                RadialAxis(
                  minimum: 0,
                  maximum: 120,
                  interval: 10,
                  labelFormat: '{value} km/h',
                  pointers: <GaugePointer>[
                    NeedlePointer(
                      value: currentSpeed,
                      enableAnimation: true,
                      animationDuration: 1000,
                      needleColor: gaugeColor, // Set needle color based on speed
                    ),
                  ],
                  annotations: <GaugeAnnotation>[
                    GaugeAnnotation(
                      widget: Container(
                        child: Text(
                          '${currentSpeed.toStringAsFixed(1)} km/h',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      angle: 90,
                      positionFactor: 0.5,
                    ),
                  ],
                  axisLabelStyle: GaugeTextStyle(color: gaugeColor), // Optional: change label color
                ),
              ],
            ),
            SizedBox(height: 20),

            // Display bus door status
            Container(
              padding: EdgeInsets.all(16),
              color: isDoorOpen ? Colors.red : Colors.green,
              child: Text(
                isDoorOpen ? 'Bus Door: Opened' : 'Bus Door: Closed',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 30),
           Container(
  padding: EdgeInsets.all(16),
  color: isweighthigh ? Colors.red : Colors.green, // Corrected logic
  child: Text(
    isweighthigh ? 'Bus weight: High' : 'Bus weight: Low', // Corrected logic
    style: TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
)

          ],
        ),
      ),
    );
  }
}
