
import 'package:bus_safety/presentation/send%20complaint.dart';
import 'package:bus_safety/services/registrationapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();

Future<void> deleteComplaints(BuildContext context,complaintid) async {
  try {
    final response = await dio.post('${baseUrl}/deletecomplaints?cid=$complaintid');
    
    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Complaint deleted successfully'),
          duration: Duration(seconds: 2), // Adjust the duration as needed
        ),
      );
      // Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SendComplaint()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete complaint'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $e'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
