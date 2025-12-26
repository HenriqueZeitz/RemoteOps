import 'package:flutter/material.dart';

class CommandContextMenu extends StatelessWidget{
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const CommandContextMenu({
    super.key,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Editar comando'),
            onTap: () {
              Navigator.pop(context);
              onEdit();
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Remover comando'),
            onTap: () {
              Navigator.pop(context);
              onDelete();
            },
          )
        ],
      )
    );
  }
}