import 'package:flutter/material.dart';
import 'package:sehatyuk/login_page.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/welcome.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with AppMixin{
  double boxHeight = 35.0;
  bool? isChecked = false;

  void alterChecked(bool? newBool){
    setState(() {
      isChecked = newBool;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const WelcomePage()));
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: sideMargin, right: sideMargin, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Lengkapi Identitas Diri',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: semi,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Agar Anda dapat terhubung dengan semua fasilitas kesehatan yang pernah dikunjungi.',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 25),
              Text(
                'Nama Lengkap *',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 7,),
              Container(
                height: boxHeight,
                width: MediaQuery.of(context).size.width - 2*sideMargin,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Masukkan nama lengkap',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text(
                'Tanggal Lahir *',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 7,),
              Container(
                height: boxHeight,
                width: MediaQuery.of(context).size.width - 2*sideMargin,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Masukkan tanggal lahir',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/authenticationPage/calendar.png'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text(
                'Nomor Telepon *',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 7,),
              Container(
                height: boxHeight,
                width: MediaQuery.of(context).size.width - 2*sideMargin,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Masukkan nomor telepon',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text(
                'Email *',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 7,),
              Container(
                height: boxHeight,
                width: MediaQuery.of(context).size.width - 2*sideMargin,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Masukkan email',
                    style: TextStyle(
                      fontSize: 11,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text(
                'Masukkan Password *',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 7,),
              Container(
                height: boxHeight,
                width: MediaQuery.of(context).size.width - 2*sideMargin,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Masukkan password',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/authenticationPage/eye_icon_unlocked.png'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Text(
                'Konfirmasi Password *',
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 7,),
              Container(
                height: boxHeight,
                width: MediaQuery.of(context).size.width - 2*sideMargin,
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Konfirmasi password',
                          style: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                      Image(
                        image: AssetImage('assets/images/authenticationPage/eye_icon_unlocked.png'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  SizedBox(
                    // height: 10,
                    width: 20,
                    child: Checkbox(
                      value: isChecked,
                      activeColor: Theme.of(context).colorScheme.primary,
                      checkColor: Colors.white,
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      onChanged: (newBool) {
                        alterChecked(newBool);
                      },
                    ),
                  ),
                  SizedBox(width: 10,),
                  Flexible(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Dengan menyatakan Setuju, Anda menerima segala isi ',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                          TextSpan(
                            text: 'Syarat & Ketentuan ',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: bold,
                              fontFamily: 'Poppins',
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          TextSpan(
                            text: 'Penggunaan dan Pemberitahuan Privasi',
                            style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'Poppins',
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40,),
              Center(
                child: Container(
                  width: 150,
                  child: TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      'Daftar',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: semi,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sudah memiliki akun? ',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
                    },
                    child: Text(
                      'Masuk',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
