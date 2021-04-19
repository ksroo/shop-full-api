import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_udemy/screens/search/search_screen.dart';

import 'package:shop_udemy/screens/shopLayoyt/cubit/cubit.dart';
import 'package:shop_udemy/screens/shopLayoyt/cubit/states.dart';

class ShopLayout extends StatelessWidget {
  static const routeName = "/HomeScreen";
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("Jomia"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, SearchScreen.routeName);
                },
                icon: Icon(Icons.search),
              ),
            ],
          ),
          body: cubit.bottomScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            fixedColor: Colors.deepOrange,
            onTap: (index) {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            backgroundColor: Colors.black26,
            items: [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.deepOrange,
                ),
                label: "Home",
              ),
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.apps,
                    color: Colors.deepOrange,
                  ),
                  label: "Categories"),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.deepOrange,
                ),
                label: "Favorites",
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.deepOrange,
                ),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
