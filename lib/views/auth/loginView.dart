import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/UserLogin.dart';
import '../../controller/Cubit/auth/LoginCubit.dart';
import '../../controller/Cubit/auth/LoginState.dart';
import '../../views/home/homeView.dart';
import '../global/appStrings.dart';
import '../global/appColors.dart';
import '../global/styleDesign.dart';

// ignore: must_be_immutable
class Login extends StatelessWidget {
  Size? screenSize;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginCubit? loginCubit;
  Login({super.key, @required this.loginCubit});


  @override
  Widget build(BuildContext context) {
    screenSize=MediaQuery.of(context).size;
    return  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width: screenSize!.width,height:screenSize!.height,
          decoration: BoxDecoration(

              image: DecorationImage(
                  image: AssetImage(AppStrings.loginBackgroundImg),
                fit: BoxFit.cover
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppStyle.head1Text("My\nGallery"),
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: screenSize!.width*0.09,vertical:  screenSize!.height*0.044),
                padding: EdgeInsets.symmetric(vertical: screenSize!.height*0.038),

                decoration: BoxDecoration(
                    color: AppColors.backgroundColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppStyle.head2Text("Log in"),
                     SizedBox(height: screenSize!.height*0.037,),
                    AppStyle.inputText(controller: _emailController, context: context,hintText: "User Name"),
                     SizedBox(height: screenSize!.height*0.037,),
                    AppStyle.inputText(controller: _passwordController, context: context,hintText: "Password",isPasswordViable: true),
                     SizedBox(height: screenSize!.height*0.037,),
                    BlocBuilder<LoginCubit,LoginState>(
                      buildWhen: (_,state) =>state is LoginLoadingState||state is LoginLoadedState||state is LoginErrorState,
                        builder: (context, state){
                          var cubit = LoginCubit.get(context);
                          return state is LoginLoadingState?
                          const CircularProgressIndicator():
                              AppStyle.submitButton(onTap:()async{
                               if(_emailController.text.isNotEmpty&&_passwordController.text.isNotEmpty)
                                 {
                                   await    cubit.login(_emailController.text, _passwordController.text);
                                   if(cubit.user!.token!=null&&cubit.user!.errorMessage==null)
                                   {
                                     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>Home()), (route) => false);

                                   }
                                   else
                                   {
                                     ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                         content: Text(cubit.user!.errorMessage!),
                                         backgroundColor: AppColors.errorColor,
                                       ),
                                     );
                                   }
                                 }
                               else
                                 {
                                   ScaffoldMessenger.of(context).showSnackBar(
                                       SnackBar(
                                     content:const Text("Empty Email or Password"),
                                     backgroundColor: AppColors.errorColor,
                                   ));
                                 }
                              } , textData: 'submit');


                        }
                    )
                    /*
                    BlocListener<LoginCubit, LoginState>(
                        listener: (context, state){
                          if (state is LoginLoadedState) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => Home()),
                            );
                          }
                          else if (state is LoginErrorState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                             const  SnackBar(
                                content: Text("email or password is invalid"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                      child: BlocBuilder<LoginCubit, LoginState>(
                          builder: (context, state){
                            return state is LoginLoadingState?const CircularProgressIndicator()
                                :
                              AppStyle.submitButton(
                                onTap: (){ () {
                                    loginCubit!.login(
                                      _emailController.text,
                                      _passwordController.text,
                                    );
                                  };
                                }, textData: "submit");
                          }
                      ),
                    ),*/


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
