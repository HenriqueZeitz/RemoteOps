import 'package:flutter/material.dart';
import 'package:mobile/features/home/home_view_model.dart';
import 'package:provider/provider.dart';

class AddCommandDialog extends StatefulWidget {
  final HomeViewModel viewModel;

  const AddCommandDialog({super.key, required this.viewModel});

  @override
  State<AddCommandDialog> createState() => _AddCommandDialogState();
}

class _AddCommandDialogState extends State<AddCommandDialog> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _startCommandController = TextEditingController();
  final _stopCommandController = TextEditingController();

  IconData _selectedIcon = Icons.smart_toy_outlined;

  final _icons = [
    Icons.smart_toy_outlined,
    Icons.computer_outlined,
    Icons.code_outlined,
    Icons.gamepad_outlined,
    Icons.cloud_outlined,
    Icons.storage_outlined,
    Icons.router_outlined,
    Icons.security_outlined,
    Icons.terminal_outlined,
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Novo comando'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            TextField(
              controller: _startCommandController,
              decoration: const InputDecoration(labelText: 'Comando de Início'),
            ),
            TextField(
              controller: _stopCommandController,
              decoration: const InputDecoration(labelText: 'Comando de Parada'),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: _icons.map((icon) {
                final isSelected = icon == _selectedIcon;
                return InkWell(
                  borderRadius: BorderRadius.circular(8),
                  onTap: () => setState(() => _selectedIcon = icon),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.orange : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(icon),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: const Text('Salvar'),
        ),
      ]
    );
  }

  void _save() {
    if (_titleController.text.isEmpty ||
        _startCommandController.text.isEmpty ||
        _stopCommandController.text.isEmpty) return;
    
    widget.viewModel.addCommand(
      CommandCardModel(
        icon: _selectedIcon,
        title: _titleController.text,
        description: _descriptionController.text,
        startCommand: _startCommandController.text,
        stopCommand: _stopCommandController.text,
        isRunning: false,
      ),
    );

    Navigator.pop(context);
  }
}