
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Card/AddCardPage.dart';
import '../../Homepage.dart';
import '../../SettingPage.dart';



class HomeNavigator extends StatelessWidget {
 @override


 Widget build(BuildContext context) {
  //final myindex = Get.arguments??0;
  final myindex =0;

  return BottomNavigationBar(
   //backgroundColor: Colors.yellow,
   //backgroundColor: Color(0xff010a0e),
   currentIndex:myindex,
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

     Get.to(() => Homepage());

    }
    if(index==1)
    {

     Get.to(() =>AddCardPage(),arguments:1);
    }
    if(index==2)
    {

     Get.to(() =>SettingPage(),arguments:1);
    }
   },
  );
 }
}