import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promina/models/UserLogin.dart';
import '/controller/Cubit/auth/LoginState.dart';
import '/controller/Repositories/UserRepository.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  UserRepository userRepository= UserRepository();
  UserLogin? user;

  Future<UserLogin> login(String email, String password) async {
    user=null;
      emit(LoginLoadingState());

    try {
      Map res= await userRepository.authenticate(email: email, password: password);
      print(res.toString());
      user=UserLogin.fromJson(res);
      emit(LoginLoadedState());
      return user!;
    } catch (e) {
      print(e.toString());
      emit(LoginErrorState());
      return user!;

    }
  }

  Future<Null> logout() async {
    user=null;
    //todo :logout function
  }

}