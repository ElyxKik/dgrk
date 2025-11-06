import 'package:flutter/material.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/theme/app_colors.dart';

class PropertiesListPage extends StatelessWidget {
  const PropertiesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PropertiesListPageContent();
  }
}

class PropertiesListPageContent extends StatelessWidget {
  const PropertiesListPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Icon(Icons.home, color: AppColors.primary),
              ),
              title: Text('Appartement ${index + 1}'),
              subtitle: Text('Kinshasa, Gombe\nLoué - \$800/mois'),
              isThreeLine: true,
              trailing: Icon(Icons.chevron_right, color: AppColors.textSecondary),
              onTap: () {
                Navigator.of(context).pushNamed(
                  AppRouter.propertyDetail,
                  arguments: 'property-${index + 1}',
                );
              },
            ),
          );
        },
      );
  }
}
