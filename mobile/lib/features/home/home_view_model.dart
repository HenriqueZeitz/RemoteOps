import 'package:flutter/material.dart';
import 'package:mobile/core/storage/local_storage_service.dart';

class HomeViewModel extends ChangeNotifier {
  final _storageService = LocalStorageService();

  bool computerOnline = false;
  List<CommandCardModel> commandCards = [];

  HomeViewModel() {
    _loadCommands();
  }

  Future<void> addCommand(CommandCardModel command) async {
    commandCards.add(command);
    await _storageService.saveCommands(commandCards);
    notifyListeners();
  }

  Future<void> _loadCommands() async {
    commandCards = await _storageService.loadCommands();
    if (commandCards.isEmpty) {
      commandCards = _defaultCommands();
      await _storageService.saveCommands(commandCards);
    }
    notifyListeners();
  }

  void toggleComputerStatus() {
    computerOnline = !computerOnline;
    notifyListeners();
  }

  List<CommandCardModel> _defaultCommands() => [
        CommandCardModel(
          icon: Icons.code,
          title: 'Backend Projeto X',
          description: 'Iniciar backend',
          startCommand: 'start_projeto_x_backend',
          stopCommand: 'stop_projeto_x_backend',
        ),
        CommandCardModel(
          icon: Icons.gamepad,
          title: 'Servidor Minecraft',
          description: 'Iniciar servidor',
          startCommand: 'start_minecraft_server',
          stopCommand: 'stop_minecraft_server',
        ),
        CommandCardModel(
          icon: Icons.code,
          title: 'Frontend Projeto X',
          description: 'Iniciar forntend',
          startCommand: 'start_projeto_x_frontend',
          stopCommand: 'stop_projeto_x_frontend',
        ),
      ];
}

class CommandCardModel {
  final IconData icon;
  final String title;
  final String description;
  final String startCommand;
  final String stopCommand;
  final bool isRunning;

  CommandCardModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.startCommand,
    required this.stopCommand,
    this.isRunning = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'icon': icon.codePoint,
      'title': title,
      'description': description,
      'startCommand': startCommand,
      'stopCommand': stopCommand,
      'isRunning': isRunning,
    };
  }

  factory CommandCardModel.fromMap(Map<String, dynamic> map) {
    return CommandCardModel(
      icon: IconData(
        map['icon'],
        fontFamily: 'MaterialIcons'
      ),
      title: map['title'],
      description: map['description'],
      startCommand: map['startCommand'],
      stopCommand: map['stopCommand'],
      isRunning: map['isRunning'] ?? false,
    );
  }
}
