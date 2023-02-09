import 'dart:io';

import 'package:dcard/Query/AdminQuery.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import '../Utilconfig/ConstantClassUtil.dart';
import '../models/Topups.dart';

import '../DatabaseHelper.dart';

class TopupQuery extends GetxController{

  var store=8.obs;
  Map<String,dynamic> obj={
    "name":"name",
    "id":1,
    "result":[
      {
        "id":10
      }
    ],
  }.obs;
  Map<String,dynamic> obj2={
    "name":"name",
    "id":1,
    "result":[
      {
        "id":10
      }
    ],
  }.obs;
  GetBalanceHist(Topups TopupData) async{//balance and Bonus History
    try {

      var params =  {

        "uid":TopupData.uid,//userid
        //"uid":"kebineericMuna_1668935593",
        //"options": [1,2,3],
      };

      String Authtoken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetBalanceHist";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${Authtoken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


        // return (response.data).length;
        //updateEventState(response.data);
        //return "hello";

        updateBalanceHistState(response.data);
        return response.data;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }
  GetBalance(Topups TopupData) async{//balance and Bonus
    try {

      var params =  {

        "uid":TopupData.uid

        //"options": [1,2,3],
      };

      String Authtoken =(Get.put(AdminQuery()).obj)["result"][0]["AuthToken"];
      var url="${ConstantClassUtil.urlLink}/GetBalanceUser";
      var response = await Dio().get(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.authorizationHeader:"Bearer ${Authtoken}"
        }),
        queryParameters: params,
      );
      if (response.statusCode == 200) {


        // return (response.data).length;
        //updateEventState(response.data);
        //return "hello";

        updateTopupState(response.data);
        return response.data;


      } else {
        return false;
        //print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }
  }
  Future<List<Topups>> getGroceries() async {
    Database db = await DatabaseHelper.instance.database;
    var groceries = await db.query('groceries', orderBy: 'name');
    List<Topups> topupsList = groceries.isNotEmpty
        ? groceries.map((c) => Topups.fromMap(c)).toList()
        : [];
    return topupsList;
  }

  Future<int> add(Topups topupsdata) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('groceries', topupsdata.toMap());
  }

  Future<List<Topups>> getData() async{
    Database db = await DatabaseHelper.instance.database;
    var groceries=await db.rawQuery('SELECT *FROM groceries');
    List<Topups> topupsList = groceries.isNotEmpty
        ? groceries.map((c) => Topups.fromMap(c)).toList()
        : [];
    return topupsList;

  }
  Future addData() async{
    Database db = await DatabaseHelper.instance.database;
    await db.rawQuery('INSERT INTO testdata(name) VALUES("ndaje")');
  }
  testdata(Topups topupsdata) async {

    Database db = await DatabaseHelper.instance.database;
    //await db.rawQuery('INSERT INTO groceries(name) VALUES("${Topupsdata.name}")');
    int t1=0;
    await db.transaction((txn) async{
      int id1 = await txn.rawInsert(
          'INSERT INTO groceries(name) VALUES("${topupsdata.uid}")');

      t1=id1;
    });
    return t1;


  }

  updateTopupState(list){ //save user
    //store.value=7;
    obj={
      "id":4,
      "resultData":list,
    };
    update();




  }
  updateBalanceHistState(list){ //save user
    //store.value=7;
    obj2={
      "id":4,
      "resultData":list,
    };
    update();




  }


  getMyData() async{
    Database db = await DatabaseHelper.instance.database;
    List<Map> list=await db.rawQuery('select *from groceries');
    return list;
  }
}