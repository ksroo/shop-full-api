import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_udemy/model/ChangeFavoritesModels.dart';
import 'package:shop_udemy/model/categries_model.dart';
import 'package:shop_udemy/model/home_model.dart';
import 'package:shop_udemy/screens/cateogries/cateogries_screen.dart';
import 'package:shop_udemy/screens/favorites/favorites_screen.dart';
import 'package:shop_udemy/screens/products/products_screen.dart';
import 'package:shop_udemy/screens/settings/settings_screen.dart';
import 'package:shop_udemy/screens/shopLayoyt/cubit/states.dart';
import 'package:shop_udemy/shared/network/end_points.dart';

import 'package:shop_udemy/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    CateogriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel homeModel;

  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      //print(homeModel.data.banners.toString());

      homeModel.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });

      print(favorites.toString());
      emit(ShopSuccessHomeDactaState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategriesModel categriesModel;

  void getCategries() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      token: token,
    ).then((value) {
      categriesModel = CategriesModel.fromJson(value.data);
      print(homeModel.data.banners.toString());

      emit(ShopSuccessCategriesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategriesState());
    });
  }

  ChangeFavoritesModels changeFavoritesModels;

  void changeFavorites(int productId) {
    favorites[productId] = !favorites[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModels = ChangeFavoritesModels.fromJson(value.data);
      print(value.data);


      if(!changeFavoritesModels.status){
          favorites[productId] = !favorites[productId];
      }
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesState());
    });
  }
}
