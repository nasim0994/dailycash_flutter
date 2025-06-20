import 'package:flutter/material.dart';
import '../../utility/sharedPreferences.dart';
import '../../components/appBottomNavBar.dart';

import '../../components/newTask.dart';
import '../../components/canceledTask.dart';
import '../../components/completedTask.dart';
import '../../components/progressTask.dart';



class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => DashboardScreenState();
}

class DashboardScreenState extends State<DashboardScreen> {
  String firstName = "";
  int bottomTabIndex = 0;

  onItemChangeTab(int index){
    setState(() {
      bottomTabIndex = index;
    });
  }

  final tabWidgetOptions = [
    NewTask(),
    ProgressTask(),
    CompletedTask(),
    CanceledTask()
  ];

  @override
  void initState(){
    callLoggedUserData();
    super.initState();
  }

  callLoggedUserData()async{
    var result = await getStoreData("firstName");
    setState(() {
      firstName=result ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Hello ${firstName}", style: TextStyle(color: Colors.white),),
        actions: [
          IconButton(
            icon: Icon(Icons.logout,color: Colors.white),
            onPressed: () async{
              await clearLoggedUserData();
              Navigator.pushNamedAndRemoveUntil(context, "/login", (route)=>false);
            },
          ),
        ],
      ),
      body: tabWidgetOptions.elementAt(bottomTabIndex),
      bottomNavigationBar: appBottomNavBar(bottomTabIndex,onItemChangeTab),
    );
  }
}
