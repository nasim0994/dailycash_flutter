import "dart:convert";
import "package:http/http.dart" as http;
import "../utility/sharedPreferences.dart";


var baseUrl = "https://api.dailycash.nasimuddin.me/api";

Future<Map>getBalanceReq() async{
  var URL = Uri.parse("${baseUrl}/account/balance");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.get(URL, headers: reqHeader,);
  var result = jsonDecode(res.body);
  return result;
}


Future<Map>getAccountReq() async{
  var URL = Uri.parse("${baseUrl}/account/all");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.get(URL, headers: reqHeader,);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>getAccountByReq(id) async{
  var URL = Uri.parse("${baseUrl}/account/$id");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.get(URL, headers: reqHeader,);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>editAccountReq(id,formValue) async{
  var URL = Uri.parse("${baseUrl}/account/update/$id");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var reqBody = jsonEncode(formValue);
  var res = await http.put(URL, headers: reqHeader, body:reqBody);
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



Future<Map>addCashInReq(formValue) async{
  var URL = Uri.parse("${baseUrl}/cash-in/add");
  var token = await getStoreData("token");
  var userId = await getStoreData("_id");
  formValue["addedBy"] = userId;
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var reqBody = jsonEncode(formValue);
  var res = await http.post(URL, headers: reqHeader, body:reqBody);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>getCashInReq(page,limit,startDate,endDate) async{
  var URL = Uri.parse("${baseUrl}/cash-in/all?page=$page&limit=$limit&startDate=$startDate&endDate=$endDate");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.get(URL, headers: reqHeader);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>getCashInByIdReq(id) async{
  var URL = Uri.parse("${baseUrl}/cash-in/$id");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.get(URL, headers: reqHeader);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>editCashInReq(id,formValue) async{
  var URL = Uri.parse("${baseUrl}/cash-in/update/$id");
  var token = await getStoreData("token");
  var userId = await getStoreData("_id");
  formValue["addedBy"] = userId;
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var reqBody = jsonEncode(formValue);
  var res = await http.put(URL, headers: reqHeader, body:reqBody);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>deleteCashInReq(id) async{
  var URL = Uri.parse("${baseUrl}/cash-in/delete/$id");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.delete(URL, headers: reqHeader,);
  var result = jsonDecode(res.body);
  return result;
}



//-------------------------------
Future<Map>addCashOutReq(formValue) async{
  var URL = Uri.parse("${baseUrl}/cash-out/add");
  var token = await getStoreData("token");
  var userId = await getStoreData("_id");
  formValue["addedBy"] = userId;
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var reqBody = jsonEncode(formValue);
  var res = await http.post(URL, headers: reqHeader, body:reqBody);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>getCashOutReq(page,limit, startDate,endDate) async{
  var URL = Uri.parse("${baseUrl}/cash-out/all?page=$page&limit=$limit&startDate=$startDate&endDate=$endDate");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.get(URL, headers: reqHeader);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>getCashOutByIdReq(id) async{
  var URL = Uri.parse("${baseUrl}/cash-out/$id");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.get(URL, headers: reqHeader);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>editCashOutReq(id,formValue) async{
  var URL = Uri.parse("${baseUrl}/cash-out/update/$id");
  var token = await getStoreData("token");
  var userId = await getStoreData("_id");
  formValue["addedBy"] = userId;
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var reqBody = jsonEncode(formValue);
  var res = await http.put(URL, headers: reqHeader, body:reqBody);
  var result = jsonDecode(res.body);
  return result;
}

Future<Map>deleteCashOutReq(id) async{
  var URL = Uri.parse("${baseUrl}/cash-out/delete/$id");
  var token = await getStoreData("token");
  var reqHeader = {"Content-Type":"application/json", "Authorization": "Bearer $token",};
  var res = await http.delete(URL, headers: reqHeader,);
  var result = jsonDecode(res.body);
  return result;
}