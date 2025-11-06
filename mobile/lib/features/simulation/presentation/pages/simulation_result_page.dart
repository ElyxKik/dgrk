import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/tax_breakdown_card.dart';
import '../widgets/result_summary_card.dart';

class SimulationResultPage extends StatelessWidget {
  final Map<String, dynamic> simulationData;

  const SimulationResultPage({
    super.key,
    required this.simulationData,
  });

  // Calcul de l'impôt selon les barèmes RDC
  Map<String, double> _calculateTax() {
    final monthlyRent = simulationData['monthlyRent'] as double;
    final numberOfMonths = simulationData['numberOfMonths'] as int;
    final charges = simulationData['charges'] as double;
    final propertyType = simulationData['propertyType'] as String;

    // Revenu brut annuel
    final grossAnnualRevenue = monthlyRent * numberOfMonths;

    // Revenu net imposable (après déduction des charges)
    final netTaxableIncome = grossAnnualRevenue - charges;

    // Taux d'imposition selon le type de bien
    // Résidentiel: 20%, Commercial: 25%, Mixte: 22%
    double taxRate;
    switch (propertyType) {
      case 'commercial':
        taxRate = 0.25;
        break;
      case 'mixed':
        taxRate = 0.22;
        break;
      default:
        taxRate = 0.20;
    }

    // Calcul de l'impôt
    final taxAmount = netTaxableIncome * taxRate;

    // Revenu net après impôt
    final netIncomeAfterTax = netTaxableIncome - taxAmount;

    return {
      'grossAnnualRevenue': grossAnnualRevenue,
      'charges': charges,
      'netTaxableIncome': netTaxableIncome,
      'taxRate': taxRate,
      'taxAmount': taxAmount,
      'netIncomeAfterTax': netIncomeAfterTax,
      'monthlyNetIncome': netIncomeAfterTax / 12,
    };
  }

  String _getPropertyTypeLabel(String type) {
    switch (type) {
      case 'commercial':
        return 'Commercial';
      case 'mixed':
        return 'Mixte';
      default:
        return 'Résidentiel';
    }
  }

  @override
  Widget build(BuildContext context) {
    final results = _calculateTax();
    final currencyFormatter = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                'assets/logos/app_logo.jpg',
                height: 36,
                width: 36,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Résultat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Summary Card
            ResultSummaryCard(
              taxAmount: results['taxAmount']!,
              netIncomeAfterTax: results['netIncomeAfterTax']!,
              monthlyNetIncome: results['monthlyNetIncome']!,
            ),

            const SizedBox(height: 24),

            // Property Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Informations du bien',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      'Type de bien',
                      _getPropertyTypeLabel(simulationData['propertyType']),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      'Loyer mensuel',
                      currencyFormatter.format(simulationData['monthlyRent']),
                    ),
                    const SizedBox(height: 12),
                    _buildInfoRow(
                      'Période',
                      '${simulationData['numberOfMonths']} mois',
                    ),
                    if (simulationData['charges'] > 0) ...[
                      const SizedBox(height: 12),
                      _buildInfoRow(
                        'Charges déductibles',
                        currencyFormatter.format(simulationData['charges']),
                      ),
                    ],
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Tax Breakdown
            TaxBreakdownCard(
              grossRevenue: results['grossAnnualRevenue']!,
              charges: results['charges']!,
              netTaxableIncome: results['netTaxableIncome']!,
              taxRate: results['taxRate']!,
              taxAmount: results['taxAmount']!,
            ),

            const SizedBox(height: 24),

            // Info Banner
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.info.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.info.withOpacity(0.3),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: AppColors.info,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Conseil fiscal',
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppColors.info,
                              ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'N\'oubliez pas de conserver tous vos justificatifs de charges pour les déductions fiscales.',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.textSecondary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Navigate to declaration page
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Redirection vers la déclaration...'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  icon: const Icon(Icons.assignment),
                  label: const Text('Déclarer ce revenu'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Nouvelle simulation'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: AppColors.primary),
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                OutlinedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home',
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.home),
                  label: const Text('Retour à l\'accueil'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(color: AppColors.primary),
                    foregroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
