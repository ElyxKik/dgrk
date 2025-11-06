import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class ContractDetailPage extends StatelessWidget {
  final String contractId;
  
  const ContractDetailPage({super.key, required this.contractId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détail du contrat'),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Text('Contrat: $contractId - À implémenter'),
      ),
    );
  }
}
