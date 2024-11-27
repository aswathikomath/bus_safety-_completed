
import 'package:bus_safety/presentation/bushome.dart';
import 'package:bus_safety/presentation/homepage.dart';
import 'package:bus_safety/services/registrationapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();
int? lid;
String? userType;
String? loginstatus;

Future<void> loginapi (username, password, context) async {
  try {
    final response = await dio.get('${baseUrl}/logincheck?email=${username}&password=${password}');
    print(response.data); 
    int? res = response.statusCode;

    loginstatus = response.data['task'] ?? 'failed';
    
    if (res == 200 && response.data['task'] == 'success') {
      userType = response.data['type'];
      lid = response.data['lid'];

      // Check if the user is blocked
      if (userType == 'blocked') {
        // Show alert dialog if the user is blocked
        _showBlockedDialog(context);
      } else if (userType == 'bus') {
        // Navigate to the BusSpeedGauge page for 'bus' user
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => BusSpeedGauge()));
      } else if (userType == 'user') {
        // Navigate to HomePage for normal user
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (ctx) => HomePage()));
      } else {
        // Handle unknown userType
        print('Unknown userType: $userType');
      }
    } else {
      print('Login failed');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// Show an alert dialog if the user is blocked
void _showBlockedDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Account Blocked'),
        content: Text('You are blocked.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}
