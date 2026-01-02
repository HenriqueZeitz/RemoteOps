import 'package:flutter/material.dart';
import 'package:mobile/core/storage/local_storage_service.dart';
import 'package:mobile/features/home/home_view_model.dart';

class ConfigSettingsDialog extends StatefulWidget {
  final HomeViewModel viewModel;

  const ConfigSettingsDialog({super.key, required this.viewModel});

  @override
  State<ConfigSettingsDialog> createState() => _ConfigSettingsDialogState();
}

class _ConfigSettingsDialogState extends State<ConfigSettingsDialog> {
  final _storage = LocalStorageService();
  final _ipController = TextEditingController();
  final _tokenController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadCurrentSettings();
  }

  Future<void> _loadCurrentSettings() async {
    final settings = await _storage.loadSettings();
    
    if (mounted) {
      setState(() {
        _ipController.text = settings['ip'] ?? '';
        _tokenController.text = settings['token'] ?? '';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _ipController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Row(
        children: [
          Icon(Icons.settings_remote, size: 20),
          SizedBox(width: 10),
          Text('Servidor'),
        ],
      ),
      content: _isLoading 
        ? const SizedBox(
            height: 100, 
            child: Center(child: CircularProgressIndicator())
          )
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _ipController,
                autofocus: true,
                decoration: const InputDecoration(
                  labelText: 'IP do Backend',
                  hintText: 'Ex: 192.168.0.1',
                  prefixIcon: Icon(Icons.lan),
                ),
                keyboardType: TextInputType.values[3],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _tokenController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'API Token',
                  hintText: 'Bearer Token',
                  prefixIcon: Icon(Icons.key),
                ),
              ),
            ],
          ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCELAR'),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : () {
            final ip = _ipController.text.trim();
            final token = _tokenController.text.trim();
            Navigator.pop(context);

            widget.viewModel.updateSettings(
              ip,
              token,
            );
          },
          child: const Text('SALVAR'),
        ),
      ],
    );
  }
}