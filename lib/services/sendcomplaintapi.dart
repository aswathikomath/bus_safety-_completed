
import 'package:bus_safety/presentation/send%20complaint.dart';
import 'package:bus_safety/services/loginpageapi.dart';
import 'package:bus_safety/services/registrationapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();


Future<void> sendComplaint(complaint,context) async {
  try {
    print(lid);
    final response =
        await dio.post('$baseUrl/sendComplaint?complaint=$complaint&lid=$lid');
    print(response.data);
    
    if (response.statusCode == 200 || response.statusCode == 201) {
     
     
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Complaint sent successfully'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder: (context) =>SendComplaint()),);
    
    } else {
      print('failed');
    }
  } catch (e) {
    print('Error: $e');
  }
}
