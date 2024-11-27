
// ignore_for_file: depend_on_referenced_packages

import 'package:bus_safety/presentation/userprofile.dart';
import 'package:bus_safety/services/registrationapi.dart';
import 'package:bus_safety/services/userprofileviewapi.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


final dio = Dio();

Future<void> userupdatedata(data,context) async {
  try {

    Response response = await dio.post('$baseUrl/userupdate',data: data);
   

    // Response response = await dio.post('${apidata}/login?email=${email},password=${Password}');
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
     print('success');
      Map<String, dynamic> profileData = await userprofileview();
      print('object');
     Navigator.push(context, MaterialPageRoute(builder: (ctxt)=>userprofilepage(profileData:profileData )));
     
    } else { // List<dynamic> products = response.data;
      // List<Map<String, dynamic>> listdata =
      //     List<Map<String, dynamic>>.from(products);
      // return listdata;
      throw Exception('failed to get');
    }
  } catch (e) {
    print(e.toString());
    
  }
}
