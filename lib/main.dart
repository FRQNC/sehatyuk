import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/LoadPage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/providers/doctor_provider.dart';
import 'package:sehatyuk/providers/jadwal_dokter_provider.dart';
import 'package:sehatyuk/providers/janji_temu_as_orang_lain_provider.dart';
import 'package:sehatyuk/providers/obat_provider.dart';
import 'package:sehatyuk/providers/route_provider.dart';
import 'package:sehatyuk/providers/user_provider.dart';
import 'package:sehatyuk/providers/relasi_provider.dart';
import 'package:sehatyuk/providers/janji_temu_provider.dart';
import 'package:sehatyuk/providers/pengingat_minum_obat_provider.dart';
import 'package:sehatyuk/providers/rekam_medis_provider.dart';
import 'package:sehatyuk/route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sehatyuk/auth/auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp
  ]).then((value) => runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => UserProvider()),
            ChangeNotifierProvider(create: (context) => RelasiProvider()),
            ChangeNotifierProvider(create: (context) => DoctorProvider()),
            ChangeNotifierProvider(create: (context) => ObatProvider()),
            ChangeNotifierProvider(create: (context) => JadwalDokterProvider()),
            ChangeNotifierProvider(create: (context) => JanjiTemuProvider()),
            ChangeNotifierProvider(
                create: (context) => PengingatMinumObatProvider()),
            ChangeNotifierProvider(
                create: (context) => JanjiTemuAsOrangLainProvider()),
            ChangeNotifierProvider(create: (context) => RekamMedisProvider()),
            ChangeNotifierProvider(create: (context) => RouteProvider()),
          ],
          child: const MainApp(),
        ),
      ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<Map<String, dynamic>> _checkAuth() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    bool openedFirstTime = prefs.getBool('openedFirstTime') ?? true;
    return {'token': token, 'openedFirstTime': openedFirstTime};
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FutureBuilder<Map<String, dynamic>>(
        future: _checkAuth(),
        builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasData) {
            String? token = snapshot.data!['token'];
            if (token != null && token.isNotEmpty) {
              return RoutePage();
            } else {
              return LoadPage();
            }
          } else {
            return LoadPage();
          }
        },
      ),
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
        scaffoldBackgroundColor: Colors.white,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('id', 'ID'),
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

  BulletList(this.strings, this.fontSize, this.fontWeight, this.color,
      this.letterSpacing);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
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

mixin AppMixin {
  FontWeight bold = FontWeight.w700;
  FontWeight semi = FontWeight.w600;
  FontWeight medium = FontWeight.w500;
  FontWeight light = FontWeight.w500;
  Color boxColor = Color(0xFFD9D9D9).withOpacity(0.45);
  Color dividerColor = Color(0xFFD9D9D9);
  double sideMargin = 20;

  String? notNullValidator(value) {
    if (value == null || value.isEmpty) {
      return 'Field tidak boleh kosong';
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }

    final RegExp emailRegExp = RegExp(
      r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Format email tidak valid';
    }

    return null;
  }

  String? phoneNumberValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    final RegExp phoneRegExp = RegExp(
      r'^\d{10,15}$',
    );

    if (!phoneRegExp.hasMatch(value)) {
      return 'Format nomor telepon tidak valid';
    }

    return null;
  }
}
