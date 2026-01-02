import 'package:flutter/material.dart';
import 'package:mobile/widgets/command_form_dialog.dart';
import 'package:mobile/widgets/command_context_menu.dart';
import 'package:mobile/widgets/config_settings_dialog.dart';
import 'package:mobile/widgets/confirm_dialog.dart';
import 'package:provider/provider.dart';
import 'home_view_model.dart';
import 'home_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _HomeView();
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final canExecute = viewModel.computerOnline && !viewModel.isExecutingCommand;

    if (!viewModel.isConfigured) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.settings_input_component_outlined, size: 64),
              const Text("Bem vindo! Configure seu servidor para começar."),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ConfigSettingsDialog(viewModel: viewModel)
                  );
                },
                child: const Text("Configurar agora"),
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => viewModel.checkAllStatuses(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: IgnorePointer(
            ignoring: !canExecute,
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
                    enabled: canExecute,
                    onTap: canExecute
                      ? () {
                          viewModel.executeCommand(command);
                        }
                      : null,
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) => CommandContextMenu(
                          onEdit: () {
                            showDialog(
                              context: context,
                              builder: (context) => CommandFormDialog(
                                command: command,
                              )
                            );
                          },
                          onDelete: () {
                            showDialog(
                              context: context,
                              builder: (context) => ConfirmDialog(
                                title: 'Remover comando',
                                message: 'Tem certeza que deseja remover este comando? Esta ação não pode ser desfeita.',
                                confirmText: 'Remover',
                                confirmColor: Colors.red,
                                cancelText: 'Cancelar',
                                onConfirm: () {
                                  viewModel.removeCommand(command.id);
                                },
                              )
                            );
                          },
                        ),
                      );
                    },
                  );
                }

                // último card: ícone grande centralizado
                return AddNewCard(
                  icon: Icons.add,
                  size: 64,
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => CommandFormDialog(),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
      bottomNavigationBar: Opacity(
        opacity: viewModel.isExecutingCommand ? 0.45 : 1.0,
        child: IgnorePointer(
          ignoring: viewModel.isExecutingCommand,
          child: _BottomBar(
            isOnline: viewModel.computerOnline,
            viewModel: viewModel,
          ),
        ),
      ),
    );
  }
}

class _BottomBar extends StatelessWidget {
  final bool isOnline;
  final HomeViewModel viewModel;

  const _BottomBar({
    required this.isOnline,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    final color = isOnline ? Colors.orange : Colors.grey;

    return BottomAppBar(
      height: 64,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ConfigSettingsDialog(viewModel: viewModel),
                );
              },
            ),
            Spacer(),
            IconButton(
              iconSize: 32,
              onPressed: isOnline ? (){} : viewModel.powerOnComputer,
              onLongPress: isOnline
                ? () => showDialog(
                    context: context,
                    builder: (context) => ConfirmDialog(
                      title: 'Desligar computador',
                      message: 'Tem certeza que deseja desligar o computador?',
                      confirmText: 'Desligar',
                      confirmColor: Colors.red,
                      cancelText: 'Cancelar',
                      onConfirm: () {
                        viewModel.powerOffComputer();
                      },
                    )
                  )
                : (){},
              icon: Icon(Icons.desktop_windows_outlined, color: color),
            ),
            Spacer(),
            Opacity(opacity: 0, child: IconButton(icon: Icon(Icons.settings), onPressed: null,))
          ],
        )
      ),
    );
  }

}
