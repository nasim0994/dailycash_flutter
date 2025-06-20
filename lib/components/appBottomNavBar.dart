
import 'package:flutter/material.dart';

BottomNavigationBar appBottomNavBar(currentIndex,onItemChangeTab){
  return BottomNavigationBar(
    currentIndex: currentIndex,
    items: [
      BottomNavigationBarItem(
        icon: Icon(Icons.new_label),
        label: "New"
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.access_time_filled),
          label: "Progress"
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.check_circle),
          label: "Completed"
      ),
      BottomNavigationBarItem(
          icon: Icon(Icons.cancel),
          label: "Canceled"
      ),
    ],

    selectedItemColor: Colors.blue,
    unselectedItemColor: Colors.grey,

    showSelectedLabels: true,
    showUnselectedLabels: true,
    type: BottomNavigationBarType.fixed,

    onTap: onItemChangeTab,
  );
}