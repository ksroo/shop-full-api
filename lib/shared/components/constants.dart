

import 'package:flutter/material.dart';
import 'package:shop_udemy/screens/login/loginScreen.dart';
import 'package:shop_udemy/shared/network/local/cache_helper.dart';

void signOut(context){

    CacheHlper.removeData(key: 'token').then((value) {
                if (value) {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                }
              });
}