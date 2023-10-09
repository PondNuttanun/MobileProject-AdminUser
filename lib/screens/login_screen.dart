import 'package:admin_mosquito_project/provider/internet_provider.dart';
import 'package:admin_mosquito_project/provider/sign_in_provider.dart';
import 'package:admin_mosquito_project/screens/home_screen.dart';
import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:admin_mosquito_project/utils/config.dart';
import 'package:admin_mosquito_project/utils/next_screen.dart';
import 'package:admin_mosquito_project/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              lightGreen,
              midGreen,
              greenPrimary,
            ],
          )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome, Admin",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: whitePerl),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Automated identity verification which enables you to verify your identity",
                      //textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: whitePerl),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: whitePerl,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 3,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(Config.login_icon))),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 20),
                            RoundedLoadingButton(
                              onPressed: () {
                                handleGoogleSignIn();
                              },
                              controller: googleController,
                              successColor: lightRed,
                              width: MediaQuery.of(context).size.width * 0.80,
                              elevation: 0,
                              borderRadius: 25,
                              color: lightRed,
                              child: Wrap(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.google,
                                    size: 25,
                                    color: whitePerl,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Sign in with Google",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(
                                          color: whitePerl,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // handling google sigin in
  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackbar(context, "Check your Internet connection", Colors.red);
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackbar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handleAfterSignIn();
                      })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                        googleController.success();
                        handleAfterSignIn();
                      })));
            }
          });
        }
      });
    }
  }

  // handle after signin
  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, HomeScreen());
    });
  }
}
