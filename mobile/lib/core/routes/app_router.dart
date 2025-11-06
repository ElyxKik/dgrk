import 'package:flutter/material.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/properties/presentation/pages/property_detail_page.dart';
import '../../features/properties/presentation/pages/add_property_page.dart';
import '../../features/contracts/presentation/pages/contracts_list_page.dart';
import '../../features/contracts/presentation/pages/contract_detail_page.dart';
import '../../features/revenues/presentation/pages/revenues_list_page.dart';
import '../../features/revenues/presentation/pages/declare_revenue_page.dart';
import '../../features/payments/presentation/pages/payments_list_page.dart';
import '../../features/payments/presentation/pages/make_payment_page.dart';
import '../../features/simulation/presentation/pages/simulation_result_page.dart';
import '../../features/main/presentation/pages/main_container_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String dashboard = '/dashboard';
  static const String propertiesList = '/properties';
  static const String propertyDetail = '/properties/detail';
  static const String addProperty = '/properties/add';
  static const String contractsList = '/contracts';
  static const String contractDetail = '/contracts/detail';
  static const String revenuesList = '/revenues';
  static const String declareRevenue = '/revenues/declare';
  static const String paymentsList = '/payments';
  static const String makePayment = '/payments/make';
  static const String profile = '/profile';
  static const String taxSimulation = '/simulation';
  static const String simulationResult = '/simulation/result';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case home:
      case propertiesList:
      case profile:
      case taxSimulation:
        return MaterialPageRoute(builder: (_) => const MainContainerPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case propertyDetail:
        final propertyId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PropertyDetailPage(propertyId: propertyId),
        );
      case addProperty:
        return MaterialPageRoute(builder: (_) => const AddPropertyPage());
      case contractsList:
        return MaterialPageRoute(builder: (_) => const ContractsListPage());
      case contractDetail:
        final contractId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ContractDetailPage(contractId: contractId),
        );
      case revenuesList:
        return MaterialPageRoute(builder: (_) => const RevenuesListPage());
      case declareRevenue:
        return MaterialPageRoute(builder: (_) => const DeclareRevenuePage());
      case paymentsList:
        return MaterialPageRoute(builder: (_) => const PaymentsListPage());
      case makePayment:
        final revenueId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => MakePaymentPage(revenueId: revenueId),
        );
      case simulationResult:
        final data = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => SimulationResultPage(simulationData: data),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('Page non trouvée: ${settings.name}'),
            ),
          ),
        );
    }
  }
}
