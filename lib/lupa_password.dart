import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/providers/user_provider.dart';
import 'package:sehatyuk/templates/form/form_date.dart';
import 'package:sehatyuk/templates/form/form_text.dart';
import 'package:sehatyuk/templates/form/form_with_icon.dart';

class LupaPasswordPage extends StatefulWidget {
  const LupaPasswordPage({super.key});

  @override
  State<LupaPasswordPage> createState() => LupaPasswordPageState();
}

class LupaPasswordPageState extends State<LupaPasswordPage> with AppMixin {
  double boxHeight = 40.0;

  void _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  bool _obscureTextNew = true;
  bool _obscureTextConfirm = true;
  bool _isAuthenticated = false;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  AuthService auth = AuthService();

  void _authenticate() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String result = await Provider.of<UserProvider>(context, listen: false)
          .forgetPassword(_emailController.text,
              _phoneController.text, _dobController.text, null);
      if (result == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('User ditemukan!')),
        );
        setState(() {
          _isAuthenticated = true;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$result')),
        );
      }
    }
  }

  void _setNewPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_confirmPasswordController.text == _newPasswordController.text) {
        String result = await Provider.of<UserProvider>(context, listen: false)
            .forgetPassword( _emailController.text,
                _phoneController.text, _dobController.text, null);
        if (result == "success") {
          String resultUpdate =
              await Provider.of<UserProvider>(context, listen: false)
                  .forgetPassword(
                      _emailController.text,
                      _phoneController.text,
                      _dobController.text,
                      _newPasswordController.text);
          if(resultUpdate == "success"){   
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Berhasil mengganti password!')),
            );
            Navigator.pop(context);
          }
          else{
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$resultUpdate')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$result')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Konfirmasi password tidak cocok!')),
          );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
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
                    _isAuthenticated ? 'Ganti Password' : "Selanjutnya",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: semi,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FormText(
                    inputLabel: "Nomor Telepon *",
                    hintText: "Masukkan nomor telepon",
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                    validator: phoneNumberValidator,
                  ),
                  FormText(
                    inputLabel: "Email *",
                    hintText: "Masukkan email",
                    controller: _emailController,
                    validator: emailValidator,
                  ),
                  FormDate(
                    inputLabel: "Tanggal Lahir *",
                    hintText: "Masukkan tanggal lahir",
                    controller: _dobController,
                    validator: notNullValidator,
                  ),
                  Visibility(
                      visible: _isAuthenticated,
                      child: Column(
                        children: [
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
                        ],
                      )),
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Container(
                      width: 150,
                      child: userProvider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : TextButton(
                              onPressed: _isAuthenticated
                                  ? _setNewPassword
                                  : _authenticate,
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
