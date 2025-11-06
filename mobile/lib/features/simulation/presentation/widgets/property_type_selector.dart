import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class PropertyTypeSelector extends StatelessWidget {
  final String selectedType;
  final Function(String) onTypeSelected;

  const PropertyTypeSelector({
    super.key,
    required this.selectedType,
    required this.onTypeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _PropertyTypeCard(
            icon: Icons.home,
            label: 'Résidentiel',
            type: 'residential',
            isSelected: selectedType == 'residential',
            onTap: () => onTypeSelected('residential'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _PropertyTypeCard(
            icon: Icons.business,
            label: 'Commercial',
            type: 'commercial',
            isSelected: selectedType == 'commercial',
            onTap: () => onTypeSelected('commercial'),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _PropertyTypeCard(
            icon: Icons.apartment,
            label: 'Mixte',
            type: 'mixed',
            isSelected: selectedType == 'mixed',
            onTap: () => onTypeSelected('mixed'),
          ),
        ),
      ],
    );
  }
}

class _PropertyTypeCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String type;
  final bool isSelected;
  final VoidCallback onTap;

  const _PropertyTypeCard({
    required this.icon,
    required this.label,
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 32,
              color: isSelected ? Colors.white : AppColors.primary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
