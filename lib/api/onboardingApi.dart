import "dart:convert";
import "package:http/http.dart" as http;
import 'package:taskapp/style/commonStyle.dart';
import "../utility/sharedPreferences.dart";


var baseUrl = "https://task.teamrabbil.com/api/v1";
var reqHeader = {"Content-Type":"application/json"};

Future<bool>LoginReq(value) async{
  var URL = Uri.parse("$baseUrl/login");
  var reqBody = jsonEncode(value);
  var res = await http.post(URL, headers: reqHeader, body:reqBody);
  var result = jsonDecode(res.body);

  if(result["status"] == "success"){
    showSuccessToast("Login Success");
    storeLoggedUserData(result);
    return true;
  }else{
    showErrorToast("Login Fail");
    return false;
  }

}

Future<bool>RegisterReq(value) async{
  var URL = Uri.parse("$baseUrl/registration");
  var reqBody = jsonEncode(value);
  var res = await http.post(URL, headers: reqHeader, body:reqBody);
  var result = jsonDecode(res.body);

  if(result["status"] == "success"){
    showSuccessToast("Register Success");
    return true;
  }else{
    showErrorToast("Register Fail");
    return false;
  }

}


Future<bool>VerifyEmailReq(email) async{
  var URL = Uri.parse("${baseUrl}/RecoveryVerifyEmail/${email}");

  var res = await http.get(URL, headers: reqHeader);
  var result = jsonDecode(res.body);

  if(result["status"] == "success"){
    showSuccessToast("Request Success");
    // await storeVerificationEmail(email);
    return true;
  }else{
    showErrorToast("Request Fail");
    return false;
  }
}

Future<bool>VerifyOTPReq(otp) async{
  var URL = Uri.parse("$baseUrl/RecoveryVerifyOTP/$otp");

  var res = await http.get(URL, headers: reqHeader);
  var result = jsonDecode(res.body);

  if(result["status"] == "success"){
    showSuccessToast("Request Success");
    await storeVerificationOTP(otp);
    return true;
  }else{
    showErrorToast("Request Fail");
    return false;
  }

}


Future<List>GetTaskReq(Status) async{
  var URL = Uri.parse("$baseUrl/listTaskByStatus/$Status");
  String? token = await getStoreData("token");
  var reqHeaderWithToken = {"Content-Type":"application/json", "token":'$token'};

  var res = await http.get(URL, headers: reqHeaderWithToken);
  var result = jsonDecode(res.body);

  if(result["status"] == "success"){
    return result["data"];
  }else{
    showErrorToast("Request Fail");
    return [];
  }

}