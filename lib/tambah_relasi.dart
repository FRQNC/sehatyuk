import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/primary_button.dart';
import 'package:sehatyuk/relasi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:sehatyuk/models/relasi.dart';
import 'package:sehatyuk/providers/relasi_provider.dart';
import 'package:sehatyuk/auth/auth.dart';

class TambahRelasiPage extends StatefulWidget {
  const TambahRelasiPage({super.key});

  @override
  State<TambahRelasiPage> createState() => _TambahRelasiPageState();
}

class _TambahRelasiPageState extends State<TambahRelasiPage> with AppMixin {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1924),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

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

    Future<void> _fetchToken() async {
    // Fetch the token asynchronously
    _token = await auth.getToken();
    _user_id = await auth.getId();
    // Once token is fetched, trigger a rebuild of the widget tree
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fetchToken();
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
                        formTextInputView(
                          inputLabel: "Nama Lengkap *",
                          hintText: "Masukkan nama lengkap",
                          controller: _namaLengkapController,
                        ),
                        formDropdownInputView(
                          inputLabel: "Hubungan dengan relasi *",
                          value: _tipeRelasi,
                          dropDownItems: ["Orang Tua", "Pasangan", "Saudara Kandung", "Kakek/Nenek", "Lainnya"],
                          onChanged: (String? newValue) {
                            setState(() {
                              _tipeRelasi = newValue!;
                            });
                          },
                        ),
                        formTextInputView(
                          inputLabel: "Nomor BPJS/Asuransi",
                          hintText: "Masukkan nomor BPJS/Asuransi",
                          controller: _noBPJSController,
                        ),
                        formDateInputView(
                          inputLabel: "Tanggal Lahir *",
                          hintText: "Masukkan tanggal lahir",
                          readOnly: true,
                          controller: _dateController,
                        ),
                        formDropdownInputView(
                          inputLabel: "Jenis Kelamin *",
                          value: _jenisKelamin,
                          dropDownItems: ["Laki-laki", "Perempuan"],
                          onChanged: (String? newValue) {
                            setState(() {
                              _jenisKelamin = newValue!;
                            });
                          },
                        ),
                        formTextInputView(
                          inputLabel: "Nomor Telepon *",
                          hintText: "Masukkan nomor telepon",
                          keyboardType: TextInputType.phone,
                          controller: _noTelpController,
                        ),
                        formTextInputView(
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

                          Relasi relasi = Relasi(
                            id_user: int.parse(_user_id),
                            namaLengkap: _namaLengkapController.text,
                            noBPJS: _noBPJSController.text,
                            tanggalLahir: _dateController.text,
                            gender: _jenisKelamin,
                            noTelp: _noTelpController.text,
                            alamat: _alamatController.text,
                            photoUrl: _fotoRelasi,
                            tipe: _tipeRelasi
                          );

                          int? response = await relasiProvider.addRelasi(_token, relasi);

                          if(response == 200){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Berhasil menambah relasi')
                                ),
                              );
                            }
                          }
                          else{
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Gagal menambah relasi')
                                ),
                              );
                          }


                        // Navigate to the RelasiPage
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const RelasiPage(),
                        //   ),
                        // );
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

  Padding formTextInputView({
    required String inputLabel,
    double labelFontSize = 14,
    double labelLetterSpacing = 1.5,
    bool readOnly = false,
    String hintText = "",
    double hintTextSize = 12,
    TextInputType keyboardType = TextInputType.text,
    TextEditingController? controller,
    String? Function(String?)? validator,
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
              height: 40,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: TextFormField(
                readOnly: readOnly,
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: hintTextSize,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                validator: validator,
              ),
            ),
          ),
        ],
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
                    _fotoRelasi = p.basename(file.path);
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

  Padding formDateInputView({
    required String inputLabel,
    double labelFontSize = 14,
    double labelLetterSpacing = 1.5,
    bool readOnly = false,
    String hintText = "",
    double hintTextSize = 12,
    TextEditingController? controller,
    String? Function(String?)? validator,
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
              height: 40,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: TextFormField(
                readOnly: readOnly,
                onTap: () => _selectDate(context),
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: hintTextSize,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.calendar_month_outlined,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: validator,
              ),
            ),
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

