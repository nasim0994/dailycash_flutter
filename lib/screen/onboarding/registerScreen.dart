import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../api/onboardingApi.dart';
import '../../style/commonStyle.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {

  Map<String, String> FormValue = {
    "email":"",
    "firstName":"",
    "lastName":"",
    "mobile":"",
    "password":"",
    "cPassword":"",
    "photo":""
  };
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
    String? firstName = FormValue["firstName"];
    String? lastName = FormValue["lastName"];
    String? mobile = FormValue["mobile"];
    String? password = FormValue["password"];
    String? cPassword = FormValue["cPassword"];

    if (email == null || email.trim().isEmpty) {
      showErrorToast("Email is required");
    }else if (firstName == null || firstName.trim().isEmpty) {
      showErrorToast("FirstName is required");
    }else if (lastName == null || lastName.trim().isEmpty) {
      showErrorToast("LastName is required");
    }else if (mobile == null || mobile.trim().isEmpty) {
      showErrorToast("Mobile is required");
    } else if (password == null || password.trim().isEmpty) {
      showErrorToast("Password is required");
    }else if (cPassword == null || cPassword.trim().isEmpty) {
      showErrorToast("Confirm Password is required");
    }else if (password != cPassword) {
      showErrorToast("Password and Confirm Password do not match");
    } else {
      bool res = await RegisterReq(FormValue);
      if(res == true){
        Navigator.pushNamedAndRemoveUntil(context, "/login", (route)=>false);
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
                Text("Join With US", style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 2,),
                Text("Make your easy life your my task app",),
                SizedBox(height: 40,),

                TextFormField(
                  decoration: AppInputStyle("Enter email"),
                  onChanged: (value)=>handleChangeInput("email", value),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: AppInputStyle("First Name"),
                  onChanged: (value)=>handleChangeInput("firstName", value),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: AppInputStyle("Last Name"),
                  onChanged: (value)=>handleChangeInput("lastName", value),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  decoration: AppInputStyle("Mobile Number"),
                  onChanged: (value)=>handleChangeInput("mobile", value),
                ),
                SizedBox(height: 10,),
                TextFormField(decoration: AppInputStyle("Enter password"),
                  onChanged: (value)=>handleChangeInput("password", value),
                ),
                SizedBox(height: 10,),
                TextFormField(decoration: AppInputStyle("Confirm password"),
                  onChanged: (value)=>handleChangeInput("cPassword", value),
                ),
                SizedBox(height: 10,),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: isLoading ? null : (){handleFormSubmit();}, style: AppBtnStyle(), child: isLoading
                      ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Text("Register"),),
                ),

                SizedBox(height: 40,),

                SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?", style: TextStyle(
                        fontSize: 13,
                        color: Colors.black54,
                      ),),
                      SizedBox(width: 4,),
                      InkWell(
                        onTap: (){Navigator.pushNamed(context, "/login");},
                        child: Text("Login now", style: TextStyle(
                          fontSize: 13,
                          color: Colors.blue,
                        ),),
                      )
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
