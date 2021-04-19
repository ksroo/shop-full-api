import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_udemy/model/login_model.dart';
import 'package:shop_udemy/screens/login/cubit/states.dart';
import 'package:shop_udemy/shared/network/end_points.dart';
import 'package:shop_udemy/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());
  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShoppLoginModel loginModel;

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {'email': email, 'password': password},
    ).then((value) {
      print(value.data);
      loginModel = ShoppLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}
