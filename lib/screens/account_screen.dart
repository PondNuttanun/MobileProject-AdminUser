import 'package:admin_mosquito_project/appbarmain.dart';
import 'package:admin_mosquito_project/maindrawer.dart';
import 'package:admin_mosquito_project/provider/sign_in_provider.dart';
import 'package:admin_mosquito_project/screens/login_screen.dart';
import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:admin_mosquito_project/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  Future getData() async {
    final sp = context.read<SignInProvider>();
    sp.getDataFromSharedPreferences();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final sp = context.watch<SignInProvider>();
    return Scaffold(
      appBar: AppBarMain(title: 'Account'),
      drawer: MainDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Profile",
                    style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                                    color: litBlack,
                                  ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  CircleAvatar(
                    backgroundColor: whitePerl,
                    backgroundImage: NetworkImage(
                      "${sp.imageUrl}",
                    ),
                    radius: 100,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8, // 80% ของความกว้างของหน้าจอ
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: whitePerl,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: midGreen,
                              blurRadius: 20,
                              offset: Offset(0, 8)),
                        ]),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.face,
                            color: midGreen,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${sp.name}",
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: litBlack,
                                    fontWeight: FontWeight.bold,
                                  ),
                          ), //display name of signed in account
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8, // 80% ของความกว้างของหน้าจอ
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: whitePerl,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                              color: midGreen,
                              blurRadius: 20,
                              offset: Offset(0, 8)),
                        ]),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.mail_outline,
                            color: midGreen,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "${sp.email}",
                            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: litBlack,
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      sp.userSignOut();
                      nextScreenReplace(context, const LoginScreen());
                    },
                    color: darkRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Text(
                      "Log Out",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: whitePerl,
                                    fontWeight: FontWeight.bold,
                                  ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
