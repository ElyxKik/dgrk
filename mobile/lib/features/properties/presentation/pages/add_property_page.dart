import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class AddPropertyPage extends StatelessWidget {
  const AddPropertyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajouter un bien'),
        backgroundColor: AppColors.primary,
      ),
      body: const Center(
        child: Text('Page d\'ajout de bien - À implémenter'),
      ),
    );
  }
}
