import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/api/command_api.dart';
import 'package:mobile/core/api/http_command_api.dart';
import 'package:mobile/core/api/mock_command_api.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:mobile/features/home/models/command_card_model.dart';

const bool USE_MOCK_API = false;

class HomeViewModel extends ChangeNotifier {
  bool isConfigured = false;
  final _storageService = LocalStorageService();
  late final CommandApi _commandApi;

  bool computerOnline = false;
  bool isExecutingCommand = false;
  List<CommandCardModel> commandCards = [];

  HomeViewModel() {
    _initialize();
  }

  Future<void> _initialize() async {
    final settings = await _storageService.loadSettings();

    if (settings['ip'] != null && settings['token'] != null) {
      final defaultIp = kDebugMode ? "10.0.2.2" : settings['ip'];
      _commandApi = USE_MOCK_API 
        ? MockCommandApi()
        : HttpCommandApi(
          baseUrl: "http://${defaultIp}:8000",
          token: settings['token']!,
        );
      isConfigured = true;
      await _loadCommands();
      await checkAllStatuses();
    } else {
      isConfigured = false;
    }
    notifyListeners();
  }

  Future<void> updateSettings(String ip, String token) async {
    await _storageService.saveSettings(ip, token);
    await _initialize();
  }

  Future<void> checkAllStatuses() async {
    computerOnline = await _commandApi.checkAgentHealth();
    notifyListeners();

    if (computerOnline && commandCards.isNotEmpty) {
      final serviceNames = commandCards.map((c) => c.service).toList();
      final statuses = await _commandApi.getCommandsStatus(serviceNames);

      if (statuses.isNotEmpty) {
        commandCards = commandCards.map((card) {
          final status = statuses[card.service];
          return card.copyWith(isRunning: status == 'running');
        }).toList();

        await _storageService.saveCommands(commandCards);
        notifyListeners();
      }
    }
  }

  Future<void> addCommand(CommandCardModel command) async {
    commandCards.add(command);
    await _storageService.saveCommands(commandCards);
    notifyListeners();
  }

  Future<void> removeCommand(String id) async {
    commandCards.removeWhere((c) => c.id == id);
    await _storageService.saveCommands(commandCards);
    notifyListeners();
  }

  Future<void> updateCommand(CommandCardModel updated) async {
    final index = commandCards.indexWhere((c) => c.id == updated.id);
    if (index == -1) return;

    commandCards[index] = updated;
    await _storageService.saveCommands(commandCards);
    notifyListeners();
  }

  Future<void> _loadCommands() async {
    commandCards = await _storageService.loadCommands();
    notifyListeners();
  }

  Future<void> executeCommand(CommandCardModel command) async {
    if (!computerOnline || isExecutingCommand) return;

    toggleExecutingState();

    await _commandApi
      .executeCommand(
        command.service,
        !command.isRunning
      )
      .then((response) async {
        if (response.success) {
          debugPrint('✅ ${response.message}');
          final updatedCommand = command.copyWith(isRunning: !command.isRunning);
          await updateCommand(updatedCommand);
        } else {
          debugPrint('❌ ${response.message}');
        }
      });

    toggleExecutingState();
  }

  void toggleExecutingState() {
    isExecutingCommand = !isExecutingCommand;
    notifyListeners();
  }

  void powerOnComputer() async {
    final response = await _commandApi.powerOnComputer();
    if (response.success) {
      computerOnline = true;
      notifyListeners();
      Future.delayed(const Duration(seconds: 5), () => checkAllStatuses());
    }
  }

  void powerOffComputer() {
    computerOnline = false;
    commandCards = commandCards
      .map((c) => c.copyWith(isRunning: false))
      .toList();
    notifyListeners();
  }
}