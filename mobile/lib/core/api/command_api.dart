import 'package:mobile/core/api/api_response.dart';

abstract class CommandApi {

  Future<ApiResponse> executeCommand(String command, bool startCommand);
  Future<ApiResponse> powerOnComputer();
  Future<bool> checkAgentHealth();
  Future<Map<String, String>> getCommandsStatus(List<String> commands);
}