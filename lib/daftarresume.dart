import 'package:flutter/material.dart';
import 'package:sehatyuk/ResumaMedis.dart';
import 'package:sehatyuk/detail_resume.dart';
import 'package:sehatyuk/homepage.dart';

class DaftarResumePage extends StatelessWidget {
  const DaftarResumePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Resume Medis Anda',
                style: TextStyle(
                  fontFamily: 'Poppins', // Keluarga font
                  fontWeight: FontWeight.w600, // Bobot Semibold
                  fontSize: 16.0,
                  color: Color(0xFF4A707A),
                  letterSpacing: 0.5,
                ),
              ),
              SizedBox(height: 10), // Menambahkan sedikit spasi antar teks
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
                    suffixIcon: Icon(Icons.search, color: Color(0xFF94B0B7)),
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
                      Icon(Icons.tune, color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFF5F5F5)), // Atur warna latar belakang tombol
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Color(0xFF94B0B7)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  ListItem(
                    Tanggal: '10 April 2024',
                    Spesialis: 'THT',
                    Dokter: 'Farah Septian',
                    Pasien: 'Aurora Alsava',
                    Harga: 'Rp295.000,00',
                  ),
                  ListItem(
                    Tanggal: '03 Maret 2024',
                    Spesialis: 'Mata',
                    Dokter: 'Agus Ibrahim',
                    Pasien: 'Rich Brian',
                    Harga: 'Rp275.000,00',
                  ),
                  ListItem(
                    Tanggal: '20 Februari 2024',
                    Spesialis: 'Kulit',
                    Dokter: 'Ujang Suherman',
                    Pasien: 'Anantha Alsava',
                    Harga: 'Rp200.000,00',
                  ),
                ],
              ),
            ],
          ),
        ),
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

  ListItem({
    required this.Tanggal,
    required this.Spesialis,
    required this.Dokter,
    required this.Pasien,
    required this.Harga,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Kontainer kiri
          Container(
            width: 20, // Atur lebar kontainer kiri sesuai kebutuhan
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
                      color: Color(0xff4A707A), // Warna border
                      width: 1, // Lebar border
                    ),
                  ),
                ), // Container bentuk lingkaran
                SizedBox(height: 4), // Spacer antara lingkaran dan karakter "|"
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A), // Warna karakter "|"
                ), // Container karakter "|"
                SizedBox(height: 4), // Spacer antara karakter "|" untuk mendapatkan jarak yang sama
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A), // Warna karakter "|"
                ), // Container karakter "|"
                SizedBox(height: 4), // Spacer antara karakter "|" untuk mendapatkan jarak yang sama
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A), // Warna karakter "|"
                ), // Container karakter "|"
                SizedBox(height: 4), // Spacer antara karakter "|" untuk mendapatkan jarak yang sama
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A), // Warna karakter "|"
                ), // Container karakter "|"
                SizedBox(height: 4), // Spacer antara karakter "|" untuk mendapatkan jarak yang sama
                Container(
                  width: 2,
                  height: 15,
                  color: Color(0xff4A707A), // Warna karakter "|"
                ), // Container karakter "|"// Spacer antara karakter "|" untuk mendapatkan jarak yang sama
              ],
            ),
          ),
          // Kontainer kanan
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.0),
                  child: Text(
                    Tanggal, // Teks sebelum kode
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
                    color: Colors
                        .white, // Atur warna latar belakang sesuai kebutuhan
                    borderRadius: BorderRadius.circular(
                        10), // Atur border radius sesuai kebutuhan
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Spesialis, // Teks yang akan ditampilkan
                        style: TextStyle(
                          color: Color(0xFF4A707A),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.8,
                          fontSize: 9.0,
                        ),
                      ),
                      Text(
                        Dokter, // Menampilkan teks tambahan
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize:
                              12.0, // Sesuaikan ukuran font sesuai kebutuhan
                          letterSpacing: 0.8,
                          color: Color(
                              0xFF37363B), // Sesuaikan warna sesuai kebutuhan
                        ),
                      ),
                      Text(
                        Pasien, // Menampilkan teks tambahan
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize:
                              10.0, // Sesuaikan ukuran font sesuai kebutuhan
                          letterSpacing: 0.8,
                          color: Color(
                              0xFF4A707A), // Sesuaikan warna sesuai kebutuhan
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween, // Ubah menjadi MainAxisAlignment.spaceBetween
                        children: [
                          Text(
                            Harga, // Menampilkan teks tambahan
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize:
                                  8.0, // Sesuaikan ukuran font sesuai kebutuhan
                              letterSpacing: 0.8,
                              color: Color(
                                  0xFF37363B), // Sesuaikan warna sesuai kebutuhan
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Tindakan yang diambil saat tombol ditekan
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(
                                  0xff4A707A), // Ubah warna tombol menjadi hijau
                              padding: EdgeInsets.symmetric(
                                  vertical: 1,
                                  horizontal: 1), // Atur ukuran padding tombol
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    15), // Atur bentuk tombol menjadi bulat
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ResumeMedisPage(),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xff4A707A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              child: Text(
                                "Mulai",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.8,
                                ),
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
