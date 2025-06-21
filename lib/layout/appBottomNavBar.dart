
import 'package:flutter/material.dart';

import '../screen/dashboard/accountScreen.dart';
import '../screen/dashboard/dashboardScreen.dart';

class AppBottomNavBar extends StatelessWidget {
  final String currentRoute;

  const AppBottomNavBar({super.key, required this.currentRoute});

  void _navigate(BuildContext context, String route, Widget page) {
    if (route != currentRoute) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => page,
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _getIndex(currentRoute),
      onTap: (index) {
        switch (index) {
          case 0:
            _navigate(context, '/dashboard', Dashboard());
            break;
          case 1:
            _navigate(context, '/accounts', Accounts());
            break;
          case 2:
            _navigate(context, '/cashin',Dashboard());
            break;
          case 3:
            _navigate(context, '/cashout',Dashboard());
            break;
        }
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.blue,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance),
          label: 'Accounts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_card),
          label: 'Cash In',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.call_received),
          label: 'Cash Out',
        ),
      ],
    );
  }

  int _getIndex(String route) {
    switch (route) {
      case '/dashboard':
        return 0;
      case '/accounts':
        return 1;
      case '/cashin':
        return 2;
      case '/cashout':
        return 3;
      default:
        return 0;
    }
  }
}
