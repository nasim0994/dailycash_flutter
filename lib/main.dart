import 'package:flutter/material.dart';
import 'package:taskapp/screen/dashboard/dashboardScreen.dart';
import 'package:taskapp/screen/onboarding/forgetScreen.dart';
import 'package:taskapp/screen/onboarding/loginScreen.dart';
import 'package:taskapp/screen/onboarding/pinScreen.dart';
import 'package:taskapp/screen/onboarding/registerScreen.dart';
import 'package:taskapp/utility/sharedPreferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var token = await getStoreData("token");
  if(token == null){
    runApp(MyApp("/login"));
  }else{
    runApp(MyApp("/"));
  }
}

class MyApp extends StatelessWidget {
  final String FirstRote;
  const MyApp(this.FirstRote);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirstRote,
      routes: {
        "/":(context)=>DashboardScreen(),
        "/login":(context)=>LoginScreen(),
        "/register":(context)=>RegisterScreen(),
        "/forget":(context)=>ForgetScreen(),
        "/pin-verification":(context)=>PinScreen(),

      },
    );
  }
}
