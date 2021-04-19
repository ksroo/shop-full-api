import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shop_udemy/screens/login/cubit/cubit.dart';
import 'package:shop_udemy/screens/login/cubit/states.dart';
import 'package:shop_udemy/screens/register/registerScreen.dart';
import 'package:shop_udemy/screens/shopLayoyt/shopLayOut.dart';
import 'package:shop_udemy/shared/components/component.dart';
import 'package:shop_udemy/shared/network/local/cache_helper.dart';
import 'package:shop_udemy/widgets/customElevatedButton.dart';
import '/widgets/CustomTextFromField.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  static const routeName = "/LoginScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              CacheHlper.saveData(
                      key: "token", value: state.loginModel.data.token)
                  .then((value) {
                Navigator.pushReplacementNamed(context, ShopLayout.routeName);
              });
            } else {
              showToast(
                text: state.loginModel.message,
                state: ToastStates.ERROR,
              );
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Login now to browse our hot offers",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        CustomTextFromField(
                          controller: emailController,
                          labeltext: "Email Address",
                          prefix: Icon(
                            Icons.email_outlined,
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please Enter you email addres";
                            }
                          },
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomTextFromField(
                          controller: passwordController,
                          labeltext: "Password",
                          prefix: Icon(Icons.lock_outline),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Password is too short";
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopLoginLoadingState,
                          builder: (context) => CustomElevatedButton(
                            height: 40,
                            width: double.infinity,
                            onPressed: () {
                              if (formkey.currentState.validate()) {
                                ShopLoginCubit.get(context).userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            text: "Login",
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don\'t have an account?",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, RegisterScreen.routeName);
                                },
                                child: Text(
                                  "register",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
