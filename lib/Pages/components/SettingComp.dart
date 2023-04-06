


import 'package:dcard/Pages/SetEditCardNoPage.dart';
import 'package:dcard/Pages/SetStockPage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../SetPartHistPage.dart';
import '../SetQuickBoHistPage.dart';



class SettingComp extends StatefulWidget {
  const SettingComp({Key? key}) : super(key: key);

  @override
  State<SettingComp> createState() => _SettingCompState();
}

class _SettingCompState extends State<SettingComp> {

  bool showOveray=false;


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(


          children: [

            divLine(),
            detailsProfile("Stocks",Icons.calendar_month_outlined,"",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,ViewStock),//Last Time Purchase
            const SizedBox(height:5,),

            detailsProfile("Participate",Icons.calendar_month_outlined,"",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,partHistfunc),//Last Time Purchase
            const SizedBox(height:5,),
            detailsProfile("QuickBonus",Icons.paid,"",0xbfebf1ef,"textright",Icons.arrow_forward,"200\$",0xffffffff,QuickBoHistfunc),
            const SizedBox(height:5,),
            detailsProfile("Logout",Icons.account_balance,"",0xbfebf1ef,"textright",Icons.arrow_forward,"200\$",0xffffffff,logout),
            const SizedBox(height:5,),







          ],
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
    );
  }






}



Widget divLine(){
  return Container(
    margin: const EdgeInsets.all(8),
    child: Row(

      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(


                constraints: const BoxConstraints(maxWidth: 200,maxHeight: 5),
                //color: Color.fromRGBO(13,44,64, 0.4),
                color: Colors.white70
            ),
          ),
        ),
        const SizedBox(width: 100,),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(


                constraints: const BoxConstraints(maxWidth: 200,maxHeight: 5),
                //color: Color.fromRGBO(13,44,64, 0.4),
                color: Colors.white70
            ),
          ),
        )
      ],
    ),
  );
}

Widget detailsProfile(iconText,icon,iconDescr,listBackground,iconrightText,iconright,iconDescrRight,listBackgroundRight,Function myfunct){


  return ClipRRect(
    //borderRadius: BorderRadius.circular(32),
    child: Container(
      padding: EdgeInsets.all(8),
      //margin: const EdgeInsets.all(8),
      margin: EdgeInsets.fromLTRB(8,0,8,0),
      width: 400,
      height: 50,
      //color:Color(0xffffffff),
      color:Color(listBackground),

      child: Row(

        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(

              shape: BoxShape.circle,
              border: Border.all(color: Colors.yellow,width: 1.5),



            ),
            child: Icon(
              icon,color:
            Colors.amber,size: 22,),

          ),
          SizedBox(width:3,),
          Text("${iconText}:",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
          SizedBox(width:5,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 3.9),
              child: Text("${iconDescr}",style:GoogleFonts.pacifico(fontSize: 15)),
            ),
          ),

          Expanded(//right
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(

                    width: 30,
                    height: 30,

                    child:
                    GestureDetector(
                        onTap: () {
                          // This function will be called when the icon is tapped.
                          myfunct();
                        },
                        child: Icon(iconright,color:
                        Colors.teal,size: 22,)
                    )




                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}

ViewStock() async{
  //(await Get.put(TopupQuery()).GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));
  Get.to(() =>SetStockPage());

}
partHistfunc() async{
  //(await Get.put(ParticipatedQuery()).getCountParticipateEventOnline(Participated(uidUser:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));

  Get.to(() =>SetPartHistPage());


}
QuickBoHistfunc() async{
  //(await Get.put(TopupQuery()).GetBalanceHist(Topups(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}")));
  Get.to(() =>SetQuickBoHistPage());

}

EditCardfunc() async{
  Get.to(() =>SetEditCardNoPage());
}
logout() async{
  Get.to(() =>SetEditCardNoPage());
}







