import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/jadwaltemu.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/models/doctor.dart';
import 'package:sehatyuk/models/janji_temu.dart';
import 'package:sehatyuk/models/janji_temu_as_orang_lain.dart';
import 'package:sehatyuk/providers/janji_temu_as_orang_lain_provider.dart';
import 'package:sehatyuk/providers/janji_temu_provider.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';
import 'package:sehatyuk/templates/form/form_dropdown.dart';
import 'package:sehatyuk/templates/form/form_text.dart';
import 'package:sehatyuk/templates/form/form_date.dart';

class BuatJanjiOtherPage extends StatefulWidget {
  final Doctor doctor;
  final DateTime? selectedDate;

  const BuatJanjiOtherPage(
      {Key? key, required this.doctor, required this.selectedDate})
      : super(key: key);

  @override
  State<BuatJanjiOtherPage> createState() => _BuatJanjiOtherPageState();
}

class _BuatJanjiOtherPageState extends State<BuatJanjiOtherPage> with AppMixin {
  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";
  String poli = "";
  String nama_dokter = "";
  TextEditingController _poliController = TextEditingController();
  TextEditingController _namaDokterController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchToken();
    poli = widget.doctor.poli['nama_poli'];
    nama_dokter = widget.doctor.namaLengkap;
    _poliController = TextEditingController(text: poli);
    _namaDokterController = TextEditingController(text: nama_dokter);
  }

  Future<void> _fetchToken() async {
    // Fetch the token asynchronously
    _token = await auth.getToken();
    _user_id = await auth.getId();
    // Once token is fetched, trigger a rebuild of the widget tree
    setState(() {});
  }

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

  // TextEditingController _poliController = TextEditingController(text: poli);
  // TextEditingController _namaDokterController = TextEditingController(text: "Nama Dokter");
  TextEditingController _dateController = TextEditingController();
  TextEditingController _namaLengkapController = TextEditingController();
  TextEditingController _genderController =
      TextEditingController(text: "Laki-laki");
  TextEditingController _noBPJSController = TextEditingController();
  TextEditingController _noTelpController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

  JanjiTemuProvider janji = JanjiTemuProvider();
  JanjiTemuAsOrangLainProvider janjiOrangLain = JanjiTemuAsOrangLainProvider();
  Random _random = Random();

  Future<bool> createJanjiTemu(BuildContext context) async {
    JanjiTemuAsOrangLain newOrangLain = JanjiTemuAsOrangLain(
        namaOrangLain: _namaLengkapController.text,
        noBPJS: _noBPJSController.text,
        tglLahir: _dateController.text,
        gender: _genderController.text,
        noTelp: _noTelpController.text,
        alamat: _alamatController.text,
        id_user: int.parse(_user_id));

    dynamic result =
        await janjiOrangLain.createJanjiTemuAsOrangLain(_token, newOrangLain);

    if (result != false) {
      String tgl = widget.selectedDate.toString();
      int id_dokter = widget.doctor.id;
      int id_user = int.parse(_user_id);
      int is_relasi = 0;
      int id_relasi = 0;
      int biaya = widget.doctor.harga;
      String kode = "SYS" + (_random.nextInt(1000000) + 100000).toString();
      print("ULULULULULULUUL ");
      print(result['id_janji_temu_as_orang_lain']);

      JanjiTemu newJanji = JanjiTemu(
        kodeJanjiTemu: kode,
        tanggalJanjiTemu: tgl,
        idDokter: id_dokter,
        idUser: id_user,
        isRelasi: is_relasi,
        idRelasi: id_relasi,
        biaya: biaya,
        idOrangLain: result['id_janji_temu_as_orang_lain'],
        status: "Menunggu Ambil Antrian",
        dokter: {},
        user: {},
        relasi: {},
        janjiOrangLain: result,
      );

      return await janji.createJanjiTemu(_token, newJanji);
    } else {
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sideMargin),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Isi Identitas Diri",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5)),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Isi data dengan baik dan benar",
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          FormText(
                              validator: notNullValidator,
                              inputLabel: "Poli Tujuan",
                              controller: _poliController,
                              readOnly: true),
                          FormText(
                              validator: notNullValidator,
                              inputLabel: "Dokter",
                              controller: _namaDokterController,
                              readOnly: true),
                          FormText(
                            validator: notNullValidator,
                            inputLabel: "Nama Lengkap *",
                            hintText: "Masukkan nama lengkap",
                            controller: _namaLengkapController,
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
                      child: PrimaryButton(
                        buttonText: "Buat Janji",
                        containerWidth: 160,
                        fontSize: 18,
                        onPressed: () async {
                          bool isSucceed = await createJanjiTemu(context);
                          if (isSucceed) {
                            // Navigator.pop(context);
                            _showDialogBerhasil();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Gagal Membuat Janji!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialogBerhasil() {
    return showDialog(
        context: context,
        builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AlertDialog(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  insetPadding: EdgeInsets.all(25),
                  content: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: Icon(
                                Icons.close,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "BERHASIL",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(
                                width: 175,
                                child: Divider(
                                  color: dividerColor,
                                  thickness: 3,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 4, bottom: 0),
                                child: Text(
                                    "Berhasil membuat janji bersama dokter!",
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 14,
                                    )),
                              ),
                              Divider(
                                color: dividerColor,
                                thickness: 1,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 4, bottom: 0),
                                child: Text("Lekas sembuh",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontSize: 20,
                                        fontWeight: semi,
                                        letterSpacing: 1.5)),
                              ),
                              Divider(
                                color: dividerColor,
                                thickness: 1,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0, bottom: 15),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  PrimaryButton(
                                      containerWidth:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      onPressed: () {
                                        Navigator.pop(context, 'open');
                                        Navigator.pop(context, 'open');
                                      },
                                      buttonText: "Buat Janji",
                                      fontSize: 15),
                                  PrimaryButton(
                                      containerWidth:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      onPressed: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const JadwalTemuPage()));
                                      },
                                      buttonText: "Cek Janji",
                                      fontSize: 15)
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }
}
