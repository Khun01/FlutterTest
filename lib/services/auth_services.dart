import 'dart:convert';
import 'dart:developer';
import 'package:app_for_testing/services/global.dart';
import 'package:app_for_testing/services/storage.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  final String apiUrl;

  AuthServices({required this.apiUrl});

  Future<Map<String, dynamic>> loginProf(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login-prof'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    log('User data: $responseData');
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }

  Future<void> logout() async{
    final userData = await Storage.getProfData();
    String? token = userData['token'];
    final response = await http.post(
      Uri.parse('$baseUrl/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      }
    ); 
    final Map<String, dynamic> responseData = jsonDecode(response.body);
    log('User data: $responseData');
  }

  
}