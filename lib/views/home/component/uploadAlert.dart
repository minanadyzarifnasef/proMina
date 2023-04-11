import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:promina/controller/Cubit/auth/LoginCubit.dart';
import 'package:promina/controller/Cubit/home/GalleryCubit.dart';
import 'package:promina/controller/Cubit/home/GalleryState.dart';
import 'package:promina/views/global/appStrings.dart';
import '/views/global/appColors.dart';
import '/views/home/component/alertButton.dart';
class UploadAlert extends StatelessWidget {
   UploadAlert({super.key});
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.backgroundColor.withOpacity(0.3),
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(32),

      ),
      content: Container(
        height: 270,width: 350,
        decoration:  BoxDecoration(
          shape: BoxShape.rectangle,
          color: AppColors.backgroundColor.withOpacity(0.3),
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
          border: Border.all(color: AppColors.backgroundColor)
        ),
        child:BlocBuilder<GalleryCubit,GalleryState>(
          buildWhen:(_,state) =>state is GalleryUploading||state is GalleryUploaded||state is GalleryUploadError,
            builder: (context, state){
              var galleryCubit = GalleryCubit.get(context);
              var authCubit = LoginCubit.get(context);
              return state is GalleryUploading?
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20,),
                  Text("Uploading",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold,fontFamily: AppStrings.fontFamily,),),
                ],
              ):
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AlertButton("Gallery", "img/images.png", 0xffEFD8F9, () async{
                    try{
                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                     await galleryCubit.uploadImage(authCubit, File(image!.path),context);


                    }catch(e){
                      print(e.toString());
                    }
                  }),
                  const SizedBox(height: 44,),
                  AlertButton("Camera","img/cameraImg.png" , 0xffEBF6FF,()async {
                    final XFile? image = await picker.pickImage(source: ImageSource.camera);
                    await galleryCubit.uploadImage(authCubit, File(image!.path),context);
                  }),
                ],
              );

            }

        )
      ),

    );
  }
}