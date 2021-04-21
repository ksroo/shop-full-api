import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_udemy/screens/login/cubit/cubit.dart';
import 'package:shop_udemy/screens/register/cubit/cubit.dart';
import 'package:shop_udemy/screens/register/cubit/states.dart';
import 'package:shop_udemy/screens/shopLayoyt/shopLayOut.dart';
import 'package:shop_udemy/shared/components/component.dart';
import 'package:shop_udemy/shared/network/end_points.dart';
import 'package:shop_udemy/shared/network/local/cache_helper.dart';

import 'package:shop_udemy/widgets/CustomTextFromField.dart';
import 'package:shop_udemy/widgets/customElevatedButton.dart';

class RegisterScreen extends StatelessWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  static const routeName = "/RegisterScreen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopRigesterCubit(),
      child: BlocConsumer<ShopRigesterCubit, ShopRegisterStates>(
        listener: (context, state) {


          if (state is ShopRegisterSuccessState) {
            if (state.loginModel.status) {
              CacheHlper.saveData(
                      key: "token", value: state.loginModel.data.token)
                  .then((value) {
                token = state.loginModel.data.token;
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
                          "REGISTER",
                          style: TextStyle(
                            fontSize: 34,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Register now to browse our hot offers",
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
                          controller: nameController,
                          labeltext: "User Name",
                          prefix: Icon(
                            Icons.person,
                          ),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "Please Enter you name";
                            }
                          },
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
                          height: 15,
                        ),
                        CustomTextFromField(
                          controller: phoneController,
                          labeltext: "Phone",
                          prefix: Icon(Icons.phone),
                          validator: (String value) {
                            if (value.isEmpty) {
                              return "please enter your phone number";
                            }
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        ConditionalBuilder(
                          condition: state is! ShopRegisterLoadingState,
                          builder: (context) => CustomElevatedButton(
                            height: 40,
                            width: double.infinity,
                            onPressed: () {
                              if (formkey.currentState.validate()) {
                                ShopRigesterCubit.get(context).userResigster(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                );
                              }
                            },
                            text: "register",
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
