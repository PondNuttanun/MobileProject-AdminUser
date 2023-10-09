import 'package:admin_mosquito_project/appbarmain.dart';
import 'package:admin_mosquito_project/maindrawer.dart';
import 'package:admin_mosquito_project/provider/sign_in_provider.dart';
import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      appBar: AppBarMain(title: 'Home'),
      drawer: MainDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello Admin!",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: greenPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "${sp.name}",
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: greenPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "How are you today",
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: greenPrimary,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  color: midGreen,
                  thickness: 1.0,
                  indent: 10,
                  endIndent: 10,
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    MenuBuilder(
                      menuname: 'Users',
                      menuimgs: "assets/images/community.png",
                      menupage: '/users',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MenuBuilder(
                      menuname: 'Lesson',
                      menuimgs: "assets/images/mls.png",
                      menupage: '/learning',
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    MenuBuilder(
                      menuname: 'AR 3D Model',
                      menuimgs: "assets/images/3dmos.png",
                      menupage: '/ar3d',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container MenuBuilder(
      {required String menuname,
      required String menuimgs,
      required String menupage}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: lightGreen,
      ),
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                menuimgs,                
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  menuname,
                  style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: whitePerl,
                                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.all(10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "See Now",
                    style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    color: greenPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                  ),
                  onPressed: () => setState(() {
                    Navigator.pushNamed(context, menupage);
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
