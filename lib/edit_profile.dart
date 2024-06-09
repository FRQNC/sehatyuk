import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/profile_page.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:sehatyuk/models/users.dart';
import 'package:sehatyuk/providers/user_provider.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/templates/form/form_text.dart';
import 'package:sehatyuk/templates/form/form_date.dart';
import 'package:sehatyuk/templates/form/form_dropdown.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with AppMixin {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";

  UserProvider userProvider = UserProvider();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _namaLengkapController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _noBPJSController = TextEditingController();
  TextEditingController _noTelpController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

  String _fotoUser = "";
  String _jenisKelamin = "Laki-laki";

    Future<void> _fetchToken() async {
    // Fetch the token asynchronously
    _token = await auth.getToken();
    _user_id = await auth.getId();
    // Once token is fetched, trigger a rebuild of the widget tree
    setState(() {});
  }

  Future<void> _fetchData() async{
    await userProvider.fetchData();
    setState(() {
      _dateController.text = userProvider.userData.tanggalLahir;
      _namaLengkapController.text = userProvider.userData.namaLengkap;
      _emailController.text = userProvider.userData.email;
      _noBPJSController.text = userProvider.userData.noBPJS;
      _noTelpController.text = userProvider.userData.noTelp;
      _alamatController.text = userProvider.userData.alamat;
      _fotoUser = userProvider.userData.photoUrl;
      if(userProvider.userData.gender == 'L'){
        _jenisKelamin = "Laki-laki";
      }
      else if(userProvider.userData.gender == 'P'){
        _jenisKelamin = "Perempuan";
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchToken();
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Tambah Relasi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sideMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        formImageInputView(
                          inputLabel: "Foto *",
                        ),
                        FormText(inputLabel: "Email *",
                          hintText: "Masukkan email",
                          controller: _emailController,),
                        FormText(inputLabel: "Nama Lengkap *",
                          hintText: "Masukkan nama lengkap",
                          controller: _namaLengkapController,),
                        FormText(
                          inputLabel: "Nomor BPJS/Asuransi",
                          hintText: "Masukkan nomor BPJS/Asuransi",
                          controller: _noBPJSController,
                        ),
                        FormDate(
                          inputLabel: "Tanggal Lahir *",
                          hintText: "Masukkan tanggal lahir",
                          controller: _dateController,
                        ),
                        FormDropdown(
                          inputLabel: "Jenis Kelamin *",
                          value: _jenisKelamin,
                          dropDownItems: ["Laki-laki", "Perempuan"],
                          onChanged: (String? newValue) {
                            setState(() {
                              _jenisKelamin = newValue!;
                            });
                          },
                        ),
                        FormText(
                          inputLabel: "Nomor Telepon *",
                          hintText: "Masukkan nomor telepon",
                          keyboardType: TextInputType.phone,
                          controller: _noTelpController,
                        ),
                        FormText(
                          inputLabel: "Alamat *",
                          hintText: "Masukkan alamat",
                          controller: _alamatController,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Center(
                    child: PrimaryButton(
                      buttonText: "Simpan",
                      containerWidth: 160,
                      fontSize: 18,
                      onPressed: () async {
                        // Store the values in the corresponding variables
                        if (_formkey.currentState!.validate()) {
                          _formkey.currentState!.save();

                           Users userUpdate = Users(
                            id_user: _user_id,
                            email: _emailController.text,
                            namaLengkap: _namaLengkapController.text,
                            noBPJS: _noBPJSController.text,
                            tanggalLahir: _dateController.text,
                            gender: _jenisKelamin,
                            noTelp: _noTelpController.text,
                            alamat: _alamatController.text,
                            photoUrl: _fotoUser,
                          );

                          String? response = await userProvider.updateUserProfile(userUpdate);

                          if(response == "success"){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Berhasil memperbarui data')
                                ),
                              );
                            }
                            else if(response == "credential_error"){
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Email atau No. Telp sudah digunakan')
                                  ),
                                );
                            }
                            else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Gagal memperbarui data')
                                  ),
                                );
                            }
                          }
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding formImageInputView({
    required String inputLabel,
    double labelFontSize = 14,
    double labelLetterSpacing = 1.5,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Teks dan container gambar di kiri
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inputLabel,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: labelFontSize,
                  letterSpacing: labelLetterSpacing,
                ),
              ),
              SizedBox(height: 10), // Spacer
              GestureDetector(
                onTap: () async {
                  // Tambahkan Function
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    File file = File(result.files.single.path!);
                    _fotoUser = p.basename(file.path);
                  } else {
                    // User canceled the picker
                  }
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5), // Placeholder color
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFF4A707A),
                        ),
                      ),
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF4A707A),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Padding formDropdownInputView({
    required String inputLabel,
    required String value,
    required List<String> dropDownItems,
    required void Function(String?) onChanged,
    double labelFontSize = 14,
    double labelLetterSpacing = 1.5,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputLabel,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: labelFontSize,
              letterSpacing: labelLetterSpacing,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: DropdownButtonFormField<String>(
                value: value,
                onChanged: onChanged,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true
                ),
                items: dropDownItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 14
                      ),
                      ),
                  );
                }).toList(),
                dropdownColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

