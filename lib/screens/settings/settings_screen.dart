import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_udemy/screens/shopLayoyt/cubit/cubit.dart';
import 'package:shop_udemy/screens/shopLayoyt/cubit/states.dart';
import 'package:shop_udemy/shared/components/constants.dart';
import 'package:shop_udemy/widgets/CustomTextFromField.dart';
import 'package:shop_udemy/widgets/customElevatedButton.dart';

class SettingsScreen extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = model.data.name;
        emailController.text = model.data.email;
        phoneController.text = model.data.phone;

        return ConditionalBuilder(
          fallback: (context) => Center(child: CircularProgressIndicator()),
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(

                children: [
                  if(state is ShopLoadingUpdateUserState)
                  LinearProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFromField(
                    controller: nameController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'name must not be empty';
                      }
                      return null;
                    },
                    labeltext: 'Name',
                    prefix: Icon(Icons.person),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFromField(
                    controller: emailController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    labeltext: 'Email Address',
                    prefix: Icon(Icons.email),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomTextFromField(
                    controller: phoneController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'phone must not be empty';
                      }
                      return null;
                    },
                    labeltext: 'Phone',
                    prefix: Icon(Icons.phone),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        ShopCubit.get(context).updateUserData(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                        );
                      }
                    },
                    text: 'update',
                    width: 5,
                    height: 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CustomElevatedButton(
                    onPressed: () {
                      signOut(context);
                    },
                    text: 'Logout',
                    width: 5,
                    height: 5,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
