import "dart:convert";
import "package:http/http.dart" as http;


var baseUrl = "https://api.dailycash.nasimuddin.me/api";
var reqHeader = {"Content-Type":"application/json"};

Future<Map>LoginReq(value) async{
  var URL = Uri.parse("${baseUrl}/auth/login");
  var reqBody = jsonEncode(value);
  var res = await http.post(URL, headers: reqHeader, body:reqBody);
  var result = jsonDecode(res.body);
  return result;
}
