import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/ambilantrian.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';
import 'package:intl/intl.dart';
import 'package:sehatyuk/models/doctor.dart';
import 'package:sehatyuk/providers/doctor_provider.dart';
import 'package:sehatyuk/providers/janji_temu_provider.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sehatyuk/providers/user_provider.dart';


class JadwalTemuPage extends StatefulWidget {
  const JadwalTemuPage({super.key});


  @override
  State<JadwalTemuPage> createState() => _JadwalTemuPageState();
}

class _JadwalTemuPageState extends State<JadwalTemuPage> with AppMixin{
  
  double boxHeight = 35.0;
  bool? isChecked = false;
  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";

  void alterChecked(bool? newBool){
    setState(() {
      isChecked = newBool;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchToken();
  }

  Future<void> _fetchToken() async {
    // Fetch the token asynchronously
    _token = await auth.getToken();
    _user_id = await auth.getId();
    // Once token is fetched, trigger a rebuild of the widget tree
    setState(() {});
    await context.read<JanjiTemuProvider>().fetchData(_token, _user_id);
  }

  List<Doctor> doctorJoin = [];
  int len = 0;

  @override
  Widget build(BuildContext context) {
    var janji_temu = context.watch<JanjiTemuProvider>();
    print(janji_temu.janjiTemuList);

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
                itemCount: janji_temu.janjiTemuList.length,
                itemBuilder: (context, index) {
                  var janjiTemu = janji_temu.janjiTemuList[index];
                  // var doctor = context.watch<DoctorProvider>();
                  // var currentDoctor = null;
                  // if(currentDoctor == null){
                  //   doctor.fetchDataById(_token, janjiTemu.idDokter);
                  //   currentDoctor = doctor.dataDokter;
                  // }
                  // var detailDokter = doctor.fetchDataById(_token, janjiTemu.idDokter);
                  return JadwalTemuCard(
                      token: _token,
                      onPressed: () {},
                      id_janji_temu: janji_temu.janjiTemuList[index].id.toString(),
                      kode_janji_temu: janji_temu.janjiTemuList[index].kodeJanjiTemu,
                      tgl_janji_temu: janji_temu.janjiTemuList[index].tanggalJanjiTemu,
                      id_dokter: janji_temu.janjiTemuList[index].idDokter.toString(),
                      is_relasi: janji_temu.janjiTemuList[index].isRelasi.toString(),
                      id_relasi: janji_temu.janjiTemuList[index].idRelasi.toString(),
                      biaya_janji_temu: janji_temu.janjiTemuList[index].biaya.toString(),
                      spesialisasi: janji_temu.janjiTemuList[index].dokter["spesialisasi_dokter"],
                      namaDokter: janji_temu.janjiTemuList[index].dokter["nama_lengkap_dokter"],
                      imageDokter: janji_temu.janjiTemuList[index].dokter["foto_dokter"],
                      namaPasien: (janji_temu.janjiTemuList[index].isRelasi == 1 ? janji_temu.janjiTemuList[index].relasi["nama_lengkap_relasi"] : janji_temu.janjiTemuList[index].user["nama_lengkap_user"]),
                  );
                },
              ),
            ],
          ),
        ),
      )
    );
  }
}

class JadwalTemuCard extends StatelessWidget{
  final String token;
  final String id_janji_temu;
  final String kode_janji_temu;
  final String tgl_janji_temu;
  final String id_dokter;
  final String is_relasi;
  final String id_relasi;
  final String biaya_janji_temu;
  final VoidCallback onPressed;
  final String spesialisasi;
  final String namaDokter;
  final String imageDokter;
  final String namaPasien;

  const JadwalTemuCard({
    Key? key,
    required this.token,
    required this.id_janji_temu,
    required this.kode_janji_temu,
    required this.tgl_janji_temu,
    required this.id_dokter,
    required this.is_relasi,
    required this.id_relasi,
    required this.biaya_janji_temu,
    required this.onPressed,
    required this.spesialisasi,
    required this.namaDokter,
    required this.imageDokter,
    required this.namaPasien,
  }) : super(key: key);


  @override
  Widget build(BuildContext context){
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
                        kode_janji_temu,
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      Text(
                        // Tanggal
                        tgl_janji_temu,
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w600,
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
                        spesialisasi,
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        ' | ',
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text(
                        // Nama Dokter
                        namaDokter,
                        style: TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.8,
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    // nama pasien
                    namaPasien,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Color(0xFF94B0B7),
                    ),
                  ),
                  SizedBox(height: 10),
                  // Text(
                  //   // nomor antrian
                  //   'Antrian ke: ${janji[5].isEmpty ? '-' : janji[5]}',
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w500,
                  //     fontSize: 15,
                  //     color: Theme.of(context).colorScheme.primary,
                  //   ),
                  // ),
                  SizedBox(height: 15),
                  Text(
                    // harga
                    'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(int.parse(biaya_janji_temu))}', // formatting uang
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
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
                          // decoration: BoxDecoration(
                          //   color: Colors.black12,
                          //   borderRadius: BorderRadius.circular(5),
                          // ),
                          // Ubah dari Image.asset menjadi DecorationImage
                          // child: ClipRRect(
                          //   borderRadius: BorderRadius.circular(5),
                          //   child: Image.asset(
                          //     imageDokter,
                          //     height: 80,
                          //     width: 80,
                          //     fit: BoxFit.cover,
                          //   ),
                          // ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            // Gunakan CachedNetworkImageProvider
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                '${Endpoint.url}dokter_image/$id_dokter',
                                headers: <String, String>{
                                  'accept': 'application/json',
                                  'Authorization': 'Bearer $token',
                                },
                              ),
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
                            // // Navigasi ke halaman baru
                            //   if (janji[5].isEmpty) {
                            //     // Navigasi ke halaman baru jika kondisi terpenuhi 325
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(builder: (context) => AmbilAntrianPage(janjiTemu: janji, id : janji[0], tanggal : janji[1], namadokter : janji[3], spesialisasi: janji[2], harga : janji[6], foto: janji[7])),
                            //     );
                            //   }
                          },
                          child: Container(
                            alignment: Alignment.center,
                            // height: 26,
                            width: 80,
                            decoration: BoxDecoration(
                              // color: janji[5].isEmpty ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.secondary,
                              color: Theme.of(context).colorScheme.primary,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Center(
                              child: Text(
                                'Ambil Antrian',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
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
  }
}