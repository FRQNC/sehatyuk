import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/daftarresume.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/cari_dokter.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/models/rekam_medis.dart';

class ResumeMedisPage extends StatefulWidget {
  final RekamMedis detail;

  const ResumeMedisPage({Key? key, required this.detail}) : super(key: key);

  @override
  State<ResumeMedisPage> createState() => _ResumeMedisPageState();
}

class _ResumeMedisPageState extends State<ResumeMedisPage> with AppMixin {
  String pasien = "";
  String bpjs = "";
  int usia = 0;
  String gender = "";
  late RekamMedis data;
  
  @override
  void initState(){
    super.initState();
    data = widget.detail;
    if(data.janjiTemu['id_janji_temu_as_orang_lain'] != 0){
      pasien = data.janjiTemu['janji_temu_as_orang_lain']['nama_lengkap_orang_lain'];
      bpjs = data.janjiTemu['janji_temu_as_orang_lain']['no_bpjs_orang_lain'];
      usia = calculateAge(data.janjiTemu['janji_temu_as_orang_lain']['tgl_lahir_orang_lain']);
      gender = data.janjiTemu['janji_temu_as_orang_lain']['gender_orang_lain'];
    }
    else if(data.janjiTemu['is_relasi'] == 1){
      pasien = data.janjiTemu['relasi']['nama_lengkap_relasi'];
      bpjs = data.janjiTemu['relasi']['no_bpjs_relasi'];
      usia = calculateAge(data.janjiTemu['relasi']['tgl_lahir_relasi']);
      gender = data.janjiTemu['relasi']['gender_relasi'];
    }
    else{
      pasien = data.janjiTemu['user']['nama_lengkap_user'];
      bpjs = data.janjiTemu['user']['no_bpjs_user'];
      usia = calculateAge(data.janjiTemu['user']['tgl_lahir_user']);
      gender = data.janjiTemu['user']['gender_user'];
    }
  }

  int calculateAge(String bod) {
    DateTime birthDate = DateTime.parse(bod);
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate.year;
    int month1 = currentDate.month;
    int month2 = birthDate.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate.day;
      if (day2 > day1) {
        age--;
      }
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    // if(data.janjiTemu['id_janji_temu_as_orang_lain'] == 0){
    //   pasien = data.janjiTemu['janji_temu_as_orang_lain']['nama_lengkap_orang_lain'];
    //   bpjs = data.janjiTemu['janji_temu_as_orang_lain']['no_bpjs_orang_lain'];
    //   usia = calculateAge(data.janjiTemu['janji_temu_as_orang_lain']['tgl_lahir_orang_lain']);
    //   gender = data.janjiTemu['janji_temu_as_orang_lain']['gender_orang_lain'];
    // }
    // else if(data.janjiTemu['is_relasi'] == 1){
    //   pasien = data.janjiTemu['relasi']['nama_lengkap_relasi'];
    //   bpjs = data.janjiTemu['relasi']['no_bpjs_relasi'];
    //   usia = calculateAge(data.janjiTemu['relasi']['tgl_lahir_relasi']);
    //   gender = data.janjiTemu['relasi']['gender_relasi'];
    // }
    // else{
    //   pasien = data.janjiTemu['user']['nama_lengkap_user'];
    //   bpjs = data.janjiTemu['user']['no_bpjs_user'];
    //   usia = calculateAge(data.janjiTemu['user']['tgl_lahir_user']);
    //   gender = data.janjiTemu['user']['gender_user'];
    // }

    // if(type == 1){
    //   pasien = data.janjiTemu['user']['nama_lengkap_user'];
    //   bpjs = data.janjiTemu['user']['no_bpjs_user'];
    //   usia = calculateAge(data.janjiTemu['user']['tgl_lahir_user']);
    //   gender = data.janjiTemu['user']['gender_user'];
    // }
    // else if(type == 2){
    //   pasien = data.janjiTemu['relasi']['nama_lengkap_relasi'];
    //   bpjs = data.janjiTemu['relasi']['no_bpjs_relasi'];
    //   usia = calculateAge(data.janjiTemu['relasi']['tgl_lahir_relasi']);
    //   gender = data.janjiTemu['relasi']['gender_relasi'];
    // }
    // else{
    //   pasien = data.janjiTemu['janji_temu_as_orang_lain']['nama_lengkap_orang_lain'];
    //   bpjs = data.janjiTemu['janji_temu_as_orang_lain']['no_bpjs_orang_lain'];
    //   usia = calculateAge(data.janjiTemu['janji_temu_as_orang_lain']['tgl_lahir_orang_lain']);
    //   gender = data.janjiTemu['janji_temu_as_orang_lain']['gender_orang_lain'];
    // }

    return Scaffold(
      backgroundColor: Colors.white,
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
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'Resume Medis',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: semi,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: sideMargin, right: sideMargin, top: 8),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: boxColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'No Rekam Medis : ',
                              style: TextStyle(
                                color: Color(0xff4A707A),
                                fontSize: 14,
                                fontWeight: bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                            Text(
                              data.janjiTemu["kode_janji_temu"],
                              style: TextStyle(
                                color: Color(0xff37363B),
                                fontSize: 14,
                                fontWeight: bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'No Asuransi          : ',
                              style: TextStyle(
                                color: Color(0xff4A707A),
                                fontSize: 14,
                                fontWeight: bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                            Text(
                              (bpjs == "" ? "-" : bpjs),
                              style: TextStyle(
                                color: Color(0xff37363B),
                                fontSize: 14,
                                fontWeight: bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '$pasien | $usia tahun',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: medium,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          gender,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: medium,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: boxColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                            Text(
                              'Terakhir Bertemu',
                              style: TextStyle(
                                color: Color(0xff4A707A),
                                fontSize: 14,
                                fontWeight: bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                        Text(
                          '${data.janjiTemu['dokter']['spesialisasi_dokter']} | ${data.janjiTemu['dokter']['nama_lengkap_dokter']}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: medium,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 5,
                          color: dividerColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                              'Hasil Diagnosis',
                              style: TextStyle(
                                color: Color(0xff4A707A),
                                fontSize: 14,
                                fontWeight: bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                        Text(
                          data.hasilDiagnosis,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: medium,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 5,
                          color: dividerColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                              'Pengobatan atau Tindakan',
                              style: TextStyle(
                                color: Color(0xff4A707A),
                                fontSize: 14,
                                fontWeight: bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                        Text(
                          data.pengobatan,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: medium,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 5,
                          color: dividerColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                              'Obat dan Dosis',
                              style: TextStyle(
                                color: Color(0xff4A707A),
                                fontSize: 14,
                                fontWeight: bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                        Text(
                          '${data.obat['nama_obat']} | ${data.dosisobat}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: medium,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 5,
                          color: dividerColor,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                              'Catatan',
                              style: TextStyle(
                                color: Color(0xff4A707A),
                                fontSize: 14,
                                fontWeight: bold,
                                letterSpacing: 0.8,
                              ),
                            ),
                        Text(
                          data.catatan,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: medium,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Divider(
                          height: 5,
                          color: dividerColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
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
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
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
}
