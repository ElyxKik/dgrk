import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_bottom_nav.dart';
import '../../../home/presentation/pages/home_page.dart';
import '../../../properties/presentation/pages/properties_list_page.dart';
import '../../../simulation/presentation/pages/tax_simulation_page.dart';
import '../../../profile/presentation/pages/profile_page.dart';

class MainContainerPage extends StatefulWidget {
  const MainContainerPage({super.key});

  @override
  State<MainContainerPage> createState() => _MainContainerPageState();
}

class _MainContainerPageState extends State<MainContainerPage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePageContent(),
      const PropertiesListPageContent(),
      const TaxSimulationPageContent(),
      const ProfilePageContent(),
    ];
  }

  void selectTab(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MainContainerProvider(
      state: this,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const AppHeader(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: AppBottomNav(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() => _selectedIndex = index);
          },
        ),
      ),
    );
  }
}

class MainContainerProvider extends InheritedWidget {
  final _MainContainerPageState state;

  const MainContainerProvider({
    required this.state,
    required super.child,
    super.key,
  });

  static _MainContainerPageState of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<MainContainerProvider>();
    assert(result != null, 'No MainContainerProvider found in context');
    return result!.state;
  }

  @override
  bool updateShouldNotify(MainContainerProvider oldWidget) {
    return state != oldWidget.state;
  }
}
