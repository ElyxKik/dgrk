import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ContractsListPage extends StatelessWidget {
  const ContractsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contrats'),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child: Text('Liste des contrats - À implémenter'),
      ),
    );
  }
}
