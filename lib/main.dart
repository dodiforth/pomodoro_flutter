import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  const MyApp();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(useMaterial3: true),
      home: DefaultTabController(
        animationDuration: Duration.zero,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Google Fonts Demo',
              style: GoogleFonts.getFont('Lato'),
            ),
            bottom: const TabBar(
              tabs: <Widget>[
                Tab(text: 'Simple'),
                Tab(text: 'Select a font'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/*
Pastel Red : Color(0xFFE7626C)
Warm yellow and white : Color(0xFF232B55)
Blue : Color(0xFFF4EDDB)
White : Color(0xFFFFFFFE)

icons : 

fonts :
Gilroy -> Questrial
Montserrat

Behance link : https://www.behance.net/gallery/98918603/POMO-UIKIT
POMO by Omar Sherif

pub.dev 
google_fonts 6.1.0 (https://pub.dev/packages/google_fonts) / import 'package:google_fonts/google_fonts.dart';
icon_forest 1.1.8 (https://pub.dev/packages/icon_forest) / import 'package:icon_forest/icon_forest.dart';

*/