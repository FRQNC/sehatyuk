import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/daftarresume.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/cari_dokter.dart';

class ResumeMedisPage extends StatefulWidget {
  const ResumeMedisPage({super.key});

  @override
  State<ResumeMedisPage> createState() => _ResumeMedisPageState();
}

class _ResumeMedisPageState extends State<ResumeMedisPage> with AppMixin {
  @override
  Widget build(BuildContext context) {
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
                              '12345',
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
                              '-',
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
                          'Aurora Alsava | 17 tahun',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: medium,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Text(
                          'Perempuan',
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
                          'THT | Dr. Ujang Suherman',
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
                          'Otitis Eksterna',
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
                          'Diberi resep obat tetes telinga.',
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
                          'Antibiotik | 1 tetes 2 x sehari',
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
                          'Disarankan untuk menjaga telinganya tetap kering.',
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
              SizedBox(
                height: 30,
              ),
              Center(
                child: TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'Unduh\nDiagnosa',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: semi,
                      color: Colors.white,
                      letterSpacing: 1.0,
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
