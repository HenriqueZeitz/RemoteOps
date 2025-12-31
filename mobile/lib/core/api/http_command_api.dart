import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/core/api/api_response.dart';
import 'package:mobile/core/api/command_api.dart';

class HttpCommandApi implements CommandApi {
  final String baseUrl;
  final String token;
  // static final _backendIp = kDebugMode ? "10.0.2.2" : dotenv.env['BACKEND_IP'];
  // static final _token = dotenv.env['BACKEND_API_KEY'];
  // static final String _baseUrl = 'http://$_backendIp:8000';

  HttpCommandApi({required this.baseUrl, required this.token});

  @override
  Future<ApiResponse> executeCommand(String command, bool startCommand) async {
    try {
      final uri = Uri.parse('$baseUrl/commands/execute');

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'command': command,
          'start_command': startCommand,
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
      final uri = Uri.parse('$baseUrl/computer/power/on');

      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
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

  @override
  Future<bool> checkAgentHealth() async {
    try {
      final uri = Uri.parse('$baseUrl/agent/health');
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        }
      );

      if (response.statusCode == 200) {
        final data =jsonDecode(response.body);
        return data['status'] == 'ok';
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<Map<String, String>> getCommandsStatus(List<String> commands) async {
    try {
      final uri = Uri.parse('$baseUrl/commands/status');
      final response = await http.post(
        uri,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'commands': commands})
      );

      if (response.statusCode == 200) {
        final json =jsonDecode(response.body);
        if (json['status'] == 'success') {
          return Map<String, String>.from(json['data']);
        }
      }
      return {};
    } catch (e) {
      debugPrint('Erro ao buscar status: $e');
      return {};
    }
  }
}