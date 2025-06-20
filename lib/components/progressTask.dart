import 'package:flutter/material.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({super.key});

  @override
  State<ProgressTask> createState() => ProgressTaskState();
}

class ProgressTaskState extends State<ProgressTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("progress"),
    );
  }
}
