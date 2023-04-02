import 'dart:math';


import 'package:dcard/Query/ParticipatedQuery.dart';

import 'package:dcard/models/Topups.dart';
import 'package:get/get.dart';

import '../../models/BonusModel.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/gestures.dart';



class SetStockComp extends StatefulWidget {
  const SetStockComp({Key? key}) : super(key: key);

  @override
  State<SetStockComp> createState() => _SetStockCompState();
}

class _SetStockCompState extends State<SetStockComp> {
  ScrollController _scrollController = ScrollController();// detect scroll
  List<dynamic> _data = [];
  var bottomResult=[];

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

        Text("Stocks",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),



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

                var resultData=(await ParticipatedQuery().getSearchAllStockOnline(Topups(startlimit:limit,endlimit:_page),BonusModel(uidUser:'',productName:text))).data;
                if(resultData["status"])
                {
                  setState(() {
                    //print(Resul);
                    isLoading=false;
                    hasMoreData=false;
                    _data.clear();

                    _data.addAll(resultData["result"]);
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
                  //color:Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(9.0),
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

                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 2),
                                  child: RichText(
                                    text: TextSpan(
                                      text: "${_data[index]['productCode']}(${(_data[index]['pcs']=='none')?'0':_data[index]['pcs']} Pcs):",
                                      style: DefaultTextStyle.of(context).style,
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: " 1X${_data[index]["price"]}",
                                          style: TextStyle(color: Colors.blue),


                                        ),

                                      ],
                                    ),
                                  ),
                                ),


                              ],
                            ),
                          )






                        ],
                      ),

                      subtitle: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 10),
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [

                            Icon(Icons.segment,color:Colors.orange,size:13,),
                            Text("tags:${_data[index]['tags']}"),

                          ],
                        ),
                      ),
                      trailing:num.parse(_data[index]["count"])>0?Container(child:
                      GestureDetector(
                          onTap: () async{
                            // This function will be called when the icon is tapped.
setState(() {
  showOveray=true;
});
                            try {


                              var resultData=(await ParticipatedQuery().getPreviousPriceOnline(Topups(endlimit:int.parse(_data[index]['count'])),BonusModel(uidUser:'',productName:_data[index]["productCode"]))).data;
                            if(resultData["status"])
                            {
                            setState(() {
                            //print(Resul);
                            isLoading=false;

                            bottomResult.clear();

                            bottomResult.addAll(resultData["result"]);
                            showOveray=false;
                            });
                           // print(bottomResult);
                            viewThisProduct();
                            }
                            else{
                              //showOveray=false;
                            bottomResult.clear();

                            }


                            } catch (e) {
                            Text("${e}");
                            }

                          },
                          child:Icon(Icons.grid_view,color:Colors.orange)
                      )


                      ):Visibility(
                        visible: false,
                          child: Text("")),

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


  //

  Quickdata()async
  {
    if(isLoading) return;
    isLoading=true;
    int limit=10;
    //var Resul=(await ScrollQuery().getapi(limit,_page)).data;
    var resultData=(await ParticipatedQuery().getSearchAllStockOnline(Topups(startlimit:limit,endlimit:_page),BonusModel(uidUser:'',productName:'none'))).data;

    setState(() {
      isLoading=false;
      if(resultData["result"].length<limit)
      {
        isLoading=false;
        hasMoreData=false;
      }
      _data.clear();

      _data.addAll(resultData["result"]);
    });


  }
  void viewThisProduct() {
    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [

            SingleChildScrollView(
              child: Container(
                 padding:EdgeInsets.all(5.0),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: ListView.builder(
                  itemCount: bottomResult.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(

                          border: Border(bottom
                              : BorderSide(
                            color: Colors.grey.withOpacity(0.1),
                            width: 5

                          ))),
                      child: Card(
                        elevation:0,

                        //color:Colors.grey,


                        child: ListTile(
                          title: Text('Price:1 x ${bottomResult[index]["price"]}'),
                        ),
                      ),
                    );

                  },
                ),
              ),
            ),
            if(showOveray)
            Positioned.fill(
              child: Container(
                color: Colors.black.withOpacity(0.5),
              ),
            ),
            if(showOveray)
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




//
}


