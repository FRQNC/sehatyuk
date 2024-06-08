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
import 'package:sehatyuk/templates/form/form_date.dart';
import 'package:sehatyuk/templates/form/form_dropdown.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with AppMixin{
  double boxHeight = 40.0;
  bool? isChecked = false;
  bool _obscureText = true;

  void _closeKeyboard() {
    FocusScopeNode currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void alterChecked(bool? newBool){
    setState(() {
      isChecked = newBool;
    });
  }

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _genderController = TextEditingController(text: "Laki-laki");
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  Widget formWithIcon(String str, String path, String type, TextEditingController? controller){
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        height: 35.0,
        width: MediaQuery.of(context).size.width - 2*sideMargin,
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.tertiary),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 8.0),
          child: TextFormField(
            controller: controller,
            cursorWidth: 1.0,
            readOnly: type == "date", // Set readOnly to true when type is "date"
            onTap: () {
            },
            obscureText: type == "password" ? _obscureText : false,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
              hintText: str,
              hintStyle: TextStyle(
                fontSize: 11,
                color: Theme.of(context).colorScheme.secondary,
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  if(type == "password"){
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  }
                },
                child: Image(
                  image: AssetImage(path),
                ),
              ),
            ),
            style: TextStyle(
              fontSize: 11,
            ),
          ),
        ),
      ),
    );
  }

  AuthService auth = AuthService();

  Future<String> _register() async {
    String name = _nameController.text;
    String dob = _dobController.text;
    String phone = _phoneController.text;
    String gender = _genderController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if(password == confirmPassword){
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
    }else{
      return "konfirmasi ulang";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() {
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
                 FormText(inputLabel: "Nama Lengkap *",
                          hintText: "Masukkan nama lengkap",
                          controller: _nameController,
                          ),
                FormDate(
                          inputLabel: "Tanggal Lahir *",
                          hintText: "Masukkan tanggal lahir",
                          controller: _dobController,
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
                        ),
                FormText(
                          inputLabel: "Email *",
                          hintText: "Masukkan email",
                          controller: _emailController,
                        ),
                Text(
                  'Masukkan Password *',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 7,),
                formWithIcon('Masukkan password', 'assets/images/authenticationPage/eye_icon_unlocked.png', 'password', _passwordController),
                SizedBox(height: 15,),
                Text(
                  'Konfirmasi Password *',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 7,),
                formWithIcon('Konfirmasi password', 'assets/images/authenticationPage/eye_icon_unlocked.png', 'password', _confirmPasswordController),
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
                      onPressed: () async {
                        String isSucceed = await _register();
                        if(isSucceed == "sukses"){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registrasi Sukses!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                          // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RoutePage()));
                        } 
                        else if(isSucceed == "konfirmasi ulang"){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Konfirmasi Ulang Password!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                        else if(isSucceed == "credential_error"){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Email/No Telp Sudah Digunakan Akun Lain!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Registrasi Gagal!'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
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
      ),
    );
  }
}