import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/controller/Cubit/home/GalleryState.dart';
import 'package:promina/controller/Repositories/GalleryRepositry.dart';
import 'package:promina/models/GalleryModel.dart';


class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());
  static GalleryCubit get(context) => BlocProvider.of(context);
  GalleryRepository galleryRepository= GalleryRepository();
  Gallery? gallery;

  Future<dynamic> getGallery(cubic) async {
      emit(GalleryLoadingState());
    try {
      Map res= await galleryRepository.getGallery(cubic);
      gallery=Gallery.fromJson(res);
      emit(GalleryLoadedState());
      return gallery!;
    } catch (e) {
      emit(GalleryLoadedState());
      return ;

    }
  }


  Future<dynamic> uploadImage(cubit,File img,context) async {
    emit(GalleryUploading());
   // try {
    await galleryRepository.uploadImage(cubit,img,context).then((response)async{
      if(response!=null&&response.statusCode==200)
      {
        final respStr = await response.stream.bytesToString();
        Map mapResponse =await json.decode(respStr);
        if(mapResponse!=null&&mapResponse['status']=='success')
        {
          print("GalleryUploaded");
          emit(GalleryUploaded());
        }

      }
    });





   /* } catch (e) {
      print(e.toString());
      emit(GalleryUploadError());
      return res!;

    }*/
  }




}