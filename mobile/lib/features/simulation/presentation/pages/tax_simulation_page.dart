import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/app_colors.dart';
import '../widgets/property_type_selector.dart';
import '../widgets/simulation_input_field.dart';

class TaxSimulationPage extends StatelessWidget {
  const TaxSimulationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TaxSimulationPageContent();
  }
}

class TaxSimulationPageContent extends StatefulWidget {
  const TaxSimulationPageContent({super.key});

  @override
  State<TaxSimulationPageContent> createState() => _TaxSimulationPageContentState();
}

class _TaxSimulationPageContentState extends State<TaxSimulationPageContent> {
  final _formKey = GlobalKey<FormState>();
  final _monthlyRentController = TextEditingController();
  final _propertyValueController = TextEditingController();
  final _chargesController = TextEditingController();
  
  String _selectedPropertyType = 'residential';
  int _numberOfMonths = 12;
  bool _includeCharges = false;
  int _selectedIndex = 2;
  
  @override
  void dispose() {
    _monthlyRentController.dispose();
    _propertyValueController.dispose();
    _chargesController.dispose();
    super.dispose();
  }
  
  void _calculateTax() {
    if (_formKey.currentState!.validate()) {
      final monthlyRent = double.parse(_monthlyRentController.text);
      final propertyValue = double.parse(_propertyValueController.text);
      final charges = _includeCharges ? double.parse(_chargesController.text) : 0.0;
      
      Navigator.of(context).pushNamed(
        '/simulation/result',
        arguments: {
          'monthlyRent': monthlyRent,
          'propertyValue': propertyValue,
          'charges': charges,
          'propertyType': _selectedPropertyType,
          'numberOfMonths': _numberOfMonths,
        },
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Card(
                color: AppColors.primary.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Icon(
                        Icons.calculate_outlined,
                        size: 48,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Calculez votre impôt locatif',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Estimez le montant de votre impôt sur le revenu locatif avant de faire votre déclaration',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Property Type Selection
              Text(
                'Type de bien',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              PropertyTypeSelector(
                selectedType: _selectedPropertyType,
                onTypeSelected: (type) {
                  setState(() {
                    _selectedPropertyType = type;
                  });
                },
              ),
              
              const SizedBox(height: 24),
              
              // Monthly Rent Input
              SimulationInputField(
                controller: _monthlyRentController,
                label: 'Loyer mensuel',
                hint: 'Entrez le loyer mensuel',
                prefix: '\$',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer le loyer mensuel';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un montant valide';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Le montant doit être supérieur à 0';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Property Value Input
              SimulationInputField(
                controller: _propertyValueController,
                label: 'Valeur du bien',
                hint: 'Entrez la valeur estimée du bien',
                prefix: '\$',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez entrer la valeur du bien';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Veuillez entrer un montant valide';
                  }
                  if (double.parse(value) <= 0) {
                    return 'Le montant doit être supérieur à 0';
                  }
                  return null;
                },
              ),
              
              const SizedBox(height: 16),
              
              // Number of Months Slider
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Période de location',
                            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '$_numberOfMonths mois',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Slider(
                        value: _numberOfMonths.toDouble(),
                        min: 1,
                        max: 12,
                        divisions: 11,
                        activeColor: AppColors.primary,
                        label: '$_numberOfMonths mois',
                        onChanged: (value) {
                          setState(() {
                            _numberOfMonths = value.toInt();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Include Charges Toggle
              Card(
                child: SwitchListTile(
                  title: const Text('Inclure les charges déductibles'),
                  subtitle: const Text('Frais d\'entretien, réparations, etc.'),
                  value: _includeCharges,
                  activeColor: AppColors.primary,
                  onChanged: (value) {
                    setState(() {
                      _includeCharges = value;
                    });
                  },
                ),
              ),
              
              // Charges Input (conditional)
              if (_includeCharges) ...[
                const SizedBox(height: 16),
                SimulationInputField(
                  controller: _chargesController,
                  label: 'Charges annuelles déductibles',
                  hint: 'Entrez le montant des charges',
                  prefix: '\$',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (_includeCharges && (value == null || value.isEmpty)) {
                      return 'Veuillez entrer le montant des charges';
                    }
                    if (_includeCharges && double.tryParse(value!) == null) {
                      return 'Veuillez entrer un montant valide';
                    }
                    return null;
                  },
                ),
              ],
              
              const SizedBox(height: 24),
              
              // Info Card
              Card(
                color: AppColors.info.withOpacity(0.1),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.info,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Cette simulation est basée sur les barèmes fiscaux en vigueur en RDC',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.info,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              // Calculate Button
              ElevatedButton(
                onPressed: _calculateTax,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.calculate),
                    SizedBox(width: 8),
                    Text(
                      'Calculer l\'impôt',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 16),
            ],
          ),
        ),
      );
  }
}
