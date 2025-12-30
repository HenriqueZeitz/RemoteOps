import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/api/api_response.dart';
import 'package:mobile/core/api/command_api.dart';

class HttpCommandApi implements CommandApi {
  static final _backendIp = dotenv.env['BACKEND_IP'];
  static final _token = dotenv.env['BACKEND_API_KEY'];
  static final String _baseUrl = 'http://$_backendIp:8000';

  @override
  Future<ApiResponse> executeCommand(String command) async {
    try {
      final uri = Uri.parse('$_baseUrl/commands/execute');

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'command': command
        })
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          success: true,
          message: data['message'] ?? 'Computer powered on',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          success: false,
          message: data['message'] ?? 'Backend error',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Connection error: $e'
      );
    }
  }

  @override
  Future<ApiResponse> powerOnComputer() async {
    try {
      final uri = Uri.parse('$_baseUrl/computer/power/on');

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $_token',
          'Content-Type': 'application/json',
        }
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return ApiResponse(
          success: true,
          message: data['message'] ?? 'Command executed',
        );
      } else {
        final data = jsonDecode(response.body);
        return ApiResponse(
          success: false,
          message: data['message'] ?? 'Backend error',
        );
      }
    } catch (e) {
      return ApiResponse(
        success: false,
        message: 'Connection error: $e'
      );
    }
  }
}