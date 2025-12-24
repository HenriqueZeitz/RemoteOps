import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_view_model.dart';
import 'home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: viewModel.commandCards.length + 1,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.2,
          ),
          itemBuilder: (context, index) {
            if (index < viewModel.commandCards.length) {
              final command = viewModel.commandCards[index];
              return CommandCard(
                model: command,
                onTap: () {
                  // futuramente: chamar API
                },
              );
            }

            // último card: ícone grande centralizado
            return AddNewCard(
              icon: Icons.add,
              size: 64,
              onTap: () {
                // futuramente: adicionar novo comando
              },
            );
          },
        ),
      ),
      bottomNavigationBar: _BottomBar(
        isOnline: viewModel.computerOnline,
        onPowerPressed: viewModel.toggleComputerStatus,
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final bool isOnline;
  final VoidCallback onPowerPressed;

  const _BottomBar({
    required this.isOnline,
    required this.onPowerPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = isOnline ? Colors.orange : Colors.grey;

    return BottomAppBar(
      height: 64,
      child: Center(
        child: IconButton(
          iconSize: 32,
          onPressed: onPowerPressed,
          icon: Icon(Icons.desktop_windows_outlined, color: color),
        ),
      ),
    );
  }
}
