import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      //backgroundColor: Colors.red,
      //backgroundColor: Color(0xd0ffffff),
      currentIndex: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: "Profile",
          backgroundColor: Colors.blue,
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            label: "Account",
            backgroundColor: Colors.blue
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_alarm),
            label:"Settings",
            backgroundColor: Colors.blue
        ),
      ],
      onTap: (index){
        if(index==0)
        {

          Get.back();

        }
      },
    );
  }
}