import 'package:flutter/material.dart';
import '/views/global/appStrings.dart';
class AlertButton extends StatelessWidget {
  String text;
  String icon;
  int color;
  Function onTap;

  AlertButton(this.text,this.icon,this.color,this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ()=>onTap(),
      child: Container(
        width: 184,height: 68,
        decoration: BoxDecoration(
          color: Color(color),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon),
            const SizedBox(width: 9,),
            Text(text,style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold,fontFamily: AppStrings.fontFamily,),),
          ],
        ),
      ),
    );
  }
}
