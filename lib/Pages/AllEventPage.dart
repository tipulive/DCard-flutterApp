
import 'components/AllEventComp.dart';
import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'components/BottomNavigator/ProfileNavigator.dart';

class AllEventPage extends StatelessWidget {
  const AllEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("demo",style: TextStyle(color: Colors.teal)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),

        toolbarHeight:0, //hide Text in appbar
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle( //this to remove status Bar Background Colors
          statusBarColor: Colors.transparent, // <-- SEE HERE
          statusBarIconBrightness:
          Brightness.dark, //<-- For Android SEE HERE (dark icons)
          statusBarBrightness: Brightness.light,
        ),

      ),
      //backgroundColor: Colors.yellow,

      body: const AllEventComp(),
      bottomNavigationBar:ProfileNavigator(),


    );

  }
}
