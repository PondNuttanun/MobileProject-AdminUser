import 'package:admin_mosquito_project/utils/drawerheader.dart';
import 'package:admin_mosquito_project/utils/listtilemenu.dart';
import 'package:flutter/material.dart';


class MainDrawer extends StatelessWidget {
  const MainDrawer({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawHeader(),
          ListTileMenu(
            icon: Icons.home,
            menuName: 'Home',
            routeName: '/homescreen',
          ),
          ListTileMenu(
            icon: Icons.groups,
            menuName: 'Users',
            routeName: '/users',
          ),
          ListTileMenu(
            icon: Icons.library_books,
            menuName: 'Learning',
            routeName: '/learning',
          ),
          ListTileMenu(
            icon: Icons.view_in_ar,
            menuName: 'AR3D Model',
            routeName: '/ar3d',
          ),
          ListTileMenu(
            icon: Icons.person,
            menuName: 'Account',
            routeName: '/accountscreen',
          ),
        ],
      ),
    );
  }
}