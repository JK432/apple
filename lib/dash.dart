import 'package:flutter/material.dart';
import 'Functions/auth.dart';
import 'Functions/colors.dart';
import 'Models/UserModels.dart';
import 'Screens/applehomescreen.dart';
import 'Screens/student_homrpage.dart';
import 'Screens/teacher_homepage.dart';
import 'Widgets/Buttons.dart';
class Dash extends StatefulWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Palette.bgd,
        body: StreamBuilder<Uuser>(
          stream: Authentication().readUser(),
          builder: (context, snapshot) {
            return AppleHomeScreen();
          },
        )
    );
  }
}
