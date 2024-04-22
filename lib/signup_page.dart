import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sehatyuk/login_page.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/route.dart';
import 'package:sehatyuk/welcome.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with AppMixin{
  double boxHeight = 35.0;
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

  Widget form(String str, [String type="text"]){
    return Container(
      height: boxHeight,
      width: MediaQuery.of(context).size.width - 2*sideMargin,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.tertiary),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          cursorWidth: 1.0,
          keyboardType: type == "number" ? TextInputType.number : null,
          inputFormatters: type == "number" ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,] : null,
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.zero,
            isDense: true,
            hintText: str,
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
    );
  }

  Widget formWithIcon(String str, String path, String type){
    return GestureDetector(
      onTap: () {
        if (type == "date") {
          _selectDate();
        }
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
            cursorWidth: 1.0,
            readOnly: type == "date", // Set readOnly to true when type is "date"
            onTap: () {
              if (type == "date") {
                _selectDate();
              }
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
                  if (type == "date") {
                    _selectDate();
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

  DateTime? selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900, 1, 1),
      lastDate: DateTime.now(),
      locale: Locale('id', 'ID'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF4A707A),
              secondary: Color(0xFFC2C8C5),
              tertiary: Color(0xFF94B0B7),
              onPrimary: Color(0xFFDDDDDA), // body text color
              onSecondary: Color(0xFF37363B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
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
                SizedBox(height: 25),
                Text(
                  'Nama Lengkap *',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 7,),
                form('Masukkan nama lengkap'),
                SizedBox(height: 15,),
                Text(
                  'Tanggal Lahir *',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 7,),
                formWithIcon('Masukkan tanggal lahir', 'assets/images/authenticationPage/calendar.png', 'date'),
                SizedBox(height: 15,),
                Text(
                  'Nomor Telepon *',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 7,),
                form('Masukkan nomor telepon', 'number'),
                SizedBox(height: 15,),
                Text(
                  'Email *',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 7,),
                form('Masukkan email'),
                SizedBox(height: 15,),
                Text(
                  'Masukkan Password *',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 7,),
                formWithIcon('Masukkan password', 'assets/images/authenticationPage/eye_icon_unlocked.png', 'password'),
                SizedBox(height: 15,),
                Text(
                  'Konfirmasi Password *',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 7,),
                formWithIcon('Konfirmasi password', 'assets/images/authenticationPage/eye_icon_unlocked.png', 'password'),
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
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RoutePage()));
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