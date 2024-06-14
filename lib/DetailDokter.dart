import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sehatyuk/janji_orang_lain.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/cari_dokter.dart';
import 'package:sehatyuk/models/janji_temu.dart';
import 'package:sehatyuk/models/relasi.dart';
import 'package:sehatyuk/providers/relasi_provider.dart';
import 'package:sehatyuk/providers/route_provider.dart';
import 'package:sehatyuk/route.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';

import 'package:sehatyuk/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/providers/doctor_provider.dart';
import 'package:sehatyuk/models/doctor.dart';
import 'package:sehatyuk/providers/janji_temu_provider.dart';

class DetailDokterPage extends StatefulWidget {
  final Doctor doctor;

  const DetailDokterPage({Key? key, required this.doctor}) : super(key: key);

  @override
  State<DetailDokterPage> createState() => _DetailDokterPageState();
}

class _DetailDokterPageState extends State<DetailDokterPage> with AppMixin {
  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _fetchToken();
    minatKlinis = widget.doctor.minatKlinis.split(";").toList();
  }

  Future<void> _fetchToken() async {
    _token = await auth.getToken();
    _user_id = await auth.getId();
    await context.read<RelasiProvider>().fetchData(_user_id, _token);
    await context
        .read<DoctorProvider>()
        .fetchDataJadwal(_token, widget.doctor.id.toString());
    setState(() {
      _isInitialized = true;
    });
  }

  double boxHeight = 35.0;
  bool? isChecked = false;
  bool fetched = false;
  bool _isLoading = false;

  List<String> days = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"];
  int i = 0;

  String? selectedPerson = null;
  List<String> relation = ['Saya sendiri', 'Orang lain'];
  Map<String, String> relationVal = {'Saya sendiri': '0', 'Orang lain': '-1'};

  List<String> minatKlinis = [];
  int id_dokter_before = 0;

  DateTime? selectedDate = DateTime.now();

  JanjiTemuProvider janji = JanjiTemuProvider();
  Random _random = Random();

  Future<bool> createJanjiTemu(int selectedPerson) async {
    String tgl = selectedDate.toString();
    int id_dokter = widget.doctor.id;
    int id_user = int.parse(_user_id);
    int is_relasi = (selectedPerson == 0 ? 0 : 1);
    int id_relasi = selectedPerson;
    int biaya = widget.doctor.harga;
    String kode = "SYS" + (_random.nextInt(1000000) + 100000).toString();

    JanjiTemu newJanji = JanjiTemu(
      kodeJanjiTemu: kode,
      tanggalJanjiTemu: tgl,
      idDokter: id_dokter,
      idUser: id_user,
      isRelasi: is_relasi,
      idRelasi: id_relasi,
      biaya: biaya,
      idOrangLain: 0,
      dokter: {},
      user: {},
      relasi: {},
      janjiOrangLain: {},
      status: "Menunggu Ambil Antrian",
    );

    return await janji.createJanjiTemu(_token, newJanji);
  }

  void _fillRelasiList(List<Relasi> relasi) {
    List<String> relasiNames = relasi.map((rel) => rel.namaLengkap).toList();

    relation.insertAll(1, relasiNames);

    for (var item in relasi) {
      relationVal[item.namaLengkap] = item.id_relasi.toString();
    }
  }

  int selected = -1;

  @override
  Widget build(BuildContext context) {
    var value = context.watch<DoctorProvider>();
    List<Relasi> relasi = context.watch<RelasiProvider>().relasiList;

    if (!fetched) {
      _fillRelasiList(relasi);
      if (!relasi.isEmpty) fetched = true;
    }

    final remainingJadwal = value.jadwal_dokter.toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => CariDokterPage()),
            );
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            widget.doctor.namaLengkap,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: semi,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      body: _isInitialized
          ? SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: sideMargin, right: sideMargin, top: 8),
                child: Column(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height * 0.15,
                      ),
                      decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: boxColor,
                          ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              '${Endpoint.url}dokter_image/${widget.doctor.id}',
                              headers: <String, String>{
                                'accept': 'application/json',
                                'Authorization': 'Bearer $_token',
                              },
                            ),
                            radius: MediaQuery.of(context).size.height * 0.054),
                            ),
                          Expanded(
                            flex: 7,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width - 2 * sideMargin - 130,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  widget.doctor.namaLengkap,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                    fontSize: 15,
                                                    fontWeight: semi,
                                                    letterSpacing: 0.8,
                                                  ),
                                                  textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                                ),
                                              ),
                                              Image(
                                                image: AssetImage(
                                                    'assets/images/detailDokterPage/ri_service-fill.png'),
                                              ),
                                              Text(
                                                " ${widget.doctor.pengalaman} tahun",
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontSize: 12,
                                                  fontWeight: medium,
                                                  letterSpacing: 0.8,
                                                ),
                                                textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text(
                                            widget.doctor.spesialis,
                                            style: TextStyle(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onPrimary,
                                              fontSize: 15,
                                              letterSpacing: 0.8,
                                            ),
                                          textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                              color: Color(0xFFDDDDDA),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "${widget.doctor.rating} ",
                                                    style: TextStyle(
                                                      color: Color(0xFFFFC107),
                                                      fontSize: 15,
                                                      fontWeight: semi,
                                                      letterSpacing: 0.8,
                                                    ),
                                                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                                  ),
                                                  Image(
                                                    image: AssetImage(
                                                        'assets/images/detailDokterPage/stars.png'),
                                                  ),
                                                  Text(
                                                    ' 16 ulasan',
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                      fontSize: 12,
                                                      letterSpacing: 0.5,
                                                    ),
                                                    textScaler: TextScaler.linear(ScaleSize.textScaleFactor(context)),
                                                  ),
                                                ],
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8.0, right: 8.0),
                                      child: Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/detailDokterPage/map_university.png'),
                                          ),
                                          Text(
                                            ' Alumnus',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: semi,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Image(
                                        image: AssetImage(
                                            'assets/images/detailDokterPage/dollar.png'),
                                      ),
                                      Text(
                                        'Rp ${NumberFormat.currency(locale: 'id_ID', symbol: '').format(widget.doctor.harga)}',
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 14,
                                          fontWeight: semi,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.doctor.alumnus,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
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
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          8.0, 6.0, 8.0, 6.0),
                                      child: Row(
                                        children: [
                                          Image(
                                            image: AssetImage(
                                                'assets/images/detailDokterPage/yes_no.png'),
                                          ),
                                          Text(
                                            ' Kondisi dan Minat Klinis',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: semi,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              BulletList(
                                minatKlinis,
                                14,
                                medium,
                                Theme.of(context).colorScheme.onPrimary,
                                0.8,
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
                              Row(
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                  ),
                                  Text(
                                    ' Informasi Tambahan',
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontSize: 14,
                                      fontWeight: semi,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                'Harga yang tertera hanya tarif awal, belum termasuk dengan biaya peralatan lainnya.',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 14,
                                  letterSpacing: 0.8,
                                ),
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
                        onPressed: () {
                          _showDialogJanji(remainingJadwal);
                        },
                        style: TextButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(
                          'Buat Janji',
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
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  _showDialogJanji(remainingJadwal) {
    var janjiTemuProvider =
        Provider.of<JanjiTemuProvider>(context, listen: false);
    return showDialog(
        context: context,
        barrierColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
        builder: (context) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    insetPadding: EdgeInsets.all(25),
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Pilih Jadwal',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: bold,
                              fontSize: 21,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            constraints: BoxConstraints(
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.3),
                            child: remainingJadwal.length > 0 ? ListView(
                              children: [
                                GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: remainingJadwal.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    childAspectRatio: 1.8,
                                  ),
                                  itemBuilder: (context, index) {
                                    String day = DateFormat('EEEE', 'id')
                                        .format(remainingJadwal[index]
                                            .tanggalJadwalDokter);
                                    String date =
                                        DateFormat('dd MMMM yyyy', 'id').format(
                                            remainingJadwal[index]
                                                .tanggalJadwalDokter);
                                    String start =
                                        remainingJadwal[index].startTime;
                                    String end = remainingJadwal[index].endTime;
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selected = index;
                                          selectedDate = remainingJadwal[index]
                                              .tanggalJadwalDokter;
                                        });
                                      },
                                      child: Container(
                                        constraints: BoxConstraints(
                                            minHeight: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.1),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onSecondary,
                                          border: Border.all(
                                            color: selected == index
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                : Colors.transparent,
                                            width: 2,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              8.0), //if i remove this, it wont overflow
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                day,
                                                style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 14,
                                                ),
                                              ),
                                              Flexible(
                                                child: Text(
                                                  date,
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .tertiary,
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                              // Expanded(child: Container(color: Colors.blue,)),
                                              Flexible(
                                                child: Text(
                                                  '$start - $end',
                                                  style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onPrimary,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ) : Center(child: Text("Tidak ada jadwal yang tersedia")),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Buat janji untuk siapa?',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: bold,
                              fontSize: 21,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropdownButtonFormField(
                              decoration: InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(left: 12.0, right: 12.0),
                                fillColor: Colors.white,
                                filled: true,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              hint: Text(
                                'Pilih',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              value: selectedPerson,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedPerson = newValue;
                                  print('Selected person: $selectedPerson');
                                });
                              },
                              items: relation.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: relationVal[value],
                                  child: Text(
                                    value,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                );
                              }).toList(),
                              dropdownColor: Colors.white,
                              elevation: 3,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Theme.of(context).colorScheme.primary,
                              )),
                          SizedBox(
                            height: 40,
                          ),
                          Center(
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : TextButton(
                                    onPressed: () async {
                                      if (selected != -1) {
                                        if (selectedPerson == "-1") {
                                          if (selectedPerson != null) {
                                            Navigator.pop(context);
                                            final response =
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            BuatJanjiOtherPage(
                                                              doctor:
                                                                  widget.doctor,
                                                              selectedDate:
                                                                  selectedDate,
                                                            )));

                                            if (response != null) {
                                              _showDialogJanji(remainingJadwal);
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text('Pilih Tanggal!'),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                          }
                                        } else {
                                          if (selectedPerson != null) {
                                            int selectedPersonValue =
                                                int.tryParse(selectedPerson ??
                                                        "0") ??
                                                    0;
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            bool isSucceed =
                                                await createJanjiTemu(
                                                    selectedPersonValue);
                                            setState(() {
                                              _isLoading = false;
                                            });
                                            if (isSucceed) {
                                              Navigator.pop(context);
                                              _showDialogBerhasil(
                                                  remainingJadwal);
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                      'Pilih Buat Janji Untuk Siapa!'),
                                                  duration:
                                                      Duration(seconds: 1),
                                                ),
                                              );
                                            }
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    'Pilih Buat Janji Untuk Siapa!'),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                          }
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('Pilih Tanggal!'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      }
                                    },
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          Theme.of(context).colorScheme.primary,
                                    ),
                                    child: Text(
                                      'Buat Janji',
                                      style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: semi,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                Image(
                  image: AssetImage(
                      'assets/images/detailDokterPage/wavy_line.png'),
                ),
              ],
            ));
  }

  _showDialogBerhasil(remainingJadwal) {
    var route = context.read<RouteProvider>();

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
                                        Navigator.pop(context);
                                        _showDialogJanji(remainingJadwal);
                                      },
                                      buttonText: "Buat Janji",
                                      fontSize: 15),
                                  PrimaryButton(
                                      containerWidth:
                                          MediaQuery.of(context).size.width *
                                              0.3,
                                      onPressed: () {
                                        route.pageIndex = 2;
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const RoutePage()));
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
              onPrimary: Color(0xFFDDDDDA),
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
