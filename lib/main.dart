import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/controller/Cubit/auth/LoginCubit.dart';
import 'package:promina/controller/Cubit/home/GalleryCubit.dart';
import 'package:promina/views/global/appColors.dart';
import 'package:promina/views/global/appStrings.dart';
import 'views/auth/loginView.dart';
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp( MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginCubit(),),
        BlocProvider(create: (context) => GalleryCubit()..getGallery(LoginCubit.get(context)),),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        title: 'ProMina',
        theme: ThemeData(
            fontFamily: AppStrings.fontFamily,
            colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue).copyWith(background: AppColors.backgroundColor)
        ),
        home:  Login(),
      ),
    );
  }
}


