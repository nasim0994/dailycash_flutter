import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeLoggedUserData(data)async{
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('token', data["accessToken"]);
  await prefs.setString('email', data["user"]["email"]);
  await prefs.setString('name', data["user"]["name"]);
  await prefs.setString('role', data["user"]["role"]);
  await prefs.setString('_id', data["user"]["_id"]);

}

Future<String?> getStoreData(key)async{
  final prefs = await SharedPreferences.getInstance();
 String? data= await prefs.getString(key);
 return data;
}

Future<void> storeVerificationEmail(email)async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('verificationEmail', email);
}


Future<void> storeVerificationOTP(otp)async{
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('verificationOTP', otp);
}


Future<void> clearLoggedUserData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}