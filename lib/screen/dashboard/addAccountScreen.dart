import 'package:dailycash/layout/AppLayout.dart';
import 'package:flutter/cupertino.dart';

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
        child: Text("add account")
    );
  }
}
