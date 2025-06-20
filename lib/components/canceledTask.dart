import 'package:flutter/material.dart';

class CanceledTask extends StatefulWidget {
  const CanceledTask({super.key});

  @override
  State<CanceledTask> createState() => _CanceledTaskState();
}

class _CanceledTaskState extends State<CanceledTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("canceled"),
    );
  }
}
