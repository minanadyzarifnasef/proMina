import 'dart:convert';
import 'dart:io';
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:promina/controller/Cubit/home/GalleryCubit.dart';
import 'package:promina/controller/Cubit/home/GalleryState.dart';
import '../../views/global/appStrings.dart';


class GalleryRepository {
  Future<Map> getGallery(cubic) async {
    var header={
      "Accept":'application/json',
      "Authorization": "Bearer ${cubic.user!.token!}"

    };
    final response = await http.get(Uri.parse("${AppStrings.mainURL}my-gallery"),headers: header);

    Map mapResponse = json.decode(response.body);
    return mapResponse;
  }

  Future<http.StreamedResponse?> uploadImage(cubit,File file,context) async {
    var postUri = Uri.parse("${AppStrings.mainURL}upload");
      var request =  http.MultipartRequest("POST", postUri);
    var header={
      "Accept":'application/json',
      //"Authorization": "Bearer ${cubic.user!.token!}"
      "Authorization": "Bearer ${cubit.user!.token!}"

    };
    request.headers.addAll(header);
    request.files.add( http.MultipartFile.fromBytes('img',await file.readAsBytesSync(),filename: "${DateTime.now().toString()}.jpg"));
    request.send().then((response)async {

      if (response.statusCode == 200) {
        GalleryCubit.get(context).emit(GalleryLoadedState());
        Navigator.pop(context);
        GalleryCubit.get(context).getGallery(cubit);
        return response;

      };

    });

  }
}