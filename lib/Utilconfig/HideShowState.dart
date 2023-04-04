import 'package:get/get.dart';

class HideShowState extends GetxController{

  var isVisible=false.obs;

  isHiden(valData){
    isVisible.value=valData;
  }


}