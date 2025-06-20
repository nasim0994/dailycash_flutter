import 'package:flutter/material.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({super.key});

  @override
  State<CompletedTask> createState() => CompletedTaskState();
}

class CompletedTaskState extends State<CompletedTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("completed"),
    );
  }
}
