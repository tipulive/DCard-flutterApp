import 'dart:convert';
import 'dart:io';

import 'package:dcard/Query/CardQuery.dart';
import 'package:dcard/Query/TopupQuery.dart';
import 'package:dcard/models/CardModel.dart';
import 'package:dcard/models/Topups.dart';
import 'package:dio/dio.dart';
import '../Pages/ProfilePage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:wakelock/wakelock.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:dcard/models/Admin.dart';
import 'package:dcard/models/Participated.dart';
import 'package:dcard/models/Promotions.dart';
import '../Query/AdminQuery.dart';
import '../Pages/components/BottomNavigator/HomeNavigator.dart';

import '../models/User.dart';
import '../Query/UserQuery.dart';

import 'package:cool_alert/cool_alert.dart';


import 'package:dcard/Query/PromotionQuery.dart';
import '../Query/ParticipatedQuery.dart';
import 'package:dcard/Dateconfig/DateClassUtil.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);



  @override
  State<Homepage> createState() => _HomepageState();


}
class _HomepageState extends State<Homepage> {




  TextEditingController uidInput=TextEditingController();//uid promo
  TextEditingController uidInput2=TextEditingController(text:'kebineericMuna_1668935593');//userid of user that will be available after qr scan
  TextEditingController uidInput3=TextEditingController();//input data to submit
  TextEditingController uidInput4=TextEditingController();
  TextEditingController uidInput5=TextEditingController();
  bool showprofile=true;
  final GlobalKey qrkey = GlobalKey(debugLabel: 'QR');
  Barcode?result;
  QRViewController?controller;
  var _groupVal ="male";

  bool optionVal=true;
  List items=["male","female","others","Keb"];

  bool Cameravalue=true;
  bool Flashvalue=true;

  @override

