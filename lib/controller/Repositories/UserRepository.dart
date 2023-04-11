import 'dart:convert';

import 'package:http/http.dart'as http;
import '/views/global/appStrings.dart';

class UserRepository {
  Future<Map> authenticate({required String email,required String password}) async {
    Map<String, String> body=
    {
      'email':email,
      'password':password,
    };
    var header={
      "Accept":'application/json'
    };
    final response = await http.post(Uri.parse("${AppStrings.mainURL}auth/login"),body: body,headers: header);

    Map mapResponse = json.decode(response.body);
    return mapResponse;
  }
}