import 'package:dailycash/screen/dashboard/dashboardScreen.dart';
import 'package:flutter/material.dart';
import 'package:dailycash/screen/onboarding/loginScreen.dart';
import 'package:dailycash/utility/sharedPreferences.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  var token = await getStoreData("token");
  if(token == null){
    runApp(MyApp("/login"));
  }else{
    runApp(MyApp("/dashboard"));
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
        "/dashboard":(context)=>Dashboard(),
        "/login":(context)=>LoginScreen(),
      },
    );
  }
}
