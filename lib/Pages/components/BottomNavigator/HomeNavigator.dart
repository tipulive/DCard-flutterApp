
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Card/AddCardPage.dart';



class HomeNavigator extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
  return BottomNavigationBar(
   backgroundColor: Colors.yellow,
   currentIndex: 0,
   items: [
    BottomNavigationBarItem(
        icon: Icon(Icons.access_alarm),
        label: "Home",
        backgroundColor: Colors.blue
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.access_alarm),
        label: "Card",
        backgroundColor: Colors.blue
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.access_alarm),
        label: "Settings",//Account,Recent submitted
        backgroundColor: Colors.blue
    ),

   ],
   onTap: (index){
    if(index==0)
    {

     Get.back();

    }
    if(index==1)
     {
      Get.to(AddCardPage());
     }
   },
  );
 }
}