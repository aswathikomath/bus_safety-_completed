
import 'package:bus_safety/services/loginpageapi.dart';
import 'package:bus_safety/services/registrationapi.dart';
import 'package:dio/dio.dart';


final dio = Dio();

Future<List<Map<String, dynamic>>> bookingstatuses() async {
  try {
    final response = await dio.get('${baseUrl}/bookingstatus?lid=$lid');
    print(response.data);

    if (response.statusCode == 200) {
      // Ensure the response is a map and access the bookingdetails key
      if (response.data is Map<String, dynamic>) {
        // Access the 'bookingdetails' key which contains the list
        List<dynamic> booking_sts = response.data['bookingdetails'];
        print(booking_sts);
        return List<Map<String, dynamic>>.from(booking_sts);
      } else {
        return [];
      }
    } else {
      return [];
    }
  } catch (e) {
    print('Error: $e');
    return [];
  }
}