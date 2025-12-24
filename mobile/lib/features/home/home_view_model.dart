import 'package:flutter/material.dart';

class HomeViewModel extends ChangeNotifier {
  bool computerOnline = false;

  void toggleComputerStatus() {
    computerOnline = !computerOnline;
    notifyListeners();
  }

  List<CommandCardModel> get commands => [
        CommandCardModel(
          icon: Icons.code,
          title: 'Backend Projeto X',
          description: 'Iniciar backend',
          isRunning: false,
        ),
        CommandCardModel(
          icon: Icons.gamepad,
          title: 'Servidor Minecraft',
          description: 'Iniciar servidor',
          isRunning: true,
        ),
      ];
}

class CommandCardModel {
  final IconData icon;
  final String title;
  final String description;
  final bool isRunning;

  CommandCardModel({
    required this.icon,
    required this.title,
    required this.description,
    required this.isRunning,
  });
}
