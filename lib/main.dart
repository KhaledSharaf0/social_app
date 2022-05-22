import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/cubit/cubit.dart';
import 'package:social_app/layout/cubit/state.dart';
import 'package:social_app/layout/layout_Screen.dart';
import 'package:social_app/modules/LoginCubit/login.dart';
import 'package:social_app/shared/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark
      ));

  Widget widget;


  var uId = CacheHelper.getData(key: 'uId');

  if(uId != null){
    widget = Layout();
  }else
  {
    widget = Login();
  }


  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {

  // final bool isDark;
  final Widget? startWidget;


  MyApp({
    // this.isDark,
    this.startWidget,
  });
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()..getUserData(),
        ),
      ],

      child: BlocConsumer<SocialCubit , SocialState>(
        listener:(context , state) {},
        builder: (context , state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      )
    );
  }
}
// theme: ThemeData(
//   scaffoldBackgroundColor: Colors.white,
//   appBarTheme: AppBarTheme(
//     backwardsCompatibility: false,
//     elevation: 0.0,
//     systemOverlayStyle: SystemUiOverlayStyle(
//         statusBarColor: Colors.white,
//         statusBarBrightness: Brightness.dark,
//         statusBarIconBrightness: Brightness.dark),
//     backgroundColor: Colors.white,
//   ),
// ),