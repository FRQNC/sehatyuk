import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehatyuk/DetailDokter.dart';
import 'package:sehatyuk/ProfilePage.dart';
import 'package:sehatyuk/welcome.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const DetailDokterPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Color(0xFF4A707A),
          secondary: Color(0xFFC2C8C5),
          tertiary: Color(0xFF94B0B7),
          onPrimary: Color(0xFF37363B),
          onSecondary: Color(0xFFDDDDDA),
        ),
        fontFamily: 'Poppins'
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', ''),
        Locale('id', 'ID'), // arabic, no country code
      ],
    );
  }
}

class BulletList extends StatelessWidget {
  final List<String> strings;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double letterSpacing;

  BulletList(this.strings, this.fontSize, this.fontWeight, this.color, this.letterSpacing);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      // padding: EdgeInsets.fromLTRB(0, 15, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: strings.map((str) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '\u2022',
                style: TextStyle(
                  fontSize: this.fontSize,
                  fontWeight: this.fontWeight,
                  color: this.color,
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    str,
                    textAlign: TextAlign.left,
                    softWrap: true,
                    style: TextStyle(
                      fontSize: this.fontSize,
                      fontWeight: this.fontWeight,
                      color: this.color,
                    ),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

mixin AppMixin{
  FontWeight bold = FontWeight.w700;
  FontWeight semi = FontWeight.w600;
  FontWeight medium = FontWeight.w500;
  Color boxColor = Color(0xFFD9D9D9).withOpacity(0.45);
  Color dividerColor = Color(0xFFD9D9D9);
  double sideMargin = 20;
}