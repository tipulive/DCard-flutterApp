import 'dart:convert';
import 'dart:io';

import 'package:dcard/Query/CardQuery.dart';
import 'package:dio/dio.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wakelock/wakelock.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:dcard/models/Admin.dart';
import 'package:dcard/models/Participated.dart';
import 'package:dcard/models/Promotions.dart';
import '../../Query/AdminQuery.dart';
import '../../models/Admin.dart';
import '../../models/CardModel.dart';
import '../ProfilePage.dart';

import '../../Pages/components/BottomNavigator/HomeNavigator.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../components/BottomNavigator/HomeNavigator.dart';
import '../../models/User.dart';



import 'package:dcard/Query/PromotionQuery.dart';
import 'package:dcard/Query/ParticipatedQuery.dart';
import 'package:dcard/Dateconfig/DateClassUtil.dart';

class AddCardPage extends StatefulWidget {
  const AddCardPage({Key? key}) : super(key: key);

  @override
  State<AddCardPage> createState() => _AddCardPageState();


}
class _AddCardPageState extends State<AddCardPage> {




  TextEditingController uidInput=TextEditingController();
  TextEditingController uidInput2=TextEditingController(text:"kebine eric Muna");
  TextEditingController uidInput3=TextEditingController(text:"on1@gmail.com");
  TextEditingController uidInput4=TextEditingController();
  TextEditingController uidInput5=TextEditingController();
  TextEditingController uidInput6=TextEditingController(text:"1");
  TextEditingController uidInput7=TextEditingController(text:"TEALTD_7hEnj_1672352175");
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;

  @override

  @override
  Widget build(BuildContext context)
  {


    void reassemble(){
      super.reassemble();
      if(Platform.isAndroid)
      {
        controller!.resumeCamera();
      }else if (Platform.isIOS)
      {
        controller!.pauseCamera();
      }
    }
    @override
    //hidekeyboard();
    //UserQuery userQueryData = Get.put(UserQuery());
    AdminQuery adminStatedata=Get.put(AdminQuery());
    PromotionQuery promotionState=Get.put(PromotionQuery());
    // ParticipatedQuery participatedState=Get.put(ParticipatedQuery());
    DateClassUtil DateState=Get.put(DateClassUtil());
    Map<String,dynamic> Promo_data=promotionState.obj["resultData"]??promotionState.obj;
    //FocusScope.of(context).unfocus();//hide keyboard on screen loading
    return Scaffold(
      body:Column(
        children: [

          Visibility(
            visible: true,
            child: Expanded(
                flex: 3,
                child:QRView(key: qrkey,onQRViewCreated: _onQRViewCreated,)

            ),
          ),

          Expanded(
            flex: 2,
            child: SingleChildScrollView(

              child: Center(
                  child:Column(
                    children: [
                      SizedBox(height: 8,),
                     // (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),
                      (result!=null)?Text("New Code"): const Text("Scan Code"),

                      Column(
                        children: [
                          SizedBox(height: 8,),
                          IntlPhoneField(
                            initialCountryCode: 'CD',
                            controller: uidInput,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                            ),
                            onChanged: (phone) {

                              //uidInput2.text=phone.countryCode;
                              //uidInput2.text=phone.number;
                             // uidInput2.text=phone.countryISOCode;
                              //print(phone.completeNumber);
                            },
                            onCountryChanged: (country) {
                              uidInput4.text=country.dialCode;
                              uidInput5.text=country.name;
                             // print('Country changed to: ' + country.name);
                             // print('Country changed to: ' + country.dialCode);
                            },
                          ),
                          TextField(
                            controller: uidInput2,



                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                              border: OutlineInputBorder(),
                              labelText: 'Name',

                              hintText: 'Enter your name',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),

                            ),
                          ),
                          TextField(
                            controller: uidInput3,

                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                              hintText: 'Enter your Email',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),

                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: TextField(
                              controller: uidInput4,
                              //obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                border: OutlineInputBorder(),
                                labelText: 'country Code',
                                hintText: 'country Code',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: TextField(
                              controller: uidInput5,
                              //obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                border: OutlineInputBorder(),
                                labelText: 'Country',
                                hintText: 'Enter Country',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                            ),
                          ),
                          TextField(
                            controller: uidInput6,
                            //obscureText: true,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                              border: OutlineInputBorder(),
                              labelText: 'Password',
                              hintText: 'Enter your Password',
                              hintStyle: TextStyle(
                                color: Colors.grey,
                              ),

                            ),
                          ),
                          Visibility(
                            visible: true,
                            child: TextField(
                              controller: uidInput7,
                              //obscureText: true,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                border: OutlineInputBorder(),
                                labelText: 'CardUId',
                                hintText: 'Enter your name',
                                hintStyle: TextStyle(
                                  color: Colors.grey,
                                ),

                              ),
                            ),
                          ),

                        ],
                      ),
                      TextButton(
                          onPressed: ()async =>{
                           //print(uidInput2.text),

                            // print( (await ParticipatedQuery().getAllParticipateEventOnline()).data["status"])
                            //print( (await PromotionQuery().getAllPromotionEventOnline()),

                            print(await CardQuery().CreateAssignCardEventOnline(CardModel(uid:uidInput7.text),Admin(phone:uidInput.text,name:uidInput2.text,email:uidInput3.text,Ccode:uidInput4.text,country:uidInput5.text,password:uidInput6.text,uid: "no need", subscriber:"no need"))),
                          },
                          child: const Text("Add Card")
                      ),



                    ],
                  )

              ),
            ),
          ),
        ],
      ) ,
      bottomNavigationBar:HomeNavigator(),

    );

  }
  void _onQRViewCreated(QRViewController controller)
  {
    this.controller=controller;
    controller.scannedDataStream.listen((scanData) {
      setState((){
        result=scanData;
        uidInput7.text=(result!=null)?"${result!.code}":"0";
      });
    });
  }
  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  loadData() async{
    //await PromotionQuery().getAllPromotionEventOnline();
    // Perform data loading here
    // Map<String, dynamic> _data=((await PromotionQuery().getAllPromotionEventOnline()));
    //print(_data);

    // return _data;
    //return ((await PromotionQuery().getAllPromotionEventOnline()));
  }
//Method

//method
}


