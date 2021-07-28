import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CashHelper{
  static SharedPreferences? sharedPreferences;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future putData(@required String key,@required bool value)async{
    await sharedPreferences!.setBool(key.toString(), value);
  }

   static  getData(@required String key){
    return  sharedPreferences!.getBool(key);
  }
}