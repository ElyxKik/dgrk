import 'package:flutter/material.dart';
import 'core/routes/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(const DGRKApp());
}

class DGRKApp extends StatelessWidget {
  const DGRKApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DGRK - Direction Générale de Recette de Kinshasa',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.login, // Start with login page
    );
  }
}
