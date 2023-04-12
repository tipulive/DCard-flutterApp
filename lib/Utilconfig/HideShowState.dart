import 'package:get/get.dart';

class HideShowState extends GetxController{

  var isVisible=false.obs;
  var isCameraVisible=true.obs;
  var isNumberValid=false.obs;

  isHiden(valData){
    isVisible.value=valData;
  }
  isCameraHiden(valData){
    isCameraVisible.value=valData;
  }
  isValid(valData){
    isNumberValid.value=valData;
  }


}