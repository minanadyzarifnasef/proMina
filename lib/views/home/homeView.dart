import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/controller/Cubit/auth/LoginCubit.dart';
import 'package:promina/controller/Cubit/home/GalleryCubit.dart';
import 'package:promina/controller/Cubit/home/GalleryState.dart';
import 'package:promina/views/auth/loginView.dart';
import 'package:promina/views/home/component/homePageButton.dart';
import 'package:promina/views/home/component/loaderShimmer.dart';
import 'package:promina/views/home/component/uploadAlert.dart';
import 'package:shimmer/shimmer.dart';
import '../global/appColors.dart';
import '../global/appStrings.dart';
import '../global/styleDesign.dart';
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Size? screenSize;

  @override
  void initState() {

    if(GalleryCubit.get(context).gallery==null)
      GalleryCubit.get(context).getGallery(GalleryCubit.get(context).gallery);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    screenSize=MediaQuery.of(context).size;
    var cubit = LoginCubit.get(context);
    return SafeArea(
      child:  Scaffold(
        backgroundColor: AppColors.backgroundColor,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Container(
            width: screenSize!.width,height:screenSize!.height,
            padding: EdgeInsets.symmetric(vertical: screenSize!.height*0.020,horizontal:screenSize!.width *0.074),
            decoration: BoxDecoration (
                image: DecorationImage(
                    image: AssetImage(AppStrings.homeBackgroundImg),
                    fit: BoxFit.fill
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AppStyle.pageTitleText("Welcome\n ${cubit.user!.user!.name!.split(" ")[0]}"),
                    const Spacer(),
                    //todo:change pic user
                    CircleAvatar(radius: 33,backgroundColor: AppColors.backgroundColor,backgroundImage: NetworkImage("https://img.freepik.com/free-photo/man-wearing-t-shirt-gesturing_23-2149393645.jpg"),)
                  ],
                ),
                SizedBox(height: screenSize!.height*0.056,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    HomePageButton("log out", "img/logout.png", (){
                      cubit.logout();
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Login()), (route) => false);
                    }),
                    Spacer(),
                    HomePageButton("upload", "img/upload.png", () =>
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return UploadAlert();
                        },
                      )
                    ),
                    Spacer(),


                  ],
                ),
                SizedBox(height: screenSize!.height*0.036,),
                Expanded(
                    child: BlocBuilder<GalleryCubit,GalleryState>(
                    buildWhen:(_,state) =>state is GalleryLoadedState||state is GalleryLoadingState,
                    builder: (context, state){
                      var cubit = GalleryCubit.get(context);
                      return state is GalleryLoadingState||cubit.gallery==null||cubit.gallery!.data==null?
                      GridView.builder(
                        itemCount: 18,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1, // set the aspect ratio of the children
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return LoaderShimmer();
                        },
                      ):
                      GridView.builder(
                        itemCount: cubit.gallery!.data!.images!.length,
                        gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1, // set the aspect ratio of the children
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin:const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              child: CachedNetworkImage(
                                imageUrl: cubit.gallery!.data!.images![index],
                                placeholder: (context, url) =>const  LoaderShimmer(),
                                errorWidget: (context, url, error) =>  Icon(Icons.error),
                                fit: BoxFit.cover,

                              ),
                            ),
                          )
                          //return FadeInImage(image: NetworkImage(cubit.gallery!.data!.images![index]), placeholder: CircularProgressIndicator());

                          /*Container(
                            margin:const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(cubit.gallery!.data!.images![index],),
                                  fit: BoxFit.cover
                              ),

                            ),

                          )*/;
                        },
                      );
                    }
                )
                ),
                SizedBox(height: screenSize!.height*0.025,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
