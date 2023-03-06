import 'dart:convert';
import 'dart:io';

import 'package:dcard/Pages/ParticipateHistPage.dart';
import 'package:dcard/Query/CardQuery.dart';
import 'package:dcard/models/CardModel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../Query/AdminQuery.dart';
import '../models/Admin.dart';
import '../Utilconfig/ConstantClassUtil.dart';
import 'Homepage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final uidInput=TextEditingController();
  TextEditingController uidInput2=TextEditingController();
  AdminQuery adminStatedata=Get.put(AdminQuery());
  bool showOveray=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Login')),
        ),
        body: Stack(
          children: [
            Center(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),
                        child: Image.asset(
                          'images/playstore.png',
                          width: 80,
                          height: 80,
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child:ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                          ),

                          child: const Text('Action btn'),
                          onPressed: () async{
                            // ResultData=(await CardQuery().editAssignCardEventOnline(CardModel(uid:"none"),Admin(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",name:name.text,email:email.text,Ccode:Ccode.text,phone:phone.text,country:country.text,password:password.text,status:edit.text,subscriber:"none"))).data,
                            /*var ResultData=(await CardQuery().GetDataOnline(CardModel(uid:"none"))).data;

                        if(ResultData["status"])
                          {
                            await Get.put(CardQuery()).updateCardState(ResultData);
                           setState(() {
                             Get.put(CardQuery()).obj;
                           });
                          }
                        else{
                          print("failed");
                        }*/
                           // topupfunc();
                            Get.to(() => ParticipateHistPage());
                           // showon();
                            // print(((await CardQuery().editAssignCardEventOnline(CardModel(uid:"none"),Admin(uid: "kebineericMuna_1674160265",name:"voga",email:"on@gmail.com",Ccode:"+250",phone:"782389359",country:"Rwanda",password:"1",status:"edit",subscriber:"none"))).data).runtimeType);


                          },

                        ) ,

                      ),
                      Text("${Get.put(CardQuery()).obj["id"]==1?"hello":Get.put(CardQuery()).obj["resultData"]["result"]}"),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: IntlPhoneField(
                          decoration: InputDecoration(
                            labelText: 'Phone Number',
                            border: OutlineInputBorder(
                              borderSide: BorderSide(),
                            ),
                          ),
                          onChanged: (phone) {
                            print(phone.completeNumber);
                          },
                          onCountryChanged: (country) {
                            print('Country changed to: ' + country.code);
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextField(
                          controller: uidInput,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            labelText: 'Email',
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                        child: TextField(
                          controller: uidInput2,
                          obscureText: true,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(90.0),
                            ),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Container(
                          height: 80,
                          padding: const EdgeInsets.all(20),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(50),
                            ),
                            child: const Text('Log In'),
                            onPressed: () async{
                              //print(uidInput.text);
                              //print(await loginOnline());
                              await loginOnline();
                              // Get.to(() =>Aboutpage());
                            },
                          )),
                      TextButton(
                        onPressed: () {
                          print(uidInput.text);
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),



                    ],
                  ),
                ],
              ),
            ),
            if(showOveray)
            Positioned.fill(
              child: Center(
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.white70,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),

          ],
        )
    );
  }

  loginOnline() async{
  // print(await SyncService().SyncDownloadCard());
    //print(await SyncService().SyncUploadCard());
 //print(await CardQuery().SyncOffCardAdd());
setState(() {
  showOveray=true;
});
    try {

      var params =  {
        "email":uidInput.text,
        "password":uidInput2.text,
        //"options": [1,2,3],
      };


      var url="${ConstantClassUtil.urlLink}/AdminLoginEmail";
      var response = await Dio().post(url,
        options: Options(headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          // HttpHeaders.authorizationHeader:""
        }),
        data: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        //print(params);
       // print("done");
        //return response.data;
        //return response.data["User"]["name"];
        if((await AdminQuery().addData(Admin(uid:response.data["User"]["uid"],name:response.data["User"]["name"],subscriber:response.data["User"]["subscriber"],AuthToken: response.data["token"],email: response.data["User"]["email"],phone: response.data["User"]["tel"])))>0)
        {
          //Get.to(Homepage());
          //Get.to(() => Homepage());

          await adminStatedata.auth();
          Get.to(() => Homepage());
          //print(await SyncService().SyncDownloadCard());
        }
        else{
          // print((await AdminQuery().addData(Admin(uid:uidInput.text,subscriber: uidInput2.text)))),
        }


      } else {
        //return false;
        print(false);
      }
    } catch (e) {
      //return false;
      print(e);
    }


  }

  void topupfunc() {
    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                height: 200,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(

                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        children: [
                          SizedBox(height: 10.0,),
                          SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children: <Widget> [

                                  TextField(

                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Balance',
                                      hintText: 'Enter Balance',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  TextField(

                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    //obscureText: true,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                      border: OutlineInputBorder(),
                                      labelText: 'Enter Description',
                                      hintText: 'Enter Description',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),

                                    ),
                                  ),
                                  SizedBox(height: 10.0,),
                                  Center(
                                    child: FloatingActionButton.extended(
                                      label: Text('Add Balance'), // <-- Text
                                      backgroundColor: Colors.black,
                                      icon: Icon( // <-- Icon
                                        Icons.thumb_up,
                                        size: 24.0,
                                      ),
                                      onPressed: ()async =>{


                                      },




                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            Positioned(

              child: Container(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            ),
          ],
        )
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });
  }
  void showon(){
    Get.bottomSheet(
      Stack(
        children: [
          // your BottomSheet content goes here
          Container(
            padding: EdgeInsets.all(16),
            child: Text('BottomSheet Content'),
          ),
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              child: CircularProgressIndicator(),
            ),
          ),
        ],
      ),
    );

  }
}






