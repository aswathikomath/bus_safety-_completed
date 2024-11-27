
import 'package:bus_safety/services/loginpageapi.dart';
import 'package:bus_safety/services/registrationapi.dart';
import 'package:dio/dio.dart';


final dio = Dio();

Future<List<Map<String, dynamic>>> bus_data() async {
  try {
     final response = await dio.get('${baseUrl}/bus_data?lid=$lid');
    print(response.data);
    if (response.statusCode == 200) {
      List<dynamic> bus_details = response.data;
      List<Map<String, dynamic>> bus_detailss =
          List<Map<String, dynamic>>.from(bus_details);
      return bus_detailss;
    } else {
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
