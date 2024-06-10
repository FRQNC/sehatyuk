import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/ResumeMedis.dart';
import 'package:sehatyuk/detail_resume.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/models/rekam_medis.dart';
import 'package:sehatyuk/providers/rekam_medis_provider.dart';
import 'package:sehatyuk/auth/auth.dart';

class DaftarResumePage extends StatefulWidget {
  const DaftarResumePage({Key? key}) : super(key: key);

  @override
  _DaftarResumePageState createState() => _DaftarResumePageState();
}

class _DaftarResumePageState extends State<DaftarResumePage> {
  String _token = "";
  String _userId = "";

  @override
  void initState() {
    super.initState();
    _fetchTokenAndData();
  }

  Future<void> _fetchTokenAndData() async {
    AuthService auth = AuthService();
    _token = await auth.getToken();
    _userId = await auth.getId();

    // Fetch data using the provider
    await Provider.of<RekamMedisProvider>(context, listen: false)
        .fetchRekamMedisByUser(_token, int.parse(_userId));
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
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
      body: Consumer<RekamMedisProvider>(
        builder: (context, rekamMedisProvider, child) {
          if (rekamMedisProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (rekamMedisProvider.rekamMedisList.isEmpty) {
            return Center(child: Text('Tidak ada rekam medis.'));
          }

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Resume Medis Anda',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16.0,
                      color: Color(0xFF4A707A),
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Resume medis anda bisa dilihat disini',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0,
                      color: Color(0xFF37363B),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: 30.0, left: 10.0, right: 10.0, bottom: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color(0xFFF5F5F5),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF94B0B7)),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: 'Cari Resume',
                        labelStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                          color: Color(0xFFC2C8C5),
                        ),
                        suffixIcon:
                            Icon(Icons.search, color: Color(0xFF94B0B7)),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color: Color(0xFF37363B),
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(Icons.tune,
                              color: Theme.of(context).colorScheme.primary),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xFFF5F5F5)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Color(0xFF94B0B7)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: rekamMedisProvider.rekamMedisList.length,
                    itemBuilder: (context, index) {
                      final rekamMedis =
                          rekamMedisProvider.rekamMedisList[index];

                      var nama;
                      if(rekamMedis.janjiTemu["id_janji_temu_as_orang_lain"] != 0){
                        nama = rekamMedis.janjiTemu["janji_temu_as_orang_lain"]["nama_lengkap_orang_lain"];
                      }
                      else{
                        nama = (rekamMedis.janjiTemu["is_relasi"] == 1 ? rekamMedis.janjiTemu["relasi"]["nama_lengkap_relasi"] : rekamMedis.janjiTemu["user"]["nama_lengkap_user"]);
                      }
                      return ListItem(
                        Tanggal:
                            rekamMedis.janjiTemu["tgl_janji_temu"].toString(), 
                        Spesialis:
                            rekamMedis.janjiTemu["dokter"]["spesialisasi_dokter"],// rekamMedis.janjiTemu["spesialisasi_dokter"],
                        Dokter:
                            rekamMedis.janjiTemu["dokter"]["nama_lengkap_dokter"],// rekamMedis.janjiTemu["nama_lengkap_dokter"], 
                        Pasien:
                            nama,// rekamMedis.janjiTemu["nama_lengkap_user"], 
                        Harga:
                            rekamMedis.janjiTemu["biaya_janji_temu"].toString(),// rekamMedis.janjiTemu["biaya_janji_temu"], 
                        Detail:
                            rekamMedis,
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final String Tanggal;
  final String Spesialis;
  final String Dokter;
  final String Pasien;
  final String Harga;
  final RekamMedis Detail;

  ListItem({
    required this.Tanggal,
    required this.Spesialis,
    required this.Dokter,
    required this.Pasien,
    required this.Harga,
    required this.Detail,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 20,
            alignment: Alignment.topCenter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 15,
                  height: 15,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffC2C8C5),
                    border: Border.all(
                      color: Color(0xff4A707A),
                      width: 1,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A),
                ),
                SizedBox(height: 4),
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A),
                ),
                SizedBox(height: 4),
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A),
                ),
                SizedBox(height: 4),
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A),
                ),
                SizedBox(height: 4),
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    Tanggal,
                    style: TextStyle(
                      color: Color(0xff4A707A),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.8,
                      fontSize: 12.0,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  padding: EdgeInsets.all(8.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Spesialis,
                        style: TextStyle(
                          color: Color(0xFF4A707A),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.8,
                          fontSize: 9.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        Dokter,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        Pasien,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10.0,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '').format(int.parse(Harga))}',
                            style: TextStyle(
                              color: Color(0xFF4A707A),
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.8,
                              fontSize: 9.0,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResumeMedisPage(detail: Detail,),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8), // Mengatur padding
                              minimumSize: Size(64, 24), // Mengatur ukuran minimum tombol
                              textStyle: TextStyle(
                                fontSize: 12, // Mengatur ukuran teks
                                fontWeight: FontWeight.w500,
                              ),
                              backgroundColor: Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              'Detail',
                              style: TextStyle(
                                color: Color(0xFFFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
