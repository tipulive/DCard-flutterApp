
import 'package:dcard/Pages/Card/EditCardPage.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../Query/CardQuery.dart';

import '../Card/AddCardPage.dart';

import '../../models/CardModel.dart';
import '../../models/Admin.dart';

class UserAccountComp extends StatefulWidget {
  const UserAccountComp({Key? key}) : super(key: key);

  @override
  State<UserAccountComp> createState() => _UserAccountCompState();
}

class _UserAccountCompState extends State<UserAccountComp> {
  bool showOveray=false;
  @override
  Widget build(BuildContext context) {
    return ListView(


      children: [

        profile(),
        const SizedBox(height: 6.0,),
        divLine(),
        detailsProfile("Edit Profile",Icons.account_balance_wallet,":",0xffffffff,"textright",Icons.arrow_forward,"200\$",0xffffffff,editprofile),






      ],
    );
  }
  Widget profile(){
    return Stack(
      children: [
        Column(

          children: <Widget>[
            SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundImage: AssetImage("images/profile.jpg"),
              ),
            ),
            SizedBox(height:6.0),

            Text("${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["name"]??'none'}",style:GoogleFonts.pacifico(fontSize: 18,color: Colors.teal,fontWeight:FontWeight.w100),),
            SizedBox(height:3.0),
            Text("+ ${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["PhoneNumber"]??'none'}",style: GoogleFonts.robotoCondensed(fontSize: 18,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 25,
                  height: 25,
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    //border: Border.all(color: Colors.black,width: 2)
                  ),
                  child: Icon(Icons.phone
                    ,size: 18,
                    color: Colors.black,),
                ),
                SizedBox(width: 1,),
                Text("Profile",style: GoogleFonts.robotoCondensed(fontSize: 18,color: Colors.deepOrange,fontWeight: FontWeight.bold),),
              ],
            ),
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
  editprofile() async{
    await scanPopup();
  }
  scanPopup(){

    Get.bottomSheet(
        Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SingleChildScrollView(
              child: Container(
                height: 400,

                child: Column(
                  children: [
                    Container(

                      height: 400,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView(
                        children: [

                          myTextWidget()
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),


          ],
        )
    ).whenComplete(() {

      //do whatever you want after closing the bottom sheet
    });
  }
  Widget myTextWidget(){
    final TextEditingController name = TextEditingController(text:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["name"]??'none'}");
    final TextEditingController email = TextEditingController(text:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["email"]??'none'}");
    final TextEditingController Ccode = TextEditingController(text:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["Ccode"]??'none'}");
    final TextEditingController phone = TextEditingController(text:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["phone"]??'none'}");
    final TextEditingController initCountry= TextEditingController(text:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["initCountry"]??'none'}");
    final TextEditingController Country = TextEditingController(text:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["country"]??'none'}");
    final TextEditingController edit = TextEditingController(text:"edit");
    final TextEditingController password = TextEditingController(text:"1");
    var ResultData;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(

        children: [
          SingleChildScrollView(

            child: Center(
                child:Column(
                  children: [
                    SizedBox(height: 8,),
                    Text("EDIT PROFILE"),

                    Column(
                      children: [
                        TextField(
                          controller:name,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Enter name',
                            hintText: 'Enter name',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller:email,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Enter email',
                            hintText: 'Enter email',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),
                        SizedBox(height: 10,),
                        IntlPhoneField(
                          initialCountryCode: '${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["initCountry"]}',
                          controller: phone,
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
                            Ccode.text=country.dialCode;
                            Country.text=country.name;
                            initCountry.text=country.code;
                            // print('Country changed to: ' + country.name);
                            // print('Country changed to: ' + country.dialCode);
                          },
                        ),
                        TextField(
                          controller:Ccode,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Enter Ccode',
                            hintText: 'Enter Ccode',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller:phone,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Enter Phone',
                            hintText: 'Enter Phone',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller:Country,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Enter Country',
                            hintText: 'Enter Country',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),
                        SizedBox(height:10,),
                        TextField(
                          controller:edit,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Enter edit',
                            hintText: 'Enter edit',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),
                        SizedBox(height:10,),
                        TextField(
                          controller:password,
                          //obscureText: true,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                            border: OutlineInputBorder(),
                            labelText: 'Enter password',
                            hintText: 'Enter password',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                            ),

                          ),
                        ),

                      ],
                    ),
                    SizedBox(height: 10.0,),
                    FloatingActionButton.extended(
                      label: Text('Edit Profile'), // <-- Text
                      backgroundColor: Color(0xff940e4b),
                      icon: Icon( // <-- Icon
                        Icons.add_card,
                        size: 24.0,
                      ),
                      onPressed: ()async =>{
                        setState(() {
                          showOveray=true;
                        }),
                        ResultData=(await CardQuery().editAssignCardEventOnline(CardModel(uid:"none"),Admin(uid:"${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["uid"]??'none'}",name:name.text,email:email.text,Ccode:Ccode.text,phone:phone.text,initCountry:initCountry.text,country:Country.text,password:password.text,status:edit.text,subscriber:"none"))).data,
                        if(ResultData["status"])
                          {

                            await Get.put(CardQuery()).updateCardState((await Get.put(CardQuery()).GetDetailCardOnline(CardModel(uid:'${(Get.put(CardQuery()).obj)["resultData"]["UserDetail"]["carduid"]}'))).data),
                            setState(() {
                              Get.put(CardQuery()).obj;
                            }),
                            Get.close(1),
                            setState(() {
                              showOveray=false;
                            }),
                            Get.snackbar("Success", "Profile Edited Successfuly",backgroundColor: Color(0xff9a1c55),
                                colorText: Color(0xffffffff),
                                titleText: const Text("Card User",style:TextStyle(color:Color(
                                    0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                                icon: Icon(Icons.access_alarm),
                                duration: Duration(seconds: 4))
                          }
                        else{

                          Get.close(1),
                          setState(() {
                            showOveray=false;
                          }),
                          Get.snackbar("Error", "Something is Wrong Please Contact System Admin",backgroundColor: Color(
                              0xffdc2323),
                              colorText: Color(0xffffffff),
                              titleText: const Text("Card User",style:TextStyle(color:Color(
                                  0xffffffff),fontSize:18,fontWeight:FontWeight.w500,fontStyle: FontStyle.normal),),

                              icon: Icon(Icons.access_alarm),
                              duration: Duration(seconds: 4))

                        }



                      },

                    ),



                  ],
                )

            ),
          ),

        ],
      ),
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

Widget detailsProfile(IconText,icon,IconDescr,listBackground,IconrightText,iconright,IconDescrRight,listBackgroundRight,Function myfunct){


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
          Text("${IconText}:",style:GoogleFonts.pacifico(fontSize:15,color: Colors.teal,fontWeight: FontWeight.w700)),
          SizedBox(width:5,),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: 3.9),
              child: Text("${IconDescr}",style:GoogleFonts.pacifico(fontSize: 15)),
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

addCard()async{

  Get.to(() =>AddCardPage());
}
editCard()async{

  Get.to(() =>EditCardPage());
}

