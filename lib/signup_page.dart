import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/login_page.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/models/users.dart';
import 'package:sehatyuk/providers/user_provider.dart';
import 'package:sehatyuk/route.dart';
import 'package:sehatyuk/welcome.dart';
import 'package:sehatyuk/templates/form/form_text.dart';
import 'package:sehatyuk/templates/form/form_with_icon.dart';
import 'package:sehatyuk/templates/form/form_date.dart';
import 'package:sehatyuk/templates/form/form_dropdown.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with AppMixin {
  double boxHeight = 40.0;
  bool? isChecked = false;
  bool _obscureText = true;
  bool _obscureTextConfirm = true;

  void _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void alterChecked(bool? newBool) {
    setState(() {
      isChecked = newBool;
    });
  }

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController =
      TextEditingController(text: "Laki-laki");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  AuthService auth = AuthService();

  Future<String> _register() async {
    String name = _nameController.text;
    String dob = _dobController.text;
    String phone = _phoneController.text;
    String gender = _genderController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (password == confirmPassword) {
      Users user = Users(
        namaLengkap: name,
        tanggalLahir: dob,
        noTelp: phone,
        gender: gender,
        email: email,
        password: password,
        photoUrl: "default.jpg",
        alamat: "",
        noBPJS: "",
      );

      print(user);

      String result = await auth.register(context, user);

      return result;
    } else {
      return "konfirmasi ulang";
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
            child: Form(
              key: _formKey,
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
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Agar Anda dapat terhubung dengan semua fasilitas kesehatan yang pernah dikunjungi.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                  FormText(
                    inputLabel: "Nama Lengkap *",
                    hintText: "Masukkan nama lengkap",
                    controller: _nameController,
                    validator: notNullValidator,
                  ),
                  FormDate(
                    inputLabel: "Tanggal Lahir *",
                    hintText: "Masukkan tanggal lahir",
                    controller: _dobController,
                    validator: notNullValidator,
                  ),
                  FormDropdown(
                    inputLabel: "Jenis Kelamin *",
                    value: _genderController.text,
                    dropDownItems: ["Laki-laki", "Perempuan"],
                    onChanged: (String? newValue) {
                      setState(() {
                        _genderController.text = newValue!;
                      });
                    },
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
                  FormWithIcon(
                    inputLabel: 'Masukkan Password *',
                    icon: Icons.remove_red_eye,
                    controller: _passwordController,
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                      
                    },
                    obscureText: _obscureText,
                  ),
                  FormWithIcon(
                    inputLabel: 'Konfirmasi Password *',
                    icon: Icons.remove_red_eye,
                    controller: _confirmPasswordController,
                    onPressed: () {
                      setState(() {
                        _obscureTextConfirm = !_obscureTextConfirm;
                      });
                    },
                    obscureText: _obscureTextConfirm,
                  ),
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
                      SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Dengan menyatakan Setuju, Anda menerima segala isi ',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontFamily: 'Poppins',
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
                            String isSucceed = await _register();
                            if (isSucceed == "sukses") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Registrasi Sukses!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RoutePage()));
                            } else if (isSucceed == "konfirmasi ulang") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Konfirmasi Ulang Password!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else if (isSucceed == "credential_error") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Email/No Telp Sudah Digunakan Akun Lain!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Registrasi Gagal!'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
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
                  SizedBox(
                    height: 3,
                  ),
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
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
                  SizedBox(height: 15,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
