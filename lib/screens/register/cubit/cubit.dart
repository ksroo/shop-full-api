import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_udemy/model/login_model.dart';
import 'package:shop_udemy/screens/register/cubit/states.dart';
import 'package:shop_udemy/shared/network/end_points.dart';
import 'package:shop_udemy/shared/network/remote/dio_helper.dart';

class ShopRigesterCubit extends Cubit<ShopRegisterStates> {
  ShopRigesterCubit() : super(ShopRegisterInitialState());
  static ShopRigesterCubit get(context) => BlocProvider.of(context);

  ShoppLoginModel loginModel;

  void userResigster({
    @required String email,
    @required String password,
      @required String name,
    @required String phone,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    ).then((value) {
      print(value.data);
      loginModel = ShoppLoginModel.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
    });
  }
}
