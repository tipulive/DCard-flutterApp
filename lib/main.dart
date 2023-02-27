import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
//import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Pages/routes.dart';


import 'package:wakelock/wakelock.dart';
import 'package:get/get.dart';


import 'Pages/Login.dart';
import 'Query/AdminQuery.dart';



void main() {
  /*this will make apps not going to sleep Mode*/

  WidgetsFlutterBinding.ensureInitialized();
  Wakelock.enable();
  //i may add  Wakelock.disable(); // to make apps to go on sleep mode
  /*this will make apps not going to sleep Mode*/
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Demo',
      initialRoute: '/',
      getPages: AppRoutes.routes,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Demo Project'),
    );
  }
}


class MyHomePage extends StatefulWidget {

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {

  AdminQuery adminStatedata=Get.put(AdminQuery());













  Widget build(BuildContext context)
  {


    //final UserQuery getdata = Get.find();

    //yourFunction();
    //ConnectivityResult connectivity;
    return checkAuth();



  }


  checkAuth(){
    //print((await adminStatedata.obj));
    //AdminQuery().auth();
    adminStatedata.auth();
    if(((adminStatedata.obj)["result"])==0)
    {
      //print((adminStatedata.obj)["result"]);
      return Login();
     // return ScrollPage();

    }
    else{
      //print((adminStatedata.obj)["result"]);

      return Login();
      //return ScrollPage();
    }




  }

  Future<bool> checkInternet() async {
    try {

      var response = await Dio().get('https://google.com/');
      if (response.statusCode == 200) {
        return true;
        //print(true);
      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      return false;
      //print(false);
    }
  }
  apiPostData(apiData) async{
    try {

      var params =  {
        "item": "itemx",
        "onlineData":apiData,
        //"options": [1,2,3],
      };


      var url='http://10.0.2.2:8000/api/testPostData';
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {

        return response.data;
      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      return false;
      //print(false);
    }
  }
  apiGetData() async{
    try {
      // var url='https://dummyjson.com/products';
      var url='http://10.0.2.2:8000/api/testGetData';
      var response = await Dio().get(url);
      if (response.statusCode == 200) {

        return response.data;
      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      return false;
      //print(false);
    }
  }
  deleteData(String text) {
    //print(text);
  }

  insertData(String text) async{

  }
/* void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) {
      setState((){
        result=scanData;
      });
    });
  }
  @override
 void dispose(){
    controller?.dispose();
    super.dispose();
  }*/





}