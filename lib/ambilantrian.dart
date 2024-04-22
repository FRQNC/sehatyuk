import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/jadwaltemu.dart';
import 'package:intl/intl.dart';

class AmbilAntrianPage extends StatefulWidget {
  final List<dynamic> janjiTemu;
  final String id; // Tambahkan parameter id
  final String tanggal; // Tambahkan parameter tanggal
  final String namadokter; // Tambahkan parameter namadokter
  final String spesialisasi; // Tambahkan parameter spesialisasi
  final String harga; // Tambahkan parameter harga
  final String foto; // Tambahkan parameter foto

  const AmbilAntrianPage({Key? key, required this.janjiTemu, required this.id, required this.tanggal, required this.namadokter, required this.spesialisasi, required this.harga, required this.foto}) : super(key: key);

  @override
  State<AmbilAntrianPage> createState() => _AmbilAntrianPageState();
}

class _AmbilAntrianPageState extends State<AmbilAntrianPage> with AppMixin{
  double boxHeight = 35.0;
  bool? isChecked = false;
  late String id; // Simpan id dalam state
  late String tanggal; // Simpan tanggal dalam state
  late String namadokter; // Simpan namadokter dalam state
  late String spesialisasi;// Simpan spesialisasidalam state
  late String harga;// Simpan hargadalam state
  late String foto; // Simpan foto dalam state
  
  @override
  void initState() {
    super.initState();
    id = widget.id; // Inisialisasi id dengan nilai yang diterima dari konstruktor
    tanggal = widget.tanggal; // Inisialisasi tanggal dengan nilai yang diterima dari konstruktor
    namadokter = widget.namadokter; // Inisialisasi namadokter dengan nilai yang diterima dari konstruktor
    spesialisasi = widget.spesialisasi; // Inisialisasi spesialisasi dengan nilai yang diterima dari konstruktor
    harga = widget.harga; // Inisialisasi harga dengan nilai yang diterima dari konstruktor
    foto = widget.foto; // Inisialisasi foto dengan nilai yang diterima dari konstruktor
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => JadwalTemuPage()),
            );
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Text(
          'Ambil Nomor Antrian',
          style: TextStyle(
            fontWeight: semi,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 0.8,
          ),
          ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: sideMargin, right: sideMargin, top: 12),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 105,
                  ),
                  Positioned(
                    top: 0,
                    child: Row(
                      children: [
                        SizedBox(width: 60,),
                        Container(
                          width: MediaQuery.of(context).size.width-2*sideMargin-60,
                          height: 105,
                          decoration: BoxDecoration(
                            color: Colors.white, // Atur warna latar belakang sesuai kebutuhan
                            borderRadius: BorderRadius.circular(10), // Atur border radius sesuai kebutuhan
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          // decoration: BoxDecoration(
                          //   borderRadius: BorderRadius.all(Radius.circular(20)),
                          //   color: boxColor,
                          // ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Row(
                              children: [
                                SizedBox(width: 40,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width-2*sideMargin-130,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              // 
                                              id,
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onPrimary,
                                                fontSize: 13,
                                                fontWeight: semi,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            tanggal,
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.primary,
                                              fontSize: 12,
                                              fontWeight: medium,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 5,),
                                    Row(
                                      children: [
                                        Text(
                                          // Spesialisasi
                                          spesialisasi,
                                          style: TextStyle(
                                            letterSpacing: 0.8,
                                            fontSize: 15,
                                            fontWeight: medium,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        Text(
                                          ' | ',
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: light,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                        Text(
                                          // Nama Dokter
                                          namadokter,
                                          style: TextStyle(
                                            letterSpacing: 0.8,
                                            fontSize: 15,
                                            fontWeight: medium,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 10,),
                                    Expanded(
                                      child: Text(
                                        'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(int.parse(harga))}', // formatting uang
                                        // harga,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          fontSize: 15,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                    
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white, // Atur warna latar belakang sesuai kebutuhan
                      // borderRadius: BorderRadius.circular(10), // Atur border radius sesuai kebutuhan
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          // color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(foto),
                      radius: 47.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 25,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white, // Atur warna latar belakang sesuai kebutuhan
                  borderRadius: BorderRadius.circular(10), // Atur border radius sesuai kebutuhan
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                      // crossAxisAlignment: CrossAxisAlignment.start,
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Banyak Antrian:',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: semi,
                                          letterSpacing: 0.8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    '5',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontSize: 15,
                                      fontWeight: semi,
                                      letterSpacing: 0.8,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            // divider
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                width: 1, // Specify the width of the Divider
                                height: MediaQuery.of(context).size.height * 0.1, // Specify the height of the Divider
                                color: Theme.of(context).colorScheme.primaryContainer, // Specify the color of the Divider
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Antrian Saat Ini:',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: semi,
                                          letterSpacing: 0.8,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10,),
                                  Text(
                                    '2',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontSize: 15,
                                      fontWeight: semi,
                                      letterSpacing: 0.8,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 5, left: 5, top: 5, bottom: 13),
                          child: Divider(
                            color: Theme.of(context).colorScheme.primaryContainer, // Atur warna divider sesuai keinginan Anda
                            thickness: 1, // Atur ketebalan divider sesuai keinginan Anda
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Antrian Anda jika mengambil sekarang:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: semi,
                                      letterSpacing: 0.8,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                '6',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 15,
                                  fontWeight: semi,
                                  letterSpacing: 0.8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              
              ),
              SizedBox(height: 30,),
              Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => JadwalTemuPage()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Ambil Antrian',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: semi,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ),


            ],
          ),
        ),
      
      ),
      // body: SingleChildScrollView(
      //   child: Padding(
      //     padding: EdgeInsets.only(left: sideMargin, right: sideMargin, top: 8),
      //     child: Column(
      //       children: [
      //         Stack(
      //           alignment: Alignment.centerLeft,
      //           children: [
      //             // ... kode lainnya
      //             CircleAvatar(
      //               backgroundImage: AssetImage(foto), // Gunakan foto yang disimpan dalam state
      //               radius: 47.5
      //             ),
      //           ],
      //         ),
      //         // ... kode lainnya
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}