import 'package:flutter/material.dart';
import '../../api/onboardingApi.dart';
import '../../style/commonStyle.dart';

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
    setState(() => isLoading = true);
    String? email = FormValue["email"];
    String? password = FormValue["password"];

    if (email == null || email.trim().isEmpty) {
      showErrorToast("Email is required");
    } else if (password == null || password.trim().isEmpty) {
      showErrorToast("Password is required");
    } else {
      bool res = await LoginReq(FormValue);
      if(res == true){
        Navigator.pushNamedAndRemoveUntil(context, "/", (route)=>false);
      }
    }

    setState(() => isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ScreenBackground(context),
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Get Started With", style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 2,),
                Text("Make your easy life your my task app", style: TextStyle(color: Colors.black54),),
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

                SizedBox(height: 70,),

                SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: (){Navigator.pushNamed(context, "/forget");},
                        child: Text("Forget Password?", style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),),
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account?", style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),),
                          SizedBox(width: 4,),
                          InkWell(
                            onTap: (){Navigator.pushNamed(context, "/register");},
                              child: Text("Sign up", style: TextStyle(
                                fontSize: 13,
                                color: Colors.blue,
                              ),),
                          )
                        ],
                      ),
                    ],
                  ),
                )

              ],
            ),
          )
        ],
      ),
    );
  }
}
