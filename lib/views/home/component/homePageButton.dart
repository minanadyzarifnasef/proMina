import 'package:flutter/material.dart';
import 'package:promina/views/global/appStrings.dart';
import '../../global/appColors.dart';
class HomePageButton extends StatelessWidget {
  String text;
  String icon;
  Function onTap;
   HomePageButton(this.text,this.icon,this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>this.onTap(),
      child: Container(
        padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 6),

        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withOpacity(0.57),
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
              colors: [
                AppColors.backgroundColor.withOpacity(0.57),
                AppColors.backgroundColor.withOpacity(0.43),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp
          ),

        ),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(this.icon),
            const SizedBox(width: 9,),
            Text(this.text,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400,fontFamily: AppStrings.secondaryFontFamily,),),
          ],
        ),
      ),
    );
  }
}
