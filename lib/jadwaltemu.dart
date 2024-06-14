import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/ambilantrian.dart';
import 'package:sehatyuk/cari_dokter.dart';
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

class _JadwalTemuPageState extends State<JadwalTemuPage> with AppMixin {
  double boxHeight = 35.0;
  bool? isChecked = false;
  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";
  bool _isInitialized = false;

  void alterChecked(bool? newBool) {
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
    _token = await auth.getToken();
    _user_id = await auth.getId();
    await context.read<JanjiTemuProvider>().fetchData(_token, _user_id);
    if(mounted){
      setState(() {
        _isInitialized = true;
      });
    }

  }

  List<Doctor> doctorJoin = [];
  int len = 0;

  @override
  Widget build(BuildContext context) {
    var janji_temu = context.watch<JanjiTemuProvider>();

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.only(left: sideMargin, right: sideMargin, top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text(
                  'Jadwal Temu',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Lihat semua daftar temu yang sudah Anda buat.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
                SizedBox(height: 16),
                _isInitialized ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: janji_temu.janjiTemuList.length,
                  itemBuilder: (context, index) {
                    var janjiTemu = janji_temu.janjiTemuList[index];
                    var nama;
                    if (janji_temu.janjiTemuList[index].idOrangLain != 0) {
                      nama = janji_temu.janjiTemuList[index]
                          .janjiOrangLain['nama_lengkap_orang_lain'];
                    } else {
                      nama = (janji_temu.janjiTemuList[index].isRelasi == 1
                          ? janji_temu.janjiTemuList[index]
                              .relasi["nama_lengkap_relasi"]
                          : janji_temu
                              .janjiTemuList[index].user["nama_lengkap_user"]);
                    }
                    String status = janji_temu.janjiTemuList[index].status;
                    bool btnEnabled = true;
                    bool cancelEnabled = true;
                    String btnText = "";
                    if (status == "Menunggu Ambil Antrian") {
                      btnText = "Ambil Antrian";
                    } else if (status == "Menunggu Antrian") {
                      btnText = "Cek Antrian";
                      cancelEnabled = false;
                    } else {
                      btnText = status;
                      btnEnabled = false;
                      cancelEnabled = false;
                    }

                    return JadwalTemuCard(
                      token: _token,
                      onPressed: () {},
                      id_janji_temu:
                          janji_temu.janjiTemuList[index].id.toString(),
                      kode_janji_temu:
                          janji_temu.janjiTemuList[index].kodeJanjiTemu,
                      tgl_janji_temu:
                          janji_temu.janjiTemuList[index].tanggalJanjiTemu,
                      id_dokter:
                          janji_temu.janjiTemuList[index].idDokter.toString(),
                      is_relasi:
                          janji_temu.janjiTemuList[index].isRelasi.toString(),
                      id_relasi:
                          janji_temu.janjiTemuList[index].idRelasi.toString(),
                      biaya_janji_temu:
                          janji_temu.janjiTemuList[index].biaya.toString(),
                      spesialisasi: janji_temu
                          .janjiTemuList[index].dokter["spesialisasi_dokter"],
                      namaDokter: janji_temu
                          .janjiTemuList[index].dokter["nama_lengkap_dokter"],
                      imageDokter:
                          janji_temu.janjiTemuList[index].dokter["foto_dokter"],
                      namaPasien: nama,
                      status: btnText,
                      btnEnabled: btnEnabled,
                      cancelEnabled: cancelEnabled,
                      index: index,
                    );
                  },
                ) : Center(child: CircularProgressIndicator()),
              ],
            ),
          ),
        ));
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
  final String status;
  final bool btnEnabled;
  final bool cancelEnabled;
  final int index;

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
    required this.status,
    required this.btnEnabled,
    required this.cancelEnabled,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
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
                            kode_janji_temu,
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                          ),
                          Text(
                            ' | ',
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                          ),
                          Text(
                            tgl_janji_temu,
                            style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 0.8,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              spesialisasi,
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Text(
                              ' | ',
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            ),
                          ),
                          Expanded(
                            flex: 6,
                            child: Text(
                              namaDokter,
                              style: TextStyle(
                                fontSize: 12,
                                letterSpacing: 0.8,
                                fontWeight: FontWeight.w500,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text(
                        namaPasien,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                          color: Color(0xFF94B0B7),
                        ),
                        textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                      ),
                      SizedBox(height: 10),
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(int.parse(biaya_janji_temu))}',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                          ),
                          SizedBox(width: 32),
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
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      _showCancelConfirmationDialog(context);
                    },
                    child: Visibility(
                      visible: cancelEnabled,
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: MediaQuery.of(context).size.width * 0.4,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 145, 60, 60),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Cancel Janji',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                    visible: btnEnabled,
                    child: SizedBox(
                      width: 10,
                    )),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if (btnEnabled) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AmbilAntrianPage(
                                  id: id_janji_temu,
                                  kode: kode_janji_temu,
                                  tanggal: tgl_janji_temu,
                                  namadokter: namaDokter,
                                  spesialisasi: spesialisasi,
                                  harga: biaya_janji_temu,
                                  id_dokter: id_dokter,
                                  index: index)),
                        );
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.4,
                      decoration: BoxDecoration(
                        color: btnEnabled
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.tertiary,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            status,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _showCancelConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text('Konfirmasi'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Apakah Anda yakin ingin membatalkan janji temu ini?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Ya'),
              onPressed: () async {
                bool deleted = await context
                    .read<JanjiTemuProvider>()
                    .deleteData(token, id_janji_temu);
                if (deleted) {
                  print('Janji temu berhasil dibatalkan');
                } else {
                  print('Gagal membatalkan janji temu');
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