  @override
  Widget build(BuildContext context)
  {


    void reassemble(){
      super.reassemble();
      //controller!.resumeCamera();
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
    PromotionQuery promotionState=Get.put(PromotionQuery());
    AdminQuery adminStatedata=Get.put(AdminQuery());


   // ParticipatedQuery participatedState=Get.put(ParticipatedQuery());
    DateClassUtil DateState=Get.put(DateClassUtil());

    //Map<String,dynamic> Promo_data=promotionState.obj["resultData"]??promotionState.obj;

    //FocusScope.of(context).unfocus();//hide keyboard on screen loadin
    return Scaffold(
      body:Column(
        children: [
          Visibility(
            visible:true,
            child: Expanded(
                flex: 5,
                child:Stack(
                  alignment:Alignment.bottomCenter,
                  children: [
                    QRView(key: qrkey,onQRViewCreated: _onQRViewCreated,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            CameraSwitch(),
                           //SizedBox(width: 10.0,),

                           // SizedBox(width: 10.0,),
                            FlashSwitch(),
                            Image.asset(
                              Flashvalue ? 'images/on.png' : 'images/off.png',
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),

                  ],
                )

            ),

          ),
          
          Expanded(
            flex: 2,
            child: SingleChildScrollView(

              child: Center(
                  child:Column(
                    children: [
                      (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),



                    GetBuilder<PromotionQuery>(
                         // init:PromotionQuery(),
                          builder: (promotionState){

                            if((promotionState.obj["id"])==1) return Center(child: CircularProgressIndicator());
                            uidInput.text="${(promotionState.obj["resultData"]["result"][0]["uid"])}";
                            uidInput4.text="${(promotionState.obj["resultData"]["result"][0]["reach"])}";
                            uidInput5.text="${(promotionState.obj["resultData"]["result"][0]["gain"])}";
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(

                                children: [
                                  Visibility(
                                      visible: true,
                                      child: Column(

                                        children: [
                                          TextField(
                                            controller: uidInput,
                                            //obscureText: true,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                              border: OutlineInputBorder(),
                                              labelText: 'userid after qrcode search ',
                                              hintText: 'Enter your name',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              ),

                                            ),
                                          ),
                                          SizedBox(height: 10.0,),
                                          TextField(
                                            controller: uidInput2,
                                            //obscureText: true,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                              border: OutlineInputBorder(),
                                              labelText: 'UserInput',
                                              hintText: 'Enter your name',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              ),

                                            ),
                                          ),
                                          SizedBox(height: 10.0,),
                                          TextField(
                                            controller: uidInput3,

                                            //obscureText: true,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                              border: OutlineInputBorder(),
                                              // labelText: 'Enter ${Promo_data["result"][0]["promo_msg"]}',${promotionState.obj["resultData"]["result"][0]["uid"]}
                                              labelText: '${(promotionState.obj["resultData"]["result"][0]["promo_msg"])}',
                                              hintText: 'InputData',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              ),
                                              suffixIcon:  GestureDetector(
                                                child: Icon(Icons.settings),
                                                onTap: () {

                                                  Get.dialog(
                                                    AlertDialog(
                                                      title: const Text('Dialog'),
                                                      content:SingleChildScrollView(
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          mainAxisAlignment:MainAxisAlignment.start,
                                                          crossAxisAlignment:CrossAxisAlignment.start,
                                                          children: <Widget> [
                                                            for(var i=0;i<items.length;i++)
                                                              RadioListTile(
                                                                title: Text("${i==null?"none":items[i]}"),
                                                                value: "${i==null?"none":items[i]}",
                                                                //value:"${items[i]}",

                                                                groupValue:_groupVal,
                                                                onChanged: (value){

                                                                  this._groupVal=items[i];
                                                                  //value="male";
                                                                  print(_groupVal);
                                                                  //print(_groupVal);
                                                                 //Get.back(result: value);
                                                                 // Get.back();
                                                                },
                                                              ),

                                                          ],
                                                        ),
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          child: const Text("Close"),
                                                          onPressed: () => Get.back(),
                                                        ),
                                                      ],
                                                    ),
                                                  );


                                                  // Perform some action when the icon is pressed
                                                },
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 10.0,),
                                          TextField(
                                            controller: uidInput4,
                                            //obscureText: true,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                              border: OutlineInputBorder(),
                                              labelText: 'reach',
                                              hintText: 'reache',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              ),

                                            ),
                                          ),
                                          SizedBox(height: 10.0,),
                                          TextField(
                                            controller: uidInput5,
                                            //obscureText: true,
                                            decoration: InputDecoration(
                                              contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                                              border: OutlineInputBorder(),
                                              labelText: 'gain',
                                              hintText: 'gain',
                                              hintStyle: TextStyle(
                                                color: Colors.grey,
                                              ),

                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ],
                              ),
                            );


                          }),

                      TextButton(
                          onPressed: ()async =>{

                            await Get.put(ParticipatedQuery()).ParticipateEventOnline(Participated(uid:uidInput.text,uidUser:uidInput2.text,inputData:uidInput3.text),Promotions(reach:uidInput4.text,gain:uidInput5.text)),
                            //print((Get.put(ParticipatedQuery()).obj)),
                            if((Get.put(ParticipatedQuery()).obj)["resultData"]["reach"]!=null)
                              {
                                CoolAlert.show(
                                  context: context,
                                  backgroundColor:Color(0xff940e4b),
                                  type: CoolAlertType.success,
                                  title:"Congratulation !!!",
                                  text: "You Reach ${(Get.put(ParticipatedQuery()).obj)["resultData"]["reach"]}\$ and You win ${(Get.put(ParticipatedQuery()).obj)["resultData"]["gain"]} !",

                                )
                              }else{
                              if((Get.put(ParticipatedQuery()).obj)["resultData"]["status"])
                                {
                                  Get.snackbar("Success", "Data Submitted",backgroundColor: Color(0xff9a1c55),
                                      colorText: Color(0xffffffff),
                                      titleText: Text("Participate"),

                                      icon: Icon(Icons.access_alarm),
                                      duration: Duration(seconds: 5)),
                                  showprofile=false,
                                }
                              //print((Get.put(ParticipatedQuery()).obj)),
                            }


                            //print(promotionState)
                           // print(promotionState.obj["resultData"]["result"][0]["uid"]),
                            //print((await CardQuery().GetDetailCardOnline(CardModel(uid:'TEALTD_7hEnj_1672352175')))["UserDetail"]["uid"]),
                          //uidInput2.text='${(await CardQuery().GetDetailCardOnline(CardModel(uid:'TEALTD_7hEnj_1672352175')))["UserDetail"]["uid"]}',
                          //CardQuery CardData=Get.put(CardQuery());
                            //print((await CardQuery().GetDetailCardOnline(CardModel(uid:'TEALTD_7hEnj_1672352175')))),
                            //print((await Get.put(CardQuery()).GetDetailCardOnline(CardModel(uid:'TEALTD_7hEnj_1672352175')))["UserDetail"]["uid"]),

                          //await loadData(true),
                            //(await Get.put(CardQuery()).GetDetailCardOnline(CardModel(uid:'TEALTD_7hEnj_1672352175')))["UserDetail"]["uid"],
                            //print((Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["name"]),


                          },
                          child: const Text("Participate")
                      ),
                      TextButton(
                          onPressed: () async=>{
                            //await controller!.toggleFlash(),
                            // Wakelock.enable()

                          /*CoolAlert.show(
                          context: context,
                            backgroundColor:Color(0xff940e4b),
                          type: CoolAlertType.success,
                          title:"Success !!!",
                          text: "Your transaction was successful!",

                          )*/

                            Get.snackbar("Success", "messag",backgroundColor: Color(0xff9a1c55),
                                colorText: Color(0xffffffff),
                                titleText: Text("test"),

                                icon: Icon(Icons.access_alarm),
                                duration: Duration(seconds: 5))

                          },

                          child: const Text("Enable")
                      ),


                      TextButton(
                          onPressed: () async=>{
                            await controller!.resumeCamera(),
                            // Wakelock.enable()
                          },
                          child: const Text("resume")
                      ),


                    ],
                  )

              ),
            ),
          ),
        ],
      ) ,
        bottomNavigationBar:HomeNavigator(),

