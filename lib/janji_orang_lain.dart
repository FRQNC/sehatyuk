import 'package:flutter/material.dart';
import 'package:sehatyuk/jadwaltemu.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';
import 'package:sehatyuk/templates/form/form_text.dart';
import 'package:sehatyuk/templates/form/form_date.dart';


class BuatJanjiOtherPage extends StatefulWidget {
  const BuatJanjiOtherPage({super.key});

  @override
  State<BuatJanjiOtherPage> createState() => _BuatJanjiOtherPageState();
}

class _BuatJanjiOtherPageState extends State<BuatJanjiOtherPage> with AppMixin {
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

  TextEditingController _dateController = TextEditingController();
  TextEditingController _poliController = TextEditingController(text: "Spesialis Jantung");
  TextEditingController _namaDokterController = TextEditingController(text: "Nama Dokter");
  TextEditingController _namaLengkapController = TextEditingController();
  TextEditingController _noBPJSController = TextEditingController();
  TextEditingController _noTelpController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();

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
                              inputLabel: "Poli Tujuan",
                              controller: _poliController,
                              readOnly: true),
                          FormText(
                              inputLabel: "Dokter",
                              controller: _namaDokterController,
                              readOnly: true),
                          FormText(
                              inputLabel: "Nama Lengkap *",
                              hintText: "Masukkan nama lengkap",
                              controller: _namaLengkapController,
                              ),
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
                          buttonText: "Buat Janji",
                          containerWidth: 160,
                          fontSize: 18,
                          onPressed: () {
                            showDialog(
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
                                                onTap: () => Navigator.pop(context),
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
                                                      color: Theme.of(context).colorScheme.onPrimary,
                                                      fontSize: 14,
                                                    )
                                                    ),
                                                ),
                                                Divider(
                                                  color: dividerColor,
                                                  thickness: 1,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top: 4, bottom: 0),
                                                  child: Text(
                                                    "Lekas sembuh",
                                                    style: TextStyle(
                                                      color: Theme.of(context).colorScheme.primary,
                                                      fontSize: 20,
                                                      fontWeight: semi,
                                                      letterSpacing: 1.5
                                                    )
                                                    ),
                                                ),
                                                Divider(
                                                  color: dividerColor,
                                                  thickness: 1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 20.0, bottom:15),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    PrimaryButton(containerWidth: MediaQuery.of(context).size.width*0.3, onPressed: (){}, buttonText: "Buat Janji", fontSize: 15),
                                                    PrimaryButton(containerWidth: MediaQuery.of(context).size.width*0.3, onPressed: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => const JadwalTemuPage())); }, buttonText: "Cek Janji", fontSize: 15)
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
                              )
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
      ),
    );
  }
}