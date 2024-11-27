// ignore_for_file: depend_on_referenced_packages


import 'package:bus_safety/services/registrationapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


final dio = Dio();



Future<List<Map<String, dynamic>>> searchbusapi(String? source, String? destination, DateTime? date, BuildContext context) async {
  try {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Searching for buses...')),
    );

    final response = await dio.post('${baseUrl}/businfo?source=$source&destination=$destination&date=${date?.toIso8601String()}');
    print('Response data: ${response.data}');
    print('Status Code: ${response.statusCode}');

    if (response.statusCode == 200) {
      if (response.data is Map<String, dynamic> && response.data['busDetails'] is List) {
        List<dynamic> busdetails = response.data['busDetails'];
        List<Map<String, dynamic>> buslistdata = List<Map<String, dynamic>>.from(busdetails);

        print('Bus details: $buslistdata');
        return buslistdata;
      } else {
        print('Error: Unexpected response format');
        return [];
      }
    } else {
      print('Error: Request failed with status code ${response.statusCode}');
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
