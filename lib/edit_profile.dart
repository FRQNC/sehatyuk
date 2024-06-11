import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/models/users.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/providers/user_provider.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';
import 'package:sehatyuk/templates/form/form_date.dart';
import 'package:sehatyuk/templates/form/form_dropdown.dart';
import 'package:sehatyuk/templates/form/form_text.dart';
import 'package:sehatyuk/main.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> with AppMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  AuthService auth = AuthService();
  UserProvider userProvider = UserProvider();

  String _token = "";
  String _userId = "";
  String _fotoUserNew = "";
  String _jenisKelamin = "Laki-laki";

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _namaLengkapController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _noBPJSController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchToken();
    await _fetchData();
  }

  Future<void> _fetchToken() async {
    _token = await auth.getToken();
    _userId = await auth.getId();
    setState(() {});
  }

  Future<void> _fetchData() async {
    await userProvider.fetchData();
    setState(() {
      _dateController.text = userProvider.userData.tanggalLahir;
      _namaLengkapController.text = userProvider.userData.namaLengkap;
      _emailController.text = userProvider.userData.email;
      _noBPJSController.text = userProvider.userData.noBPJS;
      _noTelpController.text = userProvider.userData.noTelp;
      _alamatController.text = userProvider.userData.alamat;
      _userId = userProvider.userData.id_user;
      _jenisKelamin =
          userProvider.userData.gender == 'L' ? "Laki-laki" : "Perempuan";
    });
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
          'Edit Profil',
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
                    key: _formKey,
                    child: Column(
                      children: [
                        formImageInputView(inputLabel: "Foto *"),
                        FormText(
                          inputLabel: "Email *",
                          hintText: "Masukkan email",
                          controller: _emailController,
                          validator: emailValidator,
                        ),
                        FormText(
                          inputLabel: "Nama Lengkap *",
                          hintText: "Masukkan nama lengkap",
                          controller: _namaLengkapController,
                          validator: notNullValidator,
                        ),
                        FormText(
                          inputLabel: "Nomor BPJS/Asuransi",
                          hintText: "Masukkan nomor BPJS/Asuransi",
                          controller: _noBPJSController,
                          validator: notNullValidator,
                        ),
                        FormDate(
                          inputLabel: "Tanggal Lahir *",
                          hintText: "Masukkan tanggal lahir",
                          controller: _dateController,
                          validator: notNullValidator,
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
                          validator: phoneNumberValidator,
                        ),
                        FormText(
                          inputLabel: "Alamat *",
                          hintText: "Masukkan alamat",
                          controller: _alamatController,
                          validator: notNullValidator,
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
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          Users userUpdate = Users(
                            id_user: _userId,
                            email: _emailController.text,
                            namaLengkap: _namaLengkapController.text,
                            noBPJS: _noBPJSController.text,
                            tanggalLahir: _dateController.text,
                            gender: _jenisKelamin,
                            noTelp: _noTelpController.text,
                            alamat: _alamatController.text,
                            photoUrl: p.basename(_fotoUserNew),
                          );

                          String? response =
                              await userProvider.updateUserProfile(userUpdate);

                          if (response == "success") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Berhasil memperbarui data')),
                            );
                          } else if (response == "credential_error") {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      'Email atau No. Telp sudah digunakan')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Gagal memperbarui data')),
                            );
                          }

                          Navigator.pop(context, true);
                        }
                      },
                    ),
                  ),
                ),
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
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();
                  if (result != null) {
                    File file = File(result.files.single.path!);
                    setState(() {
                      _fotoUserNew = file.path;
                    });
                  }
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_userId.isNotEmpty)
                        CircleAvatar(
                          backgroundImage: _fotoUserNew.isEmpty
                              ? CachedNetworkImageProvider(
                                  '${Endpoint.url}user_image/$_userId',
                                  headers: <String, String>{
                                    'accept': 'application/json',
                                    'Authorization': 'Bearer $_token',
                                  },
                                )
                              : FileImage(File(_fotoUserNew)) as ImageProvider,
                          radius: 60,
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
                              Icons.camera_alt_outlined,
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
}
