import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:promina/views/global/appColors.dart';
import 'package:promina/views/global/appStrings.dart';

class AppStyle{
  static Widget head1Text(String textData){
    return Text(textData,textAlign: TextAlign.center,style: TextStyle(fontFamily:AppStrings.fontFamily,fontSize: 50,fontWeight: FontWeight.bold ),);
  }


  static Widget head2Text(String textData){
    return Text(textData,textAlign: TextAlign.center,style: TextStyle(fontFamily:AppStrings.fontFamily,fontSize: 30,fontWeight: FontWeight.bold ),);
  }

  static Widget inputText({@required controller, hintText="",  isPasswordViable=false, @required context,  keyboardType,}){

    return Padding(
        padding:const EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
        autofocus: false,
        obscureText:isPasswordViable,
        controller: controller,
        keyboardType: keyboardType,

        // style: TextStyle(color: secondColor),
        decoration: InputDecoration(
          filled: true,
          fillColor: AppColors.backgroundColor,
          hintText: hintText,

          hintStyle: TextStyle(color: AppColors.hintFontColor,fontSize: 16,fontWeight: FontWeight.w400),
          contentPadding:const EdgeInsets.symmetric(vertical: 12,horizontal: 20),

          border:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide:const BorderSide(width: 0, color: Colors.white)

          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
              borderSide:const BorderSide(width: 0, color: Colors.white)

          ),
          enabledBorder:  OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide:const BorderSide(width: 0, color: Colors.white)

          ),
        ),
      ),
    );
  }


  static Widget submitButton({@required onTap,@required textData}){

    return InkWell(
      onTap: ()=>onTap(),
     child: Container(
       margin:const EdgeInsets.symmetric(horizontal: 35),
       padding:const EdgeInsets.symmetric(vertical: 11),
       alignment: Alignment.center,
       decoration: BoxDecoration(
         color:const Color(0xFF7BB3FF),
         borderRadius: BorderRadius.circular(12)
       ),
       child: Text(textData,style: TextStyle(color: AppColors.secondaryFontColor,fontSize: 16,fontWeight: FontWeight.bold),),
     ),
    );
  }


  static Widget pageTitleText(String textData){
    return Text(textData,textAlign: TextAlign.left,style: TextStyle(fontFamily:AppStrings.secondaryFontFamily,fontSize: 32,fontWeight: FontWeight.w400 ),);
  }


}