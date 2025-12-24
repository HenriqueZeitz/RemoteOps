import 'package:flutter/material.dart';
import 'home_view_model.dart';

class CommandCard extends StatelessWidget {
  final CommandCardModel model;
  final VoidCallback onTap;

  const CommandCard({
    super.key,
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor =
        model.isRunning ? Colors.orange : Colors.grey.shade700;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: borderColor, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  model.icon,
                  size: 24,
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    model.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                )
              ],
            ),
            const SizedBox(height: 8),
            Text(
              model.description,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewCard extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback? onTap;

  const AddNewCard({
    super.key,
    required this.icon,
    this.size = 56,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade700, width: 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Icon(
            icon,
            size: size,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}
