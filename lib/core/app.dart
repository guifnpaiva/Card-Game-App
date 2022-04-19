import 'package:card_game/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

void main() async {
  runApp(const AppWidget());
}

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context, orientation, deviceType){
          return const MaterialApp(
            title: "Card Game",
            debugShowCheckedModeBanner: false,
            home: Home(),
          );
        }
    );
  }
}