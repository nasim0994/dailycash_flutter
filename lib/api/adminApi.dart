import "dart:convert";
import "package:http/http.dart" as http;
import "../utility/sharedPreferences.dart";


var baseUrl = "https://api.dailycash.nasimuddin.me/api";


Future<Map>getAccountReq() async{
  var URL = Uri.parse("${baseUrl}/account/all");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.get(URL, headers: reqHeader,);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>deleteAccountReq(id) async{
  var URL = Uri.parse("${baseUrl}/account/delete/$id");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.delete(URL, headers: reqHeader,);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>addAccountReq(formValue) async{
  var URL = Uri.parse("${baseUrl}/account/add");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var reqBody = jsonEncode(formValue);
  var res = await http.post(URL, headers: reqHeader, body:reqBody);
  var result = jsonDecode(res.body);
  return result;
}