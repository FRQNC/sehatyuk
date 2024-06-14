import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/lupa_password.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/models/users.dart';
import 'package:sehatyuk/providers/user_provider.dart';
import 'package:sehatyuk/route.dart';
import 'package:sehatyuk/signup_page.dart';
import 'package:sehatyuk/welcome.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with AppMixin {
  double sideMargin = 20;
  bool isPhone = true;
  bool _obscureText = true;
  bool _isLoading = false;

  void _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void alterPage() {
    setState(() {
      isPhone = !isPhone;
      print('$isPhone');
    });
  }

  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _auth = AuthService();

  Future<String> _loginEmail() async {
    String identifier = _identifierController.text;
    String password = _passwordController.text;
    print(identifier);

    String isSucceed = await _auth.loginEmail(context, identifier, password);

    return isSucceed;
  }

  Future<String> _loginPhone() async {
    String identifier = _identifierController.text;
    String password = _passwordController.text;

    String isSucceed = await _auth.loginPhone(context, identifier, password);

    return isSucceed;
  }

  @override
  Widget build(BuildContext context) {
     var userProvider = Provider.of<UserProvider>(context, listen: false);
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
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const WelcomePage()));
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: sideMargin, right: sideMargin, top: 8),
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
                        width: MediaQuery.of(context).size.width * 0.5 -
                            sideMargin,
                        height: 35,
                        child: TextButton(
                          onPressed: () {
                            if (!isPhone) {
                              alterPage();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ))),
                          child: Text(
                            'Nomor Telepon',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: semi,
                              color: isPhone
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5 -
                            sideMargin,
                        height: 35,
                        child: TextButton(
                          onPressed: () {
                            if (isPhone) {
                              alterPage();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ))),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: semi,
                              color: !isPhone
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).colorScheme.secondary,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                          color: isPhone
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
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
                          color: !isPhone
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  isPhone ? 'Nomor Telepon *' : 'Email *',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Visibility(
                  visible: isPhone,
                  child: Container(
                    height: 35.0,
                    width: MediaQuery.of(context).size.width - 2 * sideMargin,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _identifierController,
                        cursorWidth: 1.0,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Masukkan nomor telepon',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: !isPhone,
                  child: Container(
                    height: 35.0,
                    width: MediaQuery.of(context).size.width - 2 * sideMargin,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Theme.of(context).colorScheme.tertiary),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _identifierController,
                        cursorWidth: 1.0,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: 'Masukkan email',
                          hintStyle: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Masukkan Password *',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: 7,
                ),
                Container(
                  height: 35.0,
                  width: MediaQuery.of(context).size.width - 2 * sideMargin,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Theme.of(context).colorScheme.tertiary),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
                    child: TextFormField(
                      controller: _passwordController,
                      cursorWidth: 1.0,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        isDense: true,
                        hintText: 'Masukkan Password',
                        hintStyle: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          child: Image(
                            image: AssetImage(
                                'assets/images/authenticationPage/eye_icon_unlocked.png'),
                          ),
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                TextButton(
                  onPressed: (){
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LupaPasswordPage()));
                  },
                  child: Text(
                    'Lupa password?',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    width: 150,
                    child: _isLoading ? Center(child: CircularProgressIndicator()) : TextButton(
                      onPressed: () async {
                        setState(() {
                          _isLoading = true;
                        });
                        String isSucceed;
                        if (isPhone)
                          isSucceed = await _loginPhone();
                        else
                          isSucceed = await _loginEmail();

                        if (isSucceed == "sukses") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login Sukses!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else if (isSucceed == "credential_error") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email/No Telp/Password Salah!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Login Gagal!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                        setState(() {
                          _isLoading = false;
                        });
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
                SizedBox(
                  height: 3,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Belum memiliki akun? ',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpPage()));
                      },
                      child: Text(
                        'Daftar',
                        style: TextStyle(
                          fontSize: 16,
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
