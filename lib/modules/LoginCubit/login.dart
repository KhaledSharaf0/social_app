import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/layout_Screen.dart';
import 'package:social_app/modules/LoginCubit/cubit.dart';
import 'package:social_app/modules/LoginCubit/state.dart';
import 'package:social_app/modules/RegisterCubit/register.dart';
import 'package:social_app/shared/cache_helper.dart';
import 'package:social_app/shared/component.dart';

class Login extends StatelessWidget {
  var email = TextEditingController();
  var pass = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit, SocialLoginState>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                "Invalid Login",
                style: GoogleFonts.oswald(
                  fontSize: 25.0,
                  color: Colors.black,
                ),
              ),
              duration: Duration(seconds: 6),
              backgroundColor: HexColor('FFCBAD'),
              dismissDirection: DismissDirection.vertical,
            ));
          }

          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(
              key: 'token',
              value: state.uId,
            ).then((value) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Layout()),
              );
            });
          }
        },
        builder: (context, state) => Scaffold(
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
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
                    "Login",
                    style: GoogleFonts.oswald(fontSize: 40.0),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text("Welcome back again",
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
                              suffix: SocialLoginCubit.get(context).suffix,
                              isPassword:
                                  SocialLoginCubit.get(context).isPassword,
                              suffixPressed: SocialLoginCubit.get(context)
                                  .loginChangePasswordVisibility,
                              label: 'Enter Your password',
                              type: TextInputType.visiblePassword,
                              preifx: Icons.lock,
                              controller: pass,
                              validator: (value) {
                                if (value?.isEmpty ?? true) {
                                  return 'email address must not be empty';
                                }
                                return null;
                              }),
                          SizedBox(
                            height: 15.0,
                          ),
                          ConditionalBuilder(
                              condition: state is! SocialLoginLoadingState,
                              builder: (context) => defaultButton(
                                  width: double.infinity,
                                  text: 'Login',
                                  color: HexColor('FFCBAD'),
                                  isUpperCase: true,
                                  raduis: 20.0,
                                  function: () {
                                    if (formKey.currentState?.validate() ??
                                        true) {
                                      SocialLoginCubit.get(context).userLogin(
                                        email: email.text,
                                        password: pass.text,
                                      );
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
                              Text('Don\'t have account?',
                                  style: GoogleFonts.oswald(
                                    fontSize: 20.0,
                                    color: Colors.grey,
                                  )),
                              MaterialButton(
                                child: Text('Register',
                                    style: GoogleFonts.oswald(
                                      fontSize: 20.0,
                                      color: Colors.black,
                                    )),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Register()),
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
