import 'package:admin_mosquito_project/appbarmain.dart';
import 'package:admin_mosquito_project/maindrawer.dart';
import 'package:flutter/material.dart';

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarMain(title: 'Geme'),
      drawer: MainDrawer(),
      body: SafeArea(
        child: ListView(
          children: [
            Center(child: Text('Game')),
          ],
        ),
      ),
    );
  }
}
