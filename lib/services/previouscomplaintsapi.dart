import 'package:bus_safety/services/loginpageapi.dart';
import 'package:bus_safety/services/registrationapi.dart';

import 'package:dio/dio.dart';

final dio = Dio();
List<Map<String, dynamic>> complaints = [];
Future<void> previouscomplaints() async {
  try {
    final response = await dio.get('${baseUrl}/previouscomplaints', queryParameters: {'lid': lid});
    if (response.statusCode == 200) {
      List<dynamic> data = response.data['complaints'];  // Make sure you're accessing the correct key
      complaints = data.map((item) => item as Map<String, dynamic>).toList();
    } else {
      print('Failed to load complaints, status code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
  