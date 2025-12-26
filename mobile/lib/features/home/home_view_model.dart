import 'package:flutter/material.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:uuid/uuid.dart';

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
      ];
}

class CommandCardModel {
  final String id;
  final IconData icon;
  final String title;
  final String description;
  final String startCommand;
  final String stopCommand;
  final bool isRunning;

  CommandCardModel({
    String? id,
    required this.icon,
    required this.title,
    required this.description,
    required this.startCommand,
    required this.stopCommand,
    this.isRunning = false,
  }) : id = id ?? const Uuid().v4();

  CommandCardModel copyWith({
    IconData? icon,
    String? title,
    String? description,
    String? startCommand,
    String? stopCommand,
    bool? isRunning,
  }) {
    return CommandCardModel(
      id: id,
      icon: icon ?? this.icon,
      title: title ?? this.title,
      description: description ?? this.description,
      startCommand: startCommand ?? this.startCommand,
      stopCommand: stopCommand ?? this.stopCommand,
      isRunning: isRunning ?? this.isRunning,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      id: map['id'],
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
