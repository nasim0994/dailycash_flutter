import 'package:flutter/material.dart';

import '../../layout/AppLayout.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  @override
  void initState(){
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return AppLayout(
      title: "Dashboard",
      currentRoute: '/dashboard',
      child: const Center(child: Text("Welcome to Dashboard")),
    );
  }
}