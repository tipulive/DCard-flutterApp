import 'package:get/get.dart';

class HideShowState extends GetxController{

  var isVisible=false.obs;
  var isCameraVisible=true.obs;
  var isNumberValid=false.obs;
  var isNumber=true.obs;
  var profVisible=false.obs;

  isHiden(valData){
    isVisible.value=valData;
  }
  isCameraHiden(valData){
    isCameraVisible.value=valData;
  }
  isValid(valData){
    isNumberValid.value=valData;
  }
  isNumberCorrect(valData){
    isNumber.value=valData;
  }
  isprofileVisible(valData){
    profVisible.value=valData;
  }


}