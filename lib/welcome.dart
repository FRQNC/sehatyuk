import 'package:flutter/material.dart';
import 'package:sehatyuk/login_page.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/signup_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with AppMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Image(
              image: AssetImage('assets/images/authenticationPage/rs_wavy.png'),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight
            ),
            SizedBox(height: 50,),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: 'Halo!\n',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: bold,
                      fontFamily: 'Poppins',
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: 'Selamat datang di\n',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: semi,
                      fontFamily: 'Poppins',
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  TextSpan(
                    text: 'SEHATYUK!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: bold,
                      fontFamily: 'Poppins',
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              width: 150,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: semi,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Container(
              width: 150,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  'Daftar',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: semi,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Spacer(),
            Image(
              image: AssetImage('assets/images/authenticationPage/bottom_wave.png'),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitHeight
            ),
          ],
        ),
      ),
    );
  }
}