import 'package:admin_mosquito_project/utils/colour.dart';
import 'package:flutter/material.dart';

class ListTileMenu extends StatelessWidget {
  final IconData icon;
  final String menuName;
  final String routeName;

  const ListTileMenu({
    super.key,
    required this.icon,
    required this.menuName,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 30,
        color: mintGreen,
      ),
      title: Text(
        menuName,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: greenPrimary,
            ),
      ),
      onTap: () {
        Navigator.pushNamed(context, routeName,);
      },
    );
  }
}

