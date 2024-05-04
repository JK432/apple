import 'package:applezero/Functions/auth.dart';
import 'package:applezero/Functions/crud.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Functions/colors.dart';
import '../Models/Apple.dart';
import 'dart:math';
class AppleHomeScreen extends StatefulWidget {
  const AppleHomeScreen({super.key});

  @override
  State<AppleHomeScreen> createState() => _AppleHomeScreenState();
}

class _AppleHomeScreenState extends State<AppleHomeScreen> {
  @override
  List<String> apple = ['Blotch_Apple','Normal_Apple','Rot_Apple','Scab_Apple'];
  Widget build(BuildContext context) {
    Random random = Random();
    int randomIndex = random.nextInt(apple.length);
    String randomItem = apple[randomIndex];
    return Scaffold(
      backgroundColor: Palette.bgl,
      appBar: AppBar(
          backgroundColor: Palette.main,
          title: IconButton(
              onPressed: () {
                Authentication().signOut(context);
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Palette.textd,
              )),
      actions: [
        IconButton(
            onPressed: () {
              Crud().Delete('1254', context);
            },
            icon: Icon(
              Icons.delete,
              color: Palette.textd,
            ))
      ],),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: StreamBuilder<List<Apple>>(
            stream: Crud().readApple(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final course = snapshot.data;
                if (course == null || course.isEmpty) {
                  return Container(
                    child: Center(
                      child: Text(
                        "Sorry! No docs till now.",
                        style: GoogleFonts.signikaNegative(
                          fontSize: 30.0,
                          color: Palette.textd,
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Text(
                          "Type : ${randomItem}",
                          style: GoogleFonts.signikaNegative(
                            fontSize: 28,
                            color: Palette.textd,
                            height: 0.99,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Temperature :${course.first.Temperature}",
                          style: GoogleFonts.signikaNegative(
                            fontSize: 28,
                            color: Palette.textd,
                            height: 0.99,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Humidity : ${course.first.Humidity}",
                          style: GoogleFonts.signikaNegative(
                            fontSize: 28,
                            color: Palette.textd,
                            height: 0.99,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Palette.main,  // Specify border color here
                              width: 2.0,          // Specify border width here
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Safe Storage Needs 0°C - 10°C and 70% to 90% ",
                              style: GoogleFonts.signikaNegative(
                                fontSize: 21,
                                color: Palette.textd,
                                height: 0.99,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GridView.count(
                          crossAxisCount: 2,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: course.first.photolink.reversed
                              .map((photoLink) => buildGridItem(photoLink))
                              .toList(),
                        ),
                      ],
                    ),
                  );
                }
              }

              if (snapshot.hasError) {
                print(snapshot.error);
                print(snapshot.stackTrace);
                return Center(
                  child: CircularProgressIndicator(color: Palette.alert),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(color: Palette.main),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildGridItem(String link) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: 300,
        decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(link), fit: BoxFit.fill),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
