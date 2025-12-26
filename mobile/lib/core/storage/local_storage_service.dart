import 'dart:convert';
import 'package:mobile/features/home/models/command_card_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _commandsKey = 'commands';

  Future<void> saveCommands(List<CommandCardModel> commands) async {
    final  prefs = await SharedPreferences.getInstance();
    final jsonList = commands.map((c) => c.toMap()).toList();
    await prefs.setString(_commandsKey, jsonEncode(jsonList));
  }

  Future<List<CommandCardModel>> loadCommands() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_commandsKey);

    if (jsonString == null) {
      return [];
    }

    final List decoded = jsonDecode(jsonString);
    return decoded.map((e) => CommandCardModel.fromMap(e)).toList();
  }
}