
import 'package:bus_safety/presentation/sendfeedback.dart';
import 'package:bus_safety/services/loginpageapi.dart';
import 'package:bus_safety/services/registrationapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();


Future<void> sendfeedback(feedback,context) async {
  try {
    print(lid);
    final response =
        await dio.post('$baseUrl/sendfeedback?feedback=$feedback&lid=$lid');
    print(response.data);
    
    if (response.statusCode == 200 || response.statusCode == 201) {
     
     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('sent successfully'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder: (context) =>Sendfeedback()),);
    
    } else {
      print('failed');
    }
  } catch (e) {
    print('Error: $e');
  }
}
