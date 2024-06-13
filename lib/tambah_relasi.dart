import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';
import 'package:sehatyuk/relasi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:sehatyuk/models/relasi.dart';
import 'package:sehatyuk/providers/relasi_provider.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/templates/form/form_text.dart';
import 'package:sehatyuk/templates/form/form_date.dart';
import 'package:sehatyuk/templates/form/form_dropdown.dart';

class TambahRelasiPage extends StatefulWidget {
  const TambahRelasiPage({super.key});

  @override
  State<TambahRelasiPage> createState() => _TambahRelasiPageState();
}

class _TambahRelasiPageState extends State<TambahRelasiPage> with AppMixin {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";

  RelasiProvider relasiProvider = RelasiProvider();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _namaLengkapController = TextEditingController();
  TextEditingController _noBPJSController = TextEditingController();
  TextEditingController _noTelpController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

  String _fotoRelasi = "";
  String _jenisKelamin = "Laki-laki";
  String _tipeRelasi = "Orang Tua";

  bool _isLoading = false;

  File? _selectedFile;

  Future<void> _fetchToken() async {
    _token = await auth.getToken();
    _user_id = await auth.getId();
    setState(() {});
  }

  Future<void> _addRelasiAndUploadImage() async {
  setState(() {
    _isLoading = true;
  });

  if (_formkey.currentState!.validate()) {
    _formkey.currentState!.save();

    // Create Relasi object
    Relasi relasi = Relasi(
      id_user: int.parse(_user_id),
      namaLengkap: _namaLengkapController.text,
      noBPJS: _noBPJSController.text,
      tanggalLahir: _dateController.text,
      gender: _jenisKelamin,
      noTelp: _noTelpController.text,
      alamat: _alamatController.text,
      photoUrl: p.basename(_fotoRelasi),
      tipe: _tipeRelasi,
    );

    // Add relasi
    final response = await relasiProvider.addRelasi(_token, relasi);
    if (response['statusCode'] == 200) {
      // Fetch the new relasi ID
      final int idRelasi = response['id_relasi'];

      // Upload the image if selected
      if (_selectedFile != null) {
        final uploadResponse = await relasiProvider.addRelasiImage(idRelasi, _selectedFile!);
        if (uploadResponse != "Success") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image')),
          );
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Successfully added relasi')),
      );
      Navigator.pop(context, true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add relasi')),
      );
    }
  }

  setState(() {
    _isLoading = false;
  });
}

  @override
  void initState() {
    super.initState();
    _fetchToken();
  }

  @override
  Widget build(BuildContext context) {
    var relasiProvider = Provider.of<RelasiProvider>(context, listen: false);
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
                        FormText(
                          validator: notNullValidator,
                          inputLabel: "Nama Lengkap *",
                          hintText: "Masukkan nama lengkap",
                          controller: _namaLengkapController,
                        ),
                        FormDropdown(
                          inputLabel: "Hubungan dengan relasi *",
                          value: _tipeRelasi,
                          dropDownItems: [
                            "Orang Tua",
                            "Pasangan",
                            "Saudara Kandung",
                            "Kakek/Nenek",
                            "Lainnya"
                          ],
                          onChanged: (String? newValue) {
                            setState(() {
                              _tipeRelasi = newValue!;
                            });
                          },
                        ),
                        FormText(
                          validator: notNullValidator,
                          inputLabel: "Nomor BPJS/Asuransi",
                          hintText: "Masukkan nomor BPJS/Asuransi",
                          controller: _noBPJSController,
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
                          validator: phoneNumberValidator,
                          inputLabel: "Nomor Telepon *",
                          hintText: "Masukkan nomor telepon",
                          keyboardType: TextInputType.phone,
                          controller: _noTelpController,
                        ),
                        FormText(
                          validator: notNullValidator,
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
                    child: _isLoading ? Center(child: CircularProgressIndicator()) : PrimaryButton(
                      buttonText: "Simpan",
                      containerWidth: 160,
                      fontSize: 18,
                      onPressed: () async {await _addRelasiAndUploadImage();},
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
                      await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['jpg', 'jpeg', 'png']
                      );
                  if (result != null) {
                    File file = File(result.files.single.path!);
                    setState(() {
                      _selectedFile = file;
                      _fotoRelasi = file.path;
                    });
                  } else {}
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
                      Center(
                        child: (_fotoRelasi.isEmpty) ? Icon(
                          Icons.person,
                          size: 60,
                          color: Color(0xFF4A707A),
                        ) : CircleAvatar(
                          backgroundImage: FileImage(File(_fotoRelasi)) as ImageProvider,
                          radius: 60,
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
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: DropdownButtonFormField<String>(
                value: value,
                onChanged: onChanged,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Colors.white,
                    filled: true),
                items:
                    dropDownItems.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 14),
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
