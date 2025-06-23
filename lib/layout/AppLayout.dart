import 'package:flutter/material.dart';
import '../utility/sharedPreferences.dart';
import 'appBottomNavBar.dart';


class AppLayout extends StatelessWidget {
  final String title;
  final String currentRoute;
  final Widget child;
  final List<Widget>? actions;
  final Widget? floatingActionButton;

  const AppLayout({
    super.key,
    required this.title,
    required this.currentRoute,
    required this.child,
    this.actions,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: ()async{
                await clearLoggedUserData();
                Navigator.pushNamedAndRemoveUntil(context, "/login", (route)=>false);
                },
              icon: Icon(Icons.logout)
          )
        ],
      ),
      body: child,
      bottomNavigationBar: AppBottomNavBar(currentRoute: currentRoute),
      floatingActionButton: floatingActionButton,
    );
  }
}
