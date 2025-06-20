import 'package:flutter/material.dart';

ListView TaskListView(taskItems){
  return ListView.builder(
    itemCount: taskItems.length,
    itemBuilder: (context, index){
      return Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Heading", style: TextStyle(color: Colors.blue, fontSize: 20),),
              Text("description", style: TextStyle(color: Colors.black54),),
            ],
          ),
        ),
      );
    },
  );
}