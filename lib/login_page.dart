import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sehatyuk/profile_page.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/route.dart';
import 'package:sehatyuk/signup_page.dart';
import 'package:sehatyuk/welcome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AppMixin{
  double sideMargin = 20;
  bool isPhone = true;
  bool _obscureText = true;

  void _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void alterPage(){
    setState(() {
      isPhone = !isPhone;
      print('$isPhone');
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _closeKeyboard();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
                  'Masuk Menggunakan Email atau Nomor Telepon',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: semi,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 40),
                Row(
                  children: [
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5 - sideMargin,
                        height: 35,
                        child: TextButton(
                          onPressed: () {
                            if(!isPhone){
                              alterPage();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              )
                            )
                          ),
                          child: Text(
                            'Nomor Telepon',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: semi,
                              color: isPhone ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5 - sideMargin,
                        height: 35,
                        child: TextButton(
                          onPressed: () {
                            if(isPhone){
                              alterPage();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              )
                            )
                          ),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: semi,
                              color: !isPhone ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 6,),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: isPhone ? 4.0 : 2.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(100.0),
                            bottomLeft: Radius.circular(100.0),
                          ),
                          color: isPhone ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: !isPhone ? 4.0 : 2.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(100.0),
                            bottomRight: Radius.circular(100.0),
                          ),
                          color: !isPhone ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15,),
                Text(
                  isPhone ? 'Nomor Telepon *' : 'Email *',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 7,),
                Visibility(
                  visible: isPhone,
                  child: Container(
                    height: 35.0,
                    width: MediaQuery.of(context).size.width - 2*sideMargin,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorWidth: 1.0,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Masukkan nomor telepon',
                          hintStyle: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      ), 
                    ),
                  ),
                ),
                Visibility(
                  visible: !isPhone,
                  child: Container(
                    height: 35.0,
                    width: MediaQuery.of(context).size.width - 2*sideMargin,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        cursorWidth: 1.0,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Masukkan email',
                          hintStyle: TextStyle(
                            fontSize: 11,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 11,
                        ),
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
                  height: 35.0,
                  width: MediaQuery.of(context).size.width - 2*sideMargin,
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                    child: TextFormField(
                      cursorWidth: 1.0,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: 'Masukkan Password',
                        hintStyle: TextStyle(
                          fontSize: 11,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Image(
                            image: AssetImage('assets/images/authenticationPage/eye_icon_unlocked.png'),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                Text(
                  'Lupa password?',
                  style: TextStyle(
                    fontSize: 10,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: bold,  
                  ),
                ),
                SizedBox(height: 40,),
                Center(
                  child: Container(
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RoutePage()));
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                      ),
                      child: Text(
                        'Masuk',
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
                      'Belum memiliki akun? ',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
                      },
                      child: Text(
                        'Daftar',
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
      ),
    );
  }
}
