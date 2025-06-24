import 'package:flutter/material.dart';
import '../../api/onboardingApi.dart';
import '../../style/commonStyle.dart';
import '../../utility/sharedPreferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  Map<String, String> FormValue = {"email":"", "password":""};
  bool isLoading = false;

  void handleChangeInput(String key, String value) {
    setState(() {
      if (FormValue.containsKey(key)) {
        FormValue[key] = value;
      }
    });
  }

  handleLogin()async{
    print("start");
    setState(() => isLoading = true);
    String? email = FormValue["email"];
    String? password = FormValue["password"];

    print("email $email password $password");

    if (email == null || email.trim().isEmpty) {
      showErrorToast(context,"Email is required");
    } else if (password == null || password.trim().isEmpty) {
      showErrorToast(context,"Password is required");
    } else {
      Map res = await LoginReq(FormValue);
      print(res);
      if(res["success"] == true){
        showSuccessToast(context,"Login success");
        storeLoggedUserData(res["data"]);
        setState(() => isLoading = false);
        Navigator.pushNamedAndRemoveUntil(context, "/dashboard", (route)=>false);
      }else{
        showErrorToast(context,res["message"]);
        setState(() => isLoading = false);
      }
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/screen_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Get Started", style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 2,),
                Text("Make your easy life your my daily cash app", style: TextStyle(color: Colors.black54),),
                SizedBox(height: 40,),

                TextFormField(decoration: AppInputStyle("Enter email"),
                onChanged: (value)=>{handleChangeInput("email", value)},
                ),
                SizedBox(height: 10,),
                TextFormField(decoration: AppInputStyle("Enter password"),
                  onChanged: (value)=>{handleChangeInput("password", value)},
                ),
                SizedBox(height: 10,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : (){handleLogin();},
                    style: AppBtnStyle(),
                    child: isLoading  ?
                      SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                  ) : Text("Login"),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
