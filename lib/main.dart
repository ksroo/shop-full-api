import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:shop_udemy/screens/register/registerScreen.dart';
import 'package:shop_udemy/screens/search/search_screen.dart';
import 'package:shop_udemy/screens/shopLayoyt/cubit/cubit.dart';
import 'package:shop_udemy/screens/shopLayoyt/shopLayOut.dart';
import 'package:shop_udemy/shared/network/end_points.dart';
import 'package:shop_udemy/shared/network/local/cache_helper.dart';
import 'package:shop_udemy/shared/network/remote/dio_helper.dart';
import '/screens/login/loginScreen.dart';
import '../shared/style/themes.dart';
import '../screens/on_boarding_screen.dart/onBoardingScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHlper.init();
  Widget widget;

  bool onBoarding = CacheHlper.getData(key: 'onBoarding');
   token = CacheHlper.getData(key: 'token');

  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = LoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;

  MyApp({this.startWidget});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context ) => ShopCubit()..getHomeData()..getCategries(),
          ),
        ],
          child: MaterialApp(
        theme: lightTheme,
        darkTheme: darkTheme,
        home: startWidget,
        // home: OnBoardingScreen(),
        routes: {
          LoginScreen.routeName: (ctx) => LoginScreen(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          ShopLayout.routeName: (ctx) => ShopLayout(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
        },
      ),
    );
  }
}
