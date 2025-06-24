import 'package:flutter/material.dart';

InputDecoration AppInputStyle(label){
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
      borderSide:BorderSide(color: Colors.blue)
    ),
    fillColor: Colors.white,
    filled: true,
    contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder:const OutlineInputBorder(
      borderSide: BorderSide(color: Colors.black12, width: 1)
    ),
    border: OutlineInputBorder(),
    labelText: label,
  );
}

ButtonStyle AppBtnStyle(){
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.blue,
    padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(4))
    ),
    foregroundColor: Colors.white,
  );
}

void showSuccessToast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: Colors.green.shade600,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}

void showErrorToast(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      backgroundColor: Colors.red.shade600,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}
