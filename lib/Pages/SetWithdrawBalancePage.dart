import 'package:flutter/material.dart';
import 'components/BottomNavigator/HomeNavigator.dart';
import 'components/SetWithdrawBalanceComp.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class SetWithdrawBalancePage extends StatelessWidget {
  const SetWithdrawBalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(27.0), // customize toolbar height
        child: AppBar(
          backgroundColor: Colors.transparent, // set the background color to transparent
          elevation: 0, // remove the shadow
          leading: IconButton(
            icon: Icon(Icons.arrow_back,color: Colors.black,),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),

      //backgroundColor: Colors.yellow,
      //backgroundColor: Color(0xff010a0e),

      body:SetWithdrawBalanceComp(),
      bottomNavigationBar:HomeNavigator(),



    );

  }
}
