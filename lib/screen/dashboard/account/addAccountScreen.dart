import 'package:dailycash/layout/AppLayout.dart';
import 'package:dailycash/style/commonStyle.dart';
import 'package:flutter/material.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({super.key});
  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  @override
  Widget build(BuildContext context) {
    return AppLayout(
        title: "Crate Account",
        currentRoute: "/add-account",
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextFormField(decoration: AppInputStyle("label"),),
            ],
          ),
        )
    );
  }
}