      floatingActionButton: Visibility(
        visible:showprofile,

        child: FloatingActionButton(
          onPressed:()async =>{
           // Get.to(ProfilePage()),
           (await Get.put(TopupQuery()).GetBalance(Topups(uid:'kebineericMuna_1674160265'))),
           //print((Get.put(TopupQuery()).obj)["resultData"]["result"][0]["bonus"]),
            Get.to(() => ProfilePage())
          },
          tooltip: 'Increment',
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage("images/profile.jpg",
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.

    );

  }
  void _onQRViewCreated(QRViewController controller)
  {

    this.controller=controller;

    controller.scannedDataStream.listen((scanData) {
      setState(() async{
       // (result!=null)?Text("barcode Type ${describeEnum(result!.format)} Data ${result!.code}"): const Text("Scan Code"),
        //loadData((await Get.put(CardQuery()).GetDetailCardOnline(CardModel(uid:'${result!.code}')))["status"]);

        (result!=null)?"scan":loadDatafalse();

        result=scanData;
       //var check=(result!=null)?"${result!.code}":"0";
        if(result==null){
         // uidInput3.text='${showprofile}';
          //showprofile=false;
          loadData(false);
        }
        else{
          //showprofile=true;
          //uidInput2.text='${(await CardQuery().GetDetailCardOnline(CardModel(uid:'${result!.code}')))["UserDetail"]["uid"]}';
          //showprofile=true;

              uidInput2.text='${(await Get.put(CardQuery()).GetDetailCardOnline(CardModel(uid:'${result!.code}')))["UserDetail"]["uid"]}';
              await loadData(true);



        // uidInput3.text='${showprofile}';
        }

      });
    });
  }
  @override
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  Widget CameraSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
      activeColor: Colors.red,
     activeTrackColor: Colors.red.withOpacity(0.4),
     inactiveThumbColor: Colors.orange,
     inactiveTrackColor: Colors.blueAccent,

     value: Cameravalue,
    onChanged:(value)=>setState(() async{
      this.Cameravalue=value;
      await controller!.resumeCamera();
     //print(value);
    }),
    ),
  );
  Widget FlashSwitch()=>Transform.scale(
    scale: 1,
    child: Switch.adaptive(
      activeColor: Colors.red,
      activeTrackColor: Colors.red.withOpacity(0.4),
      inactiveThumbColor: Colors.orange,
      inactiveTrackColor: Colors.blueAccent,

      value:Flashvalue,
      onChanged:(value)=>setState(() async{
        this.Flashvalue=value;
        await controller!.toggleFlash();
        print(value);
      }),
    ),
  );

loadData(bole) async{

  setState(() {
    showprofile=bole;
  });
  //await PromotionQuery().getAllPromotionEventOnline();
    // Perform data loading here
   // Map<String, dynamic> _data=((await PromotionQuery().getAllPromotionEventOnline()));
   //print(_data);

   // return _data;
    //return ((await PromotionQuery().getAllPromotionEventOnline()));
  }
  loadDatafalse(){

    setState(() {
      showprofile=false;
    });
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


