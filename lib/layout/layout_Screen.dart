import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';

class Layout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("New Feed"),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit
                .get(context)
                .model != null,
            builder: (context) {
              var model = FirebaseAuth.instance.currentUser?.emailVerified;
              print(model);
              return Column(
                children: [
                  if(model!)
                    Container(
                      color: Colors.amber.withOpacity(0.6),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                            ),
                            SizedBox(width: 20.0,),
                            Expanded(child: Text("please verify your email")),
                            SizedBox(width: 20.0,),
                            MaterialButton(onPressed: () {
                              FirebaseAuth.instance.currentUser?.sendEmailVerification().then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                    "Check your mail",
                                    style: GoogleFonts.oswald(
                                      fontSize: 25.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                  duration: Duration(seconds: 6),
                                  backgroundColor: HexColor('FFCBAD'),
                                  dismissDirection: DismissDirection.vertical,
                                ));
                              }).catchError((onError){});
                            },
                                child: Text("SEND",
                                  style: TextStyle(color: Colors.blue),))
                          ],
                        ),
                      ),

                    ),
                ],
              );
            }, fallback: (BuildContext context) => Center(child: CircularProgressIndicator(),),

          ),
        );
      },
    );
  }
}

