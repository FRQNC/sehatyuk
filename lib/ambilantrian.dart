import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/jadwaltemu.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/providers/janji_temu_provider.dart';
import 'package:provider/provider.dart';

class AmbilAntrianPage extends StatefulWidget {
  final String id;
  final String kode;
  final String tanggal;
  final String namadokter;
  final String spesialisasi;
  final String harga;
  final String id_dokter;
  final int index;

  const AmbilAntrianPage(
      {Key? key,
      required this.id,
      required this.kode,
      required this.tanggal,
      required this.namadokter,
      required this.spesialisasi,
      required this.harga,
      required this.id_dokter,
      required this.index})
      : super(key: key);

  @override
  State<AmbilAntrianPage> createState() => _AmbilAntrianPageState();
}

class _AmbilAntrianPageState extends State<AmbilAntrianPage> with AppMixin {
  double boxHeight = 35.0;
  bool? isChecked = false;
  late String id;
  late String kode;
  late String tanggal;
  late String namadokter;
  late String spesialisasi;
  late String harga;
  late String id_dokter;

  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";

  @override
  void initState() {
    super.initState();
    id = widget.id;
    kode = widget.kode;
    tanggal = widget.tanggal;
    namadokter = widget.namadokter;
    spesialisasi = widget.spesialisasi;
    harga = widget.harga;
    id_dokter = widget.id_dokter;
    _fetchToken();
  }

  Future<void> _fetchToken() async {
    _token = await auth.getToken();
    _user_id = await auth.getId();
    await context.read<JanjiTemuProvider>().fetchData(_token, _user_id);
    if(mounted){
      setState(() {});
    }
  }

  bool _antrianDiambil = false;

  @override
  Widget build(BuildContext context) {
    var status =
        context.watch<JanjiTemuProvider>().janjiTemuList[widget.index].status;

    if (status != "Menunggu Ambil Antrian") {
      _antrianDiambil = true;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
          'Ambil Nomor Antrian',
          style: TextStyle(
            fontWeight: semi,
            fontSize: 20,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 0.8,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: !_antrianDiambil,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                  Center(child: Text("Tunjukkan kode QR ke petugas.", style: TextStyle(fontSize: 16),),),
                  SizedBox(height: 15,),
                      Container(
                        height: MediaQuery.of(context).size.width * 0.80,
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Image.asset(
                          'assets/images/ambilAntrianPage/sehatyuk_qrcode.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _antrianDiambil,
              child: Padding(
                padding: EdgeInsets.only(
                    left: sideMargin, right: sideMargin, top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
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
                              SizedBox(
                                width: 60,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width -
                                    2 * sideMargin -
                                    60,
                                height: 105,
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
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 15, 10, 15),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 40,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                2 * sideMargin -
                                                130,
                                            child: Row(
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                                    kode,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                      fontSize: 13,
                                                      fontWeight: semi,
                                                      letterSpacing: 0.8,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                                  tanggal,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .primary,
                                                    fontSize: 12,
                                                    fontWeight: medium,
                                                    letterSpacing: 0.8,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                                spesialisasi,
                                                style: TextStyle(
                                                  letterSpacing: 0.8,
                                                  fontSize: 12,
                                                  fontWeight: medium,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              Text(
                                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                                ' | ',
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: light,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                              Text(
                                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                                namadokter,
                                                style: TextStyle(
                                                  letterSpacing: 0.8,
                                                  fontSize: 12,
                                                  fontWeight: medium,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Expanded(
                                            child: Text(
                                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                              'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(int.parse(harga))}',
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .onPrimary,
                                                fontSize: 12,
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
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 4,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              '${Endpoint.url}dokter_image/$id_dokter',
                              headers: <String, String>{
                                'accept': 'application/json',
                                'Authorization': 'Bearer $_token',
                              },
                            ),
                            radius: 47.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
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
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: IntrinsicHeight(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                              'No. Antrian Anda:',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: semi,
                                                letterSpacing: 0.8,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                          '5',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 14,
                                            fontWeight: semi,
                                            letterSpacing: 0.8,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Container(
                                      width: 1,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.1,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                              'Antrian Saat Ini:',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: semi,
                                                letterSpacing: 0.8,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                          '2',
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                            fontSize: 14,
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Visibility(
              visible: !_antrianDiambil,
              child: ElevatedButton(
                onPressed: () async {
                  if(mounted){
                    setState(() {
                      _antrianDiambil = !_antrianDiambil;
                    });
                  }
                  await context
                      .read<JanjiTemuProvider>()
                      .alter_status(_token, id);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                  'Ambil Antrian',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 24,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
