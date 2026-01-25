import 'package:mobile/core/api/api_response.dart';

abstract class CommandApi {

  Future<ApiResponse> executeCommand(String command, bool startCommand);
  Future<ApiResponse> powerOnComputer();
  Future<ApiResponse> powerOffComputer();
  Future<bool> checkAgentHealth();
  Future<bool> checkComputerOnline();
  Future<Map<String, String>> getCommandsStatus(List<String> commands);
}