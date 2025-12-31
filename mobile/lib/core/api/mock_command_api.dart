import 'dart:math';

import 'package:mobile/core/api/api_response.dart';
import 'package:mobile/core/api/command_api.dart';

class MockCommandApi implements CommandApi {
  final _random = Random();

  @override
  Future<ApiResponse> executeCommand(String command, bool startCommand) async {
    await Future.delayed(const Duration(seconds: 1));

    final hasError = _random.nextInt(10) < 3;

    if (hasError) {
      return ApiResponse(
        success: false,
        message: 'Falha ao executar o comando',
      );
    } else {
      return ApiResponse(
        success: true,
        message: 'Comando executado com sucesso',
      );
    }
  }

  @override
  Future<ApiResponse> powerOnComputer() async {
    await Future.delayed(const Duration(seconds: 1));

    final hasError = _random.nextInt(10) < 3;

    if (hasError) {
      return ApiResponse(
        success: false,
        message: 'Falha ao iniciar o computador',
      );
    } else {
      return ApiResponse(
        success: true,
        message: 'Computador iniciado com sucesso',
      );
    }
  }

  @override
  Future<bool> checkAgentHealth() async {
    return _random.nextBool();
  }

  @override
  Future<Map<String, String>> getCommandsStatus(List<String> commands) {
    throw UnimplementedError();
  }}