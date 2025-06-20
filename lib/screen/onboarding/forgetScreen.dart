import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api/onboardingApi.dart';
import '../../style/commonStyle.dart';

class ForgetScreen extends StatefulWidget {
  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => ForgetScreenState();
}

class ForgetScreenState extends State<ForgetScreen> {

  Map<String, String> FormValue = {"email":""};
  bool isLoading = false;

  void handleChangeInput(String key, String value) {
    setState(() {
      if (FormValue.containsKey(key)) {
        FormValue[key] = value;
      }
    });
  }

  handleFormSubmit()async{
    setState(() => isLoading = true);
    String? email = FormValue["email"];

    if (email == null || email.trim().isEmpty) {
      showErrorToast("Email is required");
    }  else {
      bool res = await VerifyEmailReq(email);
      if(res == true){
        setState(() => isLoading = false);
        Navigator.pushNamed(context, "/pin-verification");
      }else{
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
          ScreenBackground(context),
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Forget Password?", style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 2,),
                Text("Enter your email for OTP verification",),
                SizedBox(height: 40,),

                TextFormField(decoration: AppInputStyle("Enter email"),
                    onChanged: (value)=>handleChangeInput("email", value),
                ),
                SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: isLoading ? null : (){handleFormSubmit();},
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
