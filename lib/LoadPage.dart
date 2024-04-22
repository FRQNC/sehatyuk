import 'package:flutter/material.dart';
import 'package:sehatyuk/login_page.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/signup_page.dart';

class LoadPage extends StatefulWidget {
  const LoadPage({super.key});

  @override
  State<LoadPage> createState() => _LoadPageState();
}

class _LoadPageState extends State<LoadPage> with AppMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Image(
                image:
                    AssetImage('assets/images/authenticationPage/rs_wavy.png'),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitHeight),
            SizedBox(
              height: 20,
            ),
            Container(
              width: 150,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/images/LoadPage/Logo.png', // Ganti dengan path gambar Anda
                    height: 80, // Sesuaikan tinggi gambar sesuai kebutuhan
                  ),
                  SizedBox(
                      height: 10), // Sesuaikan jarak antara gambar dan teks
                  Text('SEHATYUK!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4A707A),
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Image(
                image: AssetImage('assets/images/authenticationPage/bottom_wave.png'),
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitHeight),
          ],
        ),
      ),
    );
  }
}
