import 'package:flutter/material.dart';
import 'package:mobile/core/api/command_api.dart';
import 'package:mobile/core/api/http_command_api.dart';
import 'package:mobile/core/api/mock_command_api.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:mobile/features/home/models/command_card_model.dart';

const bool USE_MOCK_API = false;

class HomeViewModel extends ChangeNotifier {
  final _storageService = LocalStorageService();
  late final CommandApi _commandApi;

  bool computerOnline = false;
  bool isExecutingCommand = false;
  List<CommandCardModel> commandCards = [];

  HomeViewModel() {
    _commandApi = USE_MOCK_API ? MockCommandApi() : HttpCommandApi();

    _loadCommands();
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

    final response = await _commandApi.executeCommand(
      command.isRunning ? command.stopCommand : command.startCommand
    );

    if (response.success) {
      debugPrint('✅ ${response.message}');
      final updatedCommand = command.copyWith(isRunning: !command.isRunning);
      await updateCommand(updatedCommand);
    } else {
      debugPrint('❌ ${response.message}');
    }

    toggleExecutingState();
  }

  void toggleExecutingState() {
    isExecutingCommand = !isExecutingCommand;
    notifyListeners();
  }

  void powerOnComputer() async {
    await _commandApi.powerOnComputer();
    computerOnline = !computerOnline;
    notifyListeners();
  }

  void powerOffComputer() {
    computerOnline = false;
    commandCards = commandCards
      .map((c) => c.copyWith(isRunning: false))
      .toList();
    notifyListeners();
  }
}