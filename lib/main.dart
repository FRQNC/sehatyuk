import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sehatyuk/DetailDokter.dart';
import 'package:sehatyuk/LoadPage.dart';
import 'package:sehatyuk/ResumaMedis.dart';
import 'package:sehatyuk/cari_dokter.dart';
import 'package:sehatyuk/cariobat.dart';
import 'package:sehatyuk/daftarresume.dart';
import 'package:sehatyuk/detail_resume.dart';
import 'package:sehatyuk/pilih_obat_untuk_pengingat.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/jadwaltemu.dart';
import 'package:sehatyuk/informasiobat.dart';
import 'package:sehatyuk/relasi.dart';
import 'package:sehatyuk/welcome.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(MainApp()));
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
      home: const ResumeMedisPage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xFF4A707A),
          secondary: const Color(0xFFC2C8C5),
          tertiary: const Color(0xFF94B0B7),
          onPrimary: const Color(0xFF37363B),
          onSecondary: const Color(0xFFDDDDDA),
          primaryContainer: const Color(0x5ED9D9D9),
        ),
        fontFamily: 'Poppins',
        scaffoldBackgroundColor: Colors.white

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
                      letterSpacing: this.letterSpacing,
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
  FontWeight light = FontWeight.w300;
  Color boxColor = Color(0xFFD9D9D9).withOpacity(0.45);
  Color dividerColor = Color(0xFFD9D9D9);
  double sideMargin = 20;
}