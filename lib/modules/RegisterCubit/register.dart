import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/layout_Screen.dart';
import 'package:social_app/modules/RegisterCubit/cubit.dart';
import 'package:social_app/modules/RegisterCubit/state.dart';
import 'package:social_app/modules/LoginCubit/login.dart';
import 'package:social_app/shared/component.dart';

class Register extends StatelessWidget {
  var email = TextEditingController();
  var userName = TextEditingController();
  var phone = TextEditingController();
  var pass = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialRegisterState>(
        listener: (context, state) {
          if(state is SocialCreateSuccessState){
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Layout()),
            );
          }
        },
        builder: (context, state) => Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  //image
                  Container(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Image.asset(
                        'assets/images/login.jpg',
                        fit: BoxFit.cover,
                        height: 290,
                        width: double.infinity,
                      )),
                  //Text
                  SizedBox(
                    height: 15.0,
                  ),
                  Text(
                    "SignUp",
                    style: GoogleFonts.oswald(fontSize: 40.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Welcome in social app",
                      style: GoogleFonts.oswald(
                        fontSize: 20.0,
                        color: Colors.grey[500],
                      )),
                  SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: Column(
                        children: [
                          defaultFormField(
                              label: 'Enter Your Email',
                              type: TextInputType.emailAddress,
                              preifx: Icons.email,
                              controller: email,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'email address must not be empty';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              suffix: SocialRegisterCubit.get(context).suffix,
                              isPassword:
                                  SocialRegisterCubit.get(context).isPassword,
                              suffixPressed: SocialRegisterCubit.get(context)
                                  .socialRegisterChangePasswordVisibilityState,
                              label: 'Enter Your password',
                              type: TextInputType.visiblePassword,
                              preifx: Icons.lock,
                              controller: pass,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'password must not be empty';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              // observeText: true,
                              label: 'Enter Your User Name',
                              type: TextInputType.text,
                              preifx: Icons.person,
                              controller: userName,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'name address must not be empty';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          defaultFormField(
                              // observeText: true,
                              label: 'Enter Your phone',
                              type: TextInputType.number,
                              preifx: Icons.phone_android_outlined,
                              controller: phone,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'phone address must not be empty';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          ConditionalBuilder(
                              condition: state is! SocialRegisterLoadingState,
                              builder: (context) => defaultButton(
                                  width: double.infinity,
                                  text: 'Register',
                                  color: HexColor('FFCBAD'),
                                  isUpperCase: true,
                                  raduis: 20.0,
                                  function: () {
                                    if (formKey.currentState?.validate() ??
                                        true) {
                                      SocialRegisterCubit.get(context)
                                          .userRegister(
                                              email: email.text,
                                              password: pass.text,
                                              name: userName.text,
                                              phone: phone.text);
                                    }
                                  }),
                              fallback: (context) => Center(
                                    child: CircularProgressIndicator(),
                                  )),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('I have already account',
                                  style: GoogleFonts.oswald(
                                    fontSize: 20.0,
                                    color: Colors.grey,
                                  )),
                              MaterialButton(
                                child: Text('Login',
                                    style: GoogleFonts.oswald(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
