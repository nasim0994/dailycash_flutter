import 'package:flutter/material.dart';
import 'package:taskapp/components/taskListView.dart';

import '../api/onboardingApi.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key});

  @override
  State<NewTask> createState() => NewTaskState();
}

class NewTaskState extends State<NewTask> {
  List taskItems = [{"title":"title"},{"description":"description"}];
  bool isLoading = true;

  @override
  void initState(){
    callData();
    super.initState();
  }

  callData()async{
    var data = await GetTaskReq("New");
    setState(() {
      isLoading=false;
      // taskItems=data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading?(Center(child: CircularProgressIndicator(),)):(
      RefreshIndicator(
        onRefresh: ()async{
          await callData();
        },
        child: Center(
          child: TaskListView(taskItems),
        ),
      )
    );
  }
}
