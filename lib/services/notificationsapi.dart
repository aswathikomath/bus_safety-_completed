
import 'package:bus_safety/services/loginpageapi.dart';
import 'package:bus_safety/services/registrationapi.dart';
import 'package:dio/dio.dart';


final dio = Dio();

Future<List<Map<String, dynamic>>> bus_notificationss() async {
  try {
     final response = await dio.get('${baseUrl}/bus_notifications?lid=$lid');
     print(response.data);
    if (response.statusCode == 200) {
      List<dynamic> bus_notif = response.data;
      print(bus_notif);
      return List<Map<String, dynamic>>.from(bus_notif);
    } else {
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}
