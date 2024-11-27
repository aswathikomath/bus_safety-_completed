import 'dart:convert';


import 'package:bus_safety/services/registrationapi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

final dio = Dio();
  List<String> sources = [];
  // List<String> _destinations = [];
Future<void> fetchLocations() async {
    try {
      // Replace with your API endpoint
      final response = await dio.post('${baseUrl}/locations?');

      if (response.statusCode == 200) {
        final data = response.data;
        Set<String> filtereditems={};
        print(filtereditems);

        for(Map<String,dynamic>item in data){
          if (item['from']!=null) {
           filtereditems.add(item['from']); 
          }
           if (item['to']!=null) {
           filtereditems.add(item['to']); 
          }


        }
        print(filtereditems);
        if (filtereditems.length==0) {
          filtereditems.add('select option');
        }
        // setState(() {
          sources = filtereditems.toList();
          print(sources);
          // _destinations = List<String>.from(data['to']);
        // });
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      // Handle errors here
      print(e);
      // ScaffoldMessenger.of().showSnackBar(
      //   SnackBar(content: Text('Error fetching locations')),
      // );
    }
  }
  
 