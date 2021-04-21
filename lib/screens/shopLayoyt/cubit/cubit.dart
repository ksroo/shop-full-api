import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_udemy/model/ChangeFavoritesModels.dart';
import 'package:shop_udemy/model/categries_model.dart';
import 'package:shop_udemy/model/favorites_model.dart';
import 'package:shop_udemy/model/home_model.dart';
import 'package:shop_udemy/model/login_model.dart';
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

      if (!changeFavoritesModels.status) {
        favorites[productId] = !favorites[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoritesState());
    }).catchError((error) {
      favorites[productId] = !favorites[productId];
      emit(ShopErrorChangeFavoritesState());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }


  ShoppLoginModel userModel;

  void getUserData() {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShoppLoginModel.fromJson(value.data);

      emit(ShopSuccessUserDataState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataState());
    });
  }


   void updateUserData({
     @required String name,
     @required String email,
     @required String phone,
   }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'email': email,
        'phone': phone,

      },
    ).then((value) {
      userModel = ShoppLoginModel.fromJson(value.data);

      emit(ShopSuccessUpdateUserState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUpdateUserState());
    });
  }
}
