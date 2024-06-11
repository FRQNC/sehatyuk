import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/login_page.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/models/users.dart';
import 'package:sehatyuk/providers/user_provider.dart';
import 'package:sehatyuk/route.dart';
import 'package:sehatyuk/welcome.dart';
import 'package:sehatyuk/templates/form/form_with_icon.dart';

class GantiPasswordPage extends StatefulWidget {
  const GantiPasswordPage({super.key});

  @override
  State<GantiPasswordPage> createState() => _GantiPasswordPageState();
}

class _GantiPasswordPageState extends State<GantiPasswordPage> with AppMixin {
  double boxHeight = 40.0;
  bool _obscureText = true;
  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;

  void _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  AuthService auth = AuthService();

  Future<String> _updatePassword() async {
    String oldPassword = _oldPasswordController.text;
    String newPassword = _newPasswordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (newPassword == confirmPassword) {
      String result = await Provider.of<UserProvider>(context, listen: false)
          .updateUserPassword(oldPassword, newPassword);
      return result;
    } else {
      return "new_password_mismatch";
    }
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
              Navigator.pop(context);
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
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ganti Password',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: semi,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormWithIcon(
                    inputLabel: 'Masukkan Password Lama *',
                    icon: Icons.remove_red_eye,
                    controller: _oldPasswordController,
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    obscureText: _obscureText,
                  ),
                  FormWithIcon(
                    inputLabel: 'Masukkan Password Baru *',
                    icon: Icons.remove_red_eye,
                    controller: _newPasswordController,
                    onPressed: () {
                      setState(() {
                        _obscureTextNew = !_obscureTextNew;
                      });
                    },
                    obscureText: _obscureTextNew,
                  ),
                  FormWithIcon(
                    inputLabel: 'Konfirmasi Password Baru *',
                    icon: Icons.remove_red_eye,
                    controller: _confirmPasswordController,
                    onPressed: () {
                      setState(() {
                        _obscureTextConfirm = !_obscureTextConfirm;
                      });
                    },
                    obscureText: _obscureTextConfirm,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      width: 150,
                      child: TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            if (_newPasswordController.text ==
                                _confirmPasswordController.text) {
                              String result = await Provider.of<UserProvider>(
                                      context,
                                      listen: false)
                                  .updateUserPassword(
                                      _oldPasswordController.text,
                                      _newPasswordController.text);
                              if (result == "success") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Berhasil mengganti password!')),
                                );
                                Navigator.pop(context);
                              } else if (result == "wrong_password") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Password lama salah!')),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Gagal mengganti password')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Konfirmasi password tidak cocok')),
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          'Ganti Password',
                          style: TextStyle(
                            fontSize: 14,
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
