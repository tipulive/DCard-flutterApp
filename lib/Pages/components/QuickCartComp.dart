import 'dart:math';

import 'package:cool_alert/cool_alert.dart';
import 'package:dcard/Query/ParticipatedQuery.dart';

import 'package:dcard/models/Topups.dart';

import '../../models/BonusModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Query/CardQuery.dart';

import '../../Query/TopupQuery.dart';
import 'package:flutter/gestures.dart';
import 'ProfilePic.dart';


class QuickCartComp extends StatefulWidget {
  const QuickCartComp({Key? key}) : super(key: key);

  @override
  State<QuickCartComp> createState() => _QuickCartCompState();
}

class _QuickCartCompState extends State<QuickCartComp> {
  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];

  int _page=0;
  int limit=0;
  bool hasMoreData=true;
  bool isLoading=false;

  bool showOveray=false;

  @override
  Widget build(BuildContext context) {



    //return listdata();

    /*WidgetsBinding.instance.addPostFrameCallback((_) {

      QuickBonus();
    });*/
    return Stack(
      children: [
        listdata(),
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
    );
    //return Center(child: Text("hello"));




  }
  Widget listdata(){
    return  Column(
      children: [
        //ProfilePic().profile(),

        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Quick Cart ",style:GoogleFonts.roboto(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(

              onPressed: () async{
                Get.dialog(
                  AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Do you want to Confirm ?'),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(

                          //primary: Colors.grey[300],
                          backgroundColor: Colors.green,
                          elevation:0,
                        ),
                        onPressed: () async{
                          try {
                            setState(() {
                              showOveray=true;


                            });

                            var uidForm=Get.put(ParticipatedQuery()).dataCartui["resultData"]["uid"];
                            var Resul=(await ParticipatedQuery().ConfirmAllSubmitQuickBonusEventOnline(BonusModel(uid:uidForm,uidUser:'juma'))).data;
                            if(Resul["status"])
                            {
                              //Get.back();
                              CoolAlert.show(
                                context: context,
                                backgroundColor:Colors.orange,
                                type: CoolAlertType.success,
                                title:"Order!!!",
                                text: "This Order has Confirmed",
                                onConfirmBtnTap: () {
                                  // Add your event code here
                                  //print(Resul);
                                  setState(() {
                                    Get.put(ParticipatedQuery()).updateCartUi(Resul,false,true);
                                    Get.put(ParticipatedQuery()).dataCartui["products"].clear();



                                  });
                                  //print(Get.put(ParticipatedQuery()).dataCartui);


                                  Get.toNamed('/QuickBonus');

                                  //print(Get.put(ParticipatedQuery()).dataCartui);

                                  //Get.back();// Close the dialog
                                  //Get.back();
                                },

                              );

                              setState(() {
                                //print(Resul);
                                showOveray=false;



                              });



                            }
                            else{
                              Get.back();

                              setState(() {
                                showOveray=false;


                              });

                              CoolAlert.show(
                                context: context,
                                backgroundColor:Colors.red,
                                type: CoolAlertType.error,
                                title:"Error !!!",
                                text: "Something is Wrong Please Contact System Admin",
                                onConfirmBtnTap: () {
                                  // Add your event code here

                                },

                              );


                            }


                          } catch (e) {
                            setState(() {
                              showOveray=false;


                            });
                            CoolAlert.show(
                              context: context,
                              backgroundColor:Colors.orange,
                              type: CoolAlertType.warning,
                              title:"Device Error!!!",
                              text: "Your device is unable to establish a connection ",

                            );
                            Get.back();
                            print('Error: $e');
                          }

                        },
                        child: Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back(); // close the alert dialog
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );

              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10.0),
                //primary: Colors.grey[300],
                backgroundColor: Colors.green,
                elevation:0,
              ),
              child: Icon(
                Icons.done,
                size: 23.0,
                //color: Colors.black,
              ),
            ),
            ElevatedButton(

              onPressed: () async{
                Get.dialog(
                  AlertDialog(
                    title: Text('Confirmation'),
                    content: Text('Do you want to Delete  ?'),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(

                          //primary: Colors.grey[300],
                          backgroundColor: Colors.red,
                          elevation:0,
                        ),
                        onPressed: () async{
                          try {
                            var Resul=(await ParticipatedQuery().DeleteAllSubmitQuickBonusEventOnline(BonusModel(uid:'uid',uidUser:'uidUser'))).data;
                            if(Resul["status"])
                            {
                              setState(() {
                                //print(Resul);
                                isLoading=false;
                                hasMoreData=false;
                                _data.clear();


                              });
                              Quickdata();
                            }
                            else{

                            }


                          } catch (e) {
                            print('Error: $e');
                          }

                        },
                        child: Text('Yes'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back(); // close the alert dialog
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );

              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(10.0),
                //primary: Colors.grey[300],
                backgroundColor: Colors.red,
                elevation:0,
              ),
              child: Icon(
                Icons.delete_forever,
                size: 23.0,
                //color: Colors.black,
              ),
            ),
          ],
        ),

        Container(
          height: 55,
          //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
          margin: EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: TextField(

            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              ),
              labelText: 'Search',
            ),
            onChanged: (text) async{

              try {
                var Resul=(await ParticipatedQuery().SearchSubmitQuickBonusEventOnline(BonusModel(uidUser:'juma',productName:text),Topups(startlimit:limit,endlimit:_page))).data;
                if(Resul["status"])
                {
                  setState(() {
                    //print(Resul);
                    isLoading=false;
                    hasMoreData=false;
                    _data.clear();

                    _data.addAll(Resul["result"]);
                  });
                }
                else{
                  _data.clear();
                  Quickdata();
                }


              } catch (e) {
                print('Error: $e');
              }

              //print(this._data[index]["total_var"]);
              // print("Text changed to: $text");
            },
          ),
        ),

        Expanded(
          child: ListView.builder(

            controller: _scrollController,
            itemCount: _data.length+1,
            itemBuilder: (context, index) {

              if(index<_data.length)
              {
                FocusNode test=FocusNode() ;

                this._data[index]['focusNode']=test;
                return Card(
                  elevation:0,
                  //margin: EdgeInsets.symmetric(vertical:1,horizontal:5),
                  color:Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(13.0),
                    side: BorderSide(color:_data[index]["color_var"]??true?Colors.white:Colors.green, width: 2),
                  ),

                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(_getRandomIcon()),
                      backgroundColor:getRandomColor(),
                    ),
                    title:Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Stack(
                            children: [

                              RichText(
                                text: TextSpan(
                                  text: "${_data[index]['productName']}:",
                                  style: DefaultTextStyle.of(context).style,
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: "-${_data[index]["textchange_var"]??_data[index]["qty"]} -",
                                      style: TextStyle(color: Colors.blue),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          // do something when the user clicks the text
                                         _data[index]['focusNode'].requestFocus();
                                         //print(_data[index]['focusNode'].requestFocus());

                                        },

                                    ),
                                    TextSpan(
                                      text:"X ${_data[index]['price']} =${_data[index]["total_var"]?? _data[index]['price']}",
                                    ),
                                  ],
                                ),
                              ),

                              Positioned(
                                bottom:0,
                                left: 0,
                                right: 200,
                                child: TextField(

                                  textAlign: TextAlign.center,
                                  focusNode:_data[index]['focusNode'],
                                  decoration: InputDecoration(
                                    //hintText: '------',
                                    //hintText: 'Enter some text',
                                    border: InputBorder.none,
                                    filled: true,
                                    fillColor: Colors.transparent,
                                    contentPadding:EdgeInsets.zero,

                                  ),
                                  style: TextStyle(
                                    color: Colors.blue, // sets the color of the text
                                  ),
                                  cursorColor: Colors.red,
                                  onChanged: (text) {

                                    try {
                                      //numVal = num.parse(str);
                                      var myValue = double.tryParse(text);

                                      if (myValue != null && !myValue.isNaN) {
                                        //print('myValue is a number');
                                        setState(() {
                                          _data[index]['textchange']=false;
                                          _data[index]["color_var"]=true;
                                          this._data[index]["total_var"]=num.parse(this._data[index]["price"])*num.parse(text);

                                          var checkBonus=(_data[index]["bonusType"]=='Gift')?"${(num.parse(text)*num.parse(_data[index]["bonusValue"])).toInt()}Pcs of ${_data[index]["giftName"]}":"${(num.parse(text)*num.parse(_data[index]["bonusValue"]))}\$";
                                          _data[index]["textchange_var"]=text;
                                          _data[index]["bonus_var"]=checkBonus;
                                          _data[index]["qty_var"]=text;
                                          _data[index]["giftPcs_var"]=(_data[index]["bonusType"]=='Gift')?"${(num.parse(text)*num.parse(_data[index]["bonusValue"])).toInt()}":"${(_data[index]["giftPcs"])}";
                                          _data[index]["totBonus_var"]=(_data[index]["bonusType"]=='Gift')?"${(num.parse(text)*num.parse(_data[index]["bonusValue"])).toInt()}":"${(num.parse(text)*num.parse(_data[index]["bonusValue"]))}";
                                          (num.parse(text)>1)?_data[index]["showBtn"]=true:_data[index]["showBtn"]=false;



                                          // Update the value of _counter and trigger a rebuild
                                        });
                                      } else {
                                        setState(() {
                                          _data[index]['textchange']=true;//return to 1
                                          this._data[index]["total_var"]=num.parse(this._data[index]["price"])*num.parse("1");

                                          var checkBonus=(_data[index]["bonusType"]=='Gift')?"${(num.parse("1")*num.parse(_data[index]["bonusValue"])).toInt()}Pcs of ${_data[index]["giftName"]}":"${(num.parse("1")*num.parse(_data[index]["bonusValue"]))}\$";
                                          _data[index]["textchange_var"]="1";
                                          _data[index]["bonus_var"]=checkBonus;
                                          _data[index]["qty_var"]="1";
                                          _data[index]["giftPcs_var"]=(_data[index]["bonusType"]=='Gift')?"${(num.parse("1")*num.parse(_data[index]["bonusValue"])).toInt()}":"${(_data[index]["giftPcs"])}";
                                          _data[index]["totBonus_var"]=(_data[index]["bonusType"]=='Gift')?"${(num.parse("1")*num.parse(_data[index]["bonusValue"])).toInt()}":"${(num.parse("1")*num.parse(_data[index]["bonusValue"]))}";
                                          //(num.parse(text)>1)?_data[index]["showBtn"]=true:_data[index]["showBtn"]=false;



                                          // Update the value of _counter and trigger a rebuild
                                        });
                                      }
                                    } catch (e) {
                                      _data[index]["showBtn"]=false;
                                      print('Error: $e');
                                    }

                                    //print(this._data[index]["total_var"]);
                                    // print("Text changed to: $text");
                                  },
                                ),
                              ),
                            ],
                          ),
                        )






                      ],
                    ),

                      subtitle: Text("Bonus:${_data[index]["bonus_var"]??0}"),
                    trailing:Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[


                        _data[index]["showBtn"]??false?IconButton(
                          icon: Icon(Icons.done,
                              size: 23.0,
                              color: Colors.deepPurple),
                          onPressed: () async{
                            try {
                              isLoading=true;
                              var Resul=(await ParticipatedQuery().UpdateSubmitQuickBonusEventOnline(BonusModel(uid:"${_data[index]["id"]}",productName:_data[index]["productName"],qty:_data[index]["qty_var"]??1,price:_data[index]["price"],bonusType:_data[index]["bonusType"],giftName:_data[index]["giftName"],giftPcs:_data[index]["giftPcs_var"]??_data[index]["giftPcs"],bonusValue:_data[index]["bonusValue"],totBonusValue:_data[index]["totBonus_var"],status:"confirm"))).data;
                            if(Resul["status"])
                            {

                            setState(() {
                            _data[index]["showBtn"]=false;
                            _data[index]["color_var"]=false;
                            //print(Resul);
                            isLoading=false;


                            });
                            //Quickdata();
                            }
                            else{

                            }


                            } catch (e) {
                            print('Error: $e');
                            }
                          },
                        ) :Visibility(
                            visible:false,
                            child: Text("")),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                              size: 23.0,
                              color: Colors.red
                          ),
                          onPressed: () {
                            Get.dialog(
                              AlertDialog(
                                title: Text('Confirmation'),
                                content: Text('Do you want to Delete ${_data[index]["productName"]}?'),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(

                                      //primary: Colors.grey[300],
                                      backgroundColor: Color(0xff9a1c55),
                                      elevation:0,
                                    ),
                                    onPressed: () async{
               print(Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]);

               try {
                 var Resul=(await ParticipatedQuery().DeleteOnlySubmitQuickBonusEventOnline(BonusModel(uid:"${_data[index]["id"]}",uidUser:"juma"))).data;
                 if(Resul["status"])
                 {

                   if(Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]==1)
                   {

                     setState(() {
                       _data.clear();
                       Get.put(ParticipatedQuery()).dataCartui["cartshow"]=false;
                       Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]=0;
                       Get.put(ParticipatedQuery()).dataCartui["products"].clear();
                       //print(Resul);



                     });
                     Get.toNamed("QuickBonus");

                   }
                   else{
                     var cartRemove=Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]-1;
                     setState(() {
                       _data.clear();
                       //Get.put(ParticipatedQuery()).dataCartui["products"].remove("${_data[index]["productName"]}");
                       Get.put(ParticipatedQuery()).dataCartui["countData"]["count"]=cartRemove;


                     });

                     Quickdata();
                     Get.back();


                   }


                 }
                 else{

                 }


               } catch (e) {
                 print('Error: $e');
               }
                                    },
                                    child: Text('Yes'),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back(); // close the alert dialog
                                    },
                                    child: Text('Close'),
                                  ),
                                ],
                              ),
                            );

                          },
                        ),
                      ],
                    )

                    //trailing: Text()
                  ),
                );

              }
              else{
                return  Padding(
                  padding:EdgeInsets.symmetric(vertical: 32),
                  child:Center(
                      child:hasMoreData?
                      CircularProgressIndicator()
                          :Text("no more Data")

                  ),
                );
              }

            },
          ),
        ),
      ],
    );
  }
  void initState()
  {
    super.initState();
    //getapi();
    Quickdata();
    _scrollController.addListener(_scrollListener);
  }
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _page=_page+10;

      Quickdata();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override

  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }
  IconData _getRandomIcon() {
    Random random = Random();
    List<IconData> icons = [Icons.favorite,Icons.star,Icons.thumb_up,Icons.access_time,Icons.access_time,Icons.fastfood,Icons.directions_bike,      Icons.directions_walk,      Icons.directions_car,      Icons.directions_boat,      Icons.airplanemode_active,      Icons.airport_shuttle,      Icons.beach_access,      Icons.camera,      Icons.movie,      Icons.music_note,      Icons.spa,      Icons.palette,      Icons.account_balance,      Icons.attach_money,    ];
    return icons[random.nextInt(icons.length)];
  }
  scrolldata()async
  {
    if(isLoading) return;
    isLoading=true;
    //int limit=10;
    //var Resul=(await ScrollQuery().getapi(limit,_page)).data;
    var Resul=(await TopupQuery().GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",startlimit:limit,endlimit:_page,optionCase:'bonus'))).data;
    setState(() {
      isLoading=false;
      if(Resul["result"].length<limit)
      {
        isLoading=false;
        hasMoreData=false;
      }

      _data.addAll(Resul["result"]);
    });
  }

  //

  Quickdata()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;
    //var Resul=(await ScrollQuery().getapi(limit,_page)).data;
    var Resul=(await ParticipatedQuery().SearchSubmitQuickBonusEventOnline(BonusModel(uidUser:'juma'),Topups(startlimit:limit,endlimit:_page))).data;

    setState(() {
      isLoading=false;
      if(Resul["result"].length<limit)
      {
        isLoading=false;
        hasMoreData=false;
      }

      _data.addAll(Resul["result"]);
    });


  }




//
}


