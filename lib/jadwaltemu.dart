import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/ambilantrian.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';
import 'package:intl/intl.dart';

class JadwalTemuPage extends StatefulWidget {
  const JadwalTemuPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<JadwalTemuPage> createState() => _JadwalTemuPageState();
}

class _JadwalTemuPageState extends State<JadwalTemuPage> with AppMixin{
  
  double boxHeight = 35.0;
  bool? isChecked = false;

  void alterChecked(bool? newBool){
    setState(() {
      isChecked = newBool;
    });
  }

  final List<List<dynamic>> daftarJanjiTemu = [
    // 1              2          3            4                  5            6        7         8   
  ['SY12345678', '2024-04-20', 'THT', 'Andreas Bernabue', 'Aurora Alsava', '2', '350000', 'assets/images/daftarJanjiTemuPage/boy1.jpeg'],
  ['SY87654321', '2024-04-21', 'Kulit', 'Christina Ozzy', 'Aurora Alsava', '','200000', 'assets/images/daftarJanjiTemuPage/girl1.jpeg'],
  ['SY12457801', '2024-04-22', 'Mata', 'Marlo Ernesto', 'Aurora Alsava', '','250000', 'assets/images/daftarJanjiTemuPage/boy2.jpeg'],
  ['SY01928374', '2024-04-23', 'Paru', 'Brian Andy', 'Rich Brian', '7','190000', 'assets/images/daftarJanjiTemuPage/boy3.jpeg'],
  ['SY25372900', '2024-04-24', 'Jantung', 'Vivian Rosalia', 'Rich Brian', '1','200000', 'assets/images/daftarJanjiTemuPage/girl2.jpeg'],
];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: BackButton(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: sideMargin, right: sideMargin, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Jadwal Temu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: semi,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 10,),
              Text(
                'Lihat semua daftar temu yang sudah Anda buat.',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 40,),
              ListView.builder(
                shrinkWrap: true, // Agar ListView mengikuti ukuran kontennya
                physics: NeverScrollableScrollPhysics(), // Agar ListView tidak bisa di-scroll
                itemCount: daftarJanjiTemu.length,
                itemBuilder: (BuildContext context, int index) {
                  List<dynamic> janji = daftarJanjiTemu[index];
                  return Container( // Tambahkan Container di sini
                    margin: EdgeInsets.only(bottom: 20),
                    height: 180,
                    padding: EdgeInsets.all(10), // Atur padding sesuai kebutuhan
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
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      // ID
                                      '${janji[0]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.8,
                                        fontWeight: semi,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                    Text(
                                      ' | ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.8,
                                        fontWeight: light,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                    Text(
                                      // Tanggal
                                      '${janji[1]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.8,
                                        fontWeight: semi,
                                        color: Theme.of(context).colorScheme.onPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text(
                                      // Spesialisasi
                                      '${janji[2]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.8,
                                        fontWeight: medium,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    Text(
                                      ' | ',
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.8,
                                        fontWeight: light,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    Text(
                                      // Nama Dokter
                                      '${janji[3]}',
                                      style: TextStyle(
                                        fontSize: 15,
                                        letterSpacing: 0.8,
                                        fontWeight: medium,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5),
                                Text(
                                  // nama pasien
                                  '${janji[4]}',
                                  style: TextStyle(
                                    fontWeight: medium,
                                    fontSize: 14,
                                    color: Color(0xFF94B0B7),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  // nomor antrian
                                  'Antrian ke: ${janji[5].isEmpty ? '-' : janji[5]}',
                                  style: TextStyle(
                                    fontWeight: medium,
                                    fontSize: 15,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  // harga
                                  'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(int.parse(janji[6]))}', // formatting uang
                                  style: TextStyle(
                                    fontWeight: semi,
                                    fontSize: 15,
                                    color: Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                       Container(
                                        height: 80,
                                        width: 80,
                                        decoration: BoxDecoration(
                                          color: Colors.black12,
                                          borderRadius: BorderRadius.circular(5), // Tambahkan borderRadius di dalam BoxDecoration
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(5), // Untuk memastikan gambar terpotong sesuai dengan borderRadius
                                          child: Image.asset(
                                            janji[7], // Gunakan imagePath langsung
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          // Navigasi ke halaman baru
                                           if (janji[5].isEmpty) {
                                              // Navigasi ke halaman baru jika kondisi terpenuhi 325
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => AmbilAntrianPage(janjiTemu: janji, id : janji[0], tanggal : janji[1], namadokter : janji[3], spesialisasi: janji[2], harga : janji[6], foto: janji[7])),
                                              );
                                            }
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          // height: 26,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: janji[5].isEmpty ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                                            borderRadius: BorderRadius.circular(7),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Ambil Antrian',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: medium,
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                            ),
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
                  );
                },
              ),
            
            ],
          ),
        ),
      )
      //  This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
