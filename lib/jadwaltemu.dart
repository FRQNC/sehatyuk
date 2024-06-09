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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: sideMargin, right: sideMargin, top: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
      SizedBox(height: 32),
              Text(
                'Jadwal Temu',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8,),
              Text(
                'Lihat semua daftar temu yang sudah Anda buat.',
                style: TextStyle(
                  fontSize: 10,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              SizedBox(height: 16),
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
                  var nama;
                  if(janji_temu.janjiTemuList[index].idOrangLain != 0){
                    nama = janji_temu.janjiTemuList[index].janjiOrangLain['nama_lengkap_orang_lain'];
                  }
                  else{
                    nama = (janji_temu.janjiTemuList[index].isRelasi == 1 ? janji_temu.janjiTemuList[index].relasi["nama_lengkap_relasi"] : janji_temu.janjiTemuList[index].user["nama_lengkap_user"]);
                  }
                  
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
                      namaPasien: nama,
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
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        // harga
                        'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(int.parse(biaya_janji_temu))}', // formatting uang
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      ),
                      SizedBox(width: 32), // Spasi antara teks harga dan tombol delete
                      GestureDetector(
                        onTap: () async {
                          _showCancelConfirmationDialog(context);
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
                                'Cancel Antrian',
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
                            // print("dokter: $id_dokter");
                                Navigator.push(          
                                  context,
                                  MaterialPageRoute(builder: (context) => AmbilAntrianPage(id : kode_janji_temu, tanggal : tgl_janji_temu, namadokter : namaDokter, spesialisasi: spesialisasi, harga : biaya_janji_temu, id_dokter: id_dokter)),
                                );
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
  Future<void> _showCancelConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Konfirmasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin membatalkan antrian ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () async {
                bool deleted = await context.read<JanjiTemuProvider>().deleteData(token, id_janji_temu);
                if (deleted) {
                  // Jika penghapusan berhasil, lakukan sesuatu, misalnya, tampilkan pesan sukses atau perbarui tampilan
                  print('Janji temu berhasil dibatalkan');
                } else {
                  // Jika penghapusan gagal, lakukan sesuatu, misalnya, tampilkan pesan error
                  print('Gagal membatalkan janji temu');
                }
                Navigator.of(context).pop(); // Tutup dialog
              },
            ),
          ],
        );
      },
    );
  }
}
