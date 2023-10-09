import 'package:admin_mosquito_project/databaselearning/addlearning.dart';
import 'package:admin_mosquito_project/pages/learningpage.dart';
import 'package:admin_mosquito_project/databaselearning/updatelearning.dart';
import 'package:admin_mosquito_project/pages/ar3dpage.dart';
import 'package:admin_mosquito_project/pages/game.dart';
import 'package:admin_mosquito_project/pages/users.dart';
import 'package:admin_mosquito_project/provider/internet_provider.dart';
import 'package:admin_mosquito_project/provider/sign_in_provider.dart';
import 'package:admin_mosquito_project/screens/account_screen.dart';
import 'package:admin_mosquito_project/screens/home_screen.dart';
import 'package:admin_mosquito_project/screens/login_screen.dart';
import 'package:admin_mosquito_project/screens/splash_screen.dart';
import 'package:admin_mosquito_project/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) => InternetProvider()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: mosquitoTheme(),
        initialRoute: '/loginscreen',
        routes: {
          '/splashscreen': (context) => SplashScreen(),
          '/loginscreen': (context) => LoginScreen(),
          '/homescreen': (context) => HomeScreen(),
          '/accountscreen': (context) => AccountScreen(),
          '/ar3d': (context) => AR3Dpage(),
          '/game': (context) => Game(),
          '/add': (context) => AddLeaning(),
          '/update': (context) => UpdateLeaning(),
          '/learning': (context) => Learningpage(),
          '/users': (context) => Userspage(),
        },
      ),
    );
  }
}
