
// ignore_for_file: depend_on_referenced_packages

// import 'package:bussafety/Api/profileupdateapi.dart';
import 'package:dio/dio.dart';

final String baseUrl="http://192.168.0.118:8000";
final dio = Dio();

Future<void> regapi(data) async {
  try {

    Response response = await dio.post('$baseUrl/user',data: data);
   

    // Response response = await dio.post('${apidata}/login?email=${email},password=${Password}');
    print(response);
    print(response.statusCode);
    if (response.statusCode == 200) {
     print('success');
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
