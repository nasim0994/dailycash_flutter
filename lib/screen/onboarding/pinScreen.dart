import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../style/commonStyle.dart';

class PinScreen extends StatefulWidget {
  const PinScreen({super.key});

  @override
  State<PinScreen> createState() => PinScreenState();
}

class PinScreenState extends State<PinScreen> {
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
                Text("Verify Pin", style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(height: 2,),
                Text("A 6 digit pin has send your email account", style: TextStyle(color: Colors.black54),),
                SizedBox(height: 40,),

                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  pinTheme: AppPinThemeStyel(),
                  // enableActiveFill: true,
                  // animationType: AnimationType.fade,
                  animationDuration: Duration(microseconds: 300),
                  onCompleted: (value){},
                  onChanged: (value){},
                ),


                SizedBox(height: 12,),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: (){}, style: AppBtnStyle(), child: Text("Submit"),),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
