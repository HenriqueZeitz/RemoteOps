import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/api/command_api.dart';
import 'package:mobile/core/api/http_command_api.dart';
import 'package:mobile/core/api/mock_command_api.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:mobile/features/home/models/command_card_model.dart';

const bool USE_MOCK_API = false;

class HomeViewModel extends ChangeNotifier with WidgetsBindingObserver {
  final _storageService = LocalStorageService();
  CommandApi? _commandApi;

  bool isConfigured = false;
  bool computerOnline = false;
  bool agentOnline = false;
  bool isExecutingCommand = false;
  List<CommandCardModel> commandCards = [];

  Timer? _statusTimer;
  final Duration _checkInterval = const Duration(seconds: 30);

  HomeViewModel() {
    WidgetsBinding.instance.addObserver(this);
    _initialize();
  }

  @override
  void dispose() {
    stopStatusMonitoring();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) stopStatusMonitoring();
    else if (state == AppLifecycleState.resumed) startStatusMonitoring();
  }

  Future<void> _initialize() async {
    final settings = await _storageService.loadSettings();

    if (settings['ip'] != null && settings['token'] != null) {
      final defaultIp = kDebugMode ? "10.0.2.2" : settings['ip'];
      // final defaultIp = settings['ip'];
      _commandApi = USE_MOCK_API 
        ? MockCommandApi()
        : HttpCommandApi(
          baseUrl: "http://${defaultIp}:8000",
          token: settings['token']!,
        );
      isConfigured = true;
      await _loadCommands();
      startStatusMonitoring();
      await checkAllStatuses();
      notifyListeners();
    } else {
      isConfigured = false;
      notifyListeners();
    }
  }

  void startStatusMonitoring() {
    _statusTimer?.cancel();
    _statusTimer = Timer.periodic(_checkInterval, (timer) {
      if (isConfigured && !isExecutingCommand) checkAllStatuses();
    });
  }

  void stopStatusMonitoring() {
    _statusTimer?.cancel();
    _statusTimer = null;
  }

  Future<void> updateSettings(String ip, String token) async {
    await _storageService.saveSettings(ip, token);
    await _initialize();
  }

  Future<void> checkAllStatuses() async {
    if (_commandApi == null) return;

    try {
      computerOnline = await _commandApi!.checkComputerOnline();
      agentOnline = await _commandApi!.checkAgentHealth();

      if (computerOnline && agentOnline && commandCards.isNotEmpty) {
        final serviceNames = commandCards.map((c) => c.service).toList();
        final statuses = await _commandApi!.getCommandsStatus(serviceNames);

        if (statuses.isNotEmpty) {
          commandCards = commandCards.map((card) {
            final status = statuses[card.service];
            return card.copyWith(isRunning: status == 'running');
          }).toList();

          await _storageService.saveCommands(commandCards);
        }
      }
    } catch (e) {
      computerOnline = false;
      agentOnline = false;
    }
    notifyListeners();
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
    if (!computerOnline || !agentOnline || isExecutingCommand) return;

    toggleExecutingState();

    await _commandApi!
      .executeCommand(
        command.service,
        !command.isRunning
      )
      .then((response) async {
        if (response.success) {
          final updatedCommand = command.copyWith(isRunning: !command.isRunning);
          await updateCommand(updatedCommand);
        }
      });

    toggleExecutingState();
  }

  void toggleExecutingState() {
    isExecutingCommand = !isExecutingCommand;
    notifyListeners();
  }

  void powerOnComputer() async {
    if (isExecutingCommand) return;

    toggleExecutingState();
    try {
      await _commandApi!.powerOnComputer().then((response) {
        if (response.success) {
            Future.delayed(const Duration(seconds: 5), () => checkAllStatuses());
        }
      });
    } finally {
      toggleExecutingState();
    }
  }

  void powerOffComputer() async {
    if (isExecutingCommand) return;

    toggleExecutingState();
    try {
      await _commandApi!.powerOffComputer()
        .then((response) {
          if (response.success) {
            computerOnline = false;
            commandCards = commandCards
              .map((c) => c.copyWith(isRunning: false))
              .toList();
            notifyListeners();
          }
        });
    } finally {
      toggleExecutingState();
    }
  }
}