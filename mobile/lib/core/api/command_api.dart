import 'package:mobile/core/api/api_response.dart';

abstract class CommandApi {
  Future<ApiResponse> executeCommand(String command);
}