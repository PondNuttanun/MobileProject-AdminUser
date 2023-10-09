import 'package:admin_mosquito_project/provider/sign_in_provider.dart';
import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppBarMain extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const AppBarMain({
    super.key,required this.title
  });

  @override
  State<AppBarMain> createState() => _AppBarMainState();

  @override
  // TODO: implement preferredSize

  Size get preferredSize => const Size.fromHeight(60);
}

class _AppBarMainState extends State<AppBarMain> {
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
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.menu, color: litBlack),
        ),
      ),
      elevation: 0,
      title: Text(
        widget.title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              fontWeight: FontWeight.bold,
              color: litBlack,
            ),
      ),
      centerTitle: false,
      backgroundColor: whitePerl,
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 25, 8),
          child: InkWell(
            onTap: () {
              // เมื่อถูกแตะหรือคลิก
              // เรียกใช้ Navigator เพื่อเปลี่ยนหน้าไปยังหน้าอื่น
              Navigator.pushNamed(context,
                  '/accountscreen' // NextPage คือหน้าอื่นที่คุณต้องการไป
                  );
            },
            child: CircleAvatar(
              // radius: 40,
              backgroundImage: NetworkImage("${sp.imageUrl}"),
            ),
          ),
        ),
      ],
    );
  }
}
