import 'package:shared_preferences/shared_preferences.dart';

Future<void> storeLoggedUserData(data)async{
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString('token', data["token"]);
  await prefs.setString('email', data["data"]["email"]);
  await prefs.setString('firstName', data["data"]["firstName"]);
  await prefs.setString('lastName', data["data"]["lastName"]);
  await prefs.setString('mobile', data["data"]["mobile"]);
  await prefs.setString('photo', data["data"]["photo"]);

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