import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';

class TaxBreakdownCard extends StatelessWidget {
  final double grossRevenue;
  final double charges;
  final double netTaxableIncome;
  final double taxRate;
  final double taxAmount;

  const TaxBreakdownCard({
    super.key,
    required this.grossRevenue,
    required this.charges,
    required this.netTaxableIncome,
    required this.taxRate,
    required this.taxAmount,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);
    final percentFormatter = NumberFormat.percentPattern();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.receipt_long,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Détail du calcul',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
            const Divider(height: 24),
            
            // Gross Revenue
            _buildCalculationRow(
              icon: Icons.add_circle_outline,
              iconColor: AppColors.success,
              label: 'Revenu brut annuel',
              value: currencyFormatter.format(grossRevenue),
              isPositive: true,
            ),
            
            const SizedBox(height: 12),
            
            // Charges
            if (charges > 0) ...[
              _buildCalculationRow(
                icon: Icons.remove_circle_outline,
                iconColor: AppColors.error,
                label: 'Charges déductibles',
                value: '- ${currencyFormatter.format(charges)}',
                isPositive: false,
              ),
              const SizedBox(height: 12),
            ],
            
            // Divider line
            Container(
              height: 1,
              color: AppColors.divider,
              margin: const EdgeInsets.symmetric(vertical: 8),
            ),
            
            // Net Taxable Income
            _buildCalculationRow(
              icon: Icons.account_balance,
              iconColor: AppColors.info,
              label: 'Revenu net imposable',
              value: currencyFormatter.format(netTaxableIncome),
              isHighlighted: true,
            ),
            
            const SizedBox(height: 12),
            
            // Tax Rate
            _buildCalculationRow(
              icon: Icons.percent,
              iconColor: AppColors.warning,
              label: 'Taux d\'imposition',
              value: '${(taxRate * 100).toStringAsFixed(0)}%',
            ),
            
            const SizedBox(height: 12),
            
            // Thick divider
            Container(
              height: 2,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.3),
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.3),
                  ],
                ),
              ),
              margin: const EdgeInsets.symmetric(vertical: 8),
            ),
            
            // Tax Amount (Result)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: _buildCalculationRow(
                icon: Icons.payments,
                iconColor: AppColors.primary,
                label: 'Montant de l\'impôt',
                value: currencyFormatter.format(taxAmount),
                isResult: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculationRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    bool isPositive = false,
    bool isHighlighted = false,
    bool isResult = false,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: isResult ? 16 : 14,
              fontWeight: isResult || isHighlighted ? FontWeight.w600 : FontWeight.normal,
              color: isResult ? AppColors.primary : AppColors.textPrimary,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isResult ? 18 : 14,
            fontWeight: isResult || isHighlighted ? FontWeight.bold : FontWeight.w600,
            color: isResult
                ? AppColors.primary
                : isPositive
                    ? AppColors.success
                    : AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
