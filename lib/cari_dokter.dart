import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CariDokterPage extends StatefulWidget {
  const CariDokterPage({super.key});

  @override
  State<CariDokterPage> createState() => _CariDokterPageState();
}

class _CariDokterPageState extends State<CariDokterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {},
          color: Color(0xFF4A707A),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Cari Dokter',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A707A),
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF37363B),
                  ),
                ),
                SizedBox(height: 32),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Dokter',
                    suffixIcon: Icon(Icons.search, color: Color(0xFF4A707A)),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF94B0B7),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    hintStyle: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFFC2C8C5),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spesialisasi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A707A),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end, // Align to the end (right)
                      children: [
                        TextButton(
                          onPressed: () {
                            // Tambahkan fungsi untuk menangani ketika tombol ditekan di sini
                          },
                          child: Text(
                            'Lihat Semua',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF4A707A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/tht.png', text: 'THT'),
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/jantung.png', text: 'Jantung'),
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/kulit.png', text: 'Kulit'),
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/mata.png', text: 'Mata'),
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/tulang.png', text: 'Tulang'),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dokter',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4A707A),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 80), // Set maximum width for the button
                          child: ElevatedButton(
                            onPressed: () {
                              // Tambahkan fungsi untuk menangani ketika tombol "Filter" ditekan di sini
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero, backgroundColor: Color(0xFFF5F5F5), // Set background color to F5F5F5
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              child: Row(
                                children: [
                                  Text(
                                    'Filter',
                                    style: TextStyle(
                                      fontSize: 10,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xFF37363B),
                                    ),
                                  ),
                                  Spacer(), // Spacer untuk menjaga jarak antara teks dan ikon
                                  Icon(Icons.tune, color: Color(0xFF4A707A)), // Add tune icon
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Column(
                  children: [
                    DoctorCard(
                      imagePath: 'assets/images/cariDokterPage/kucing1.png',
                      specialty: 'THT',
                      doctorName: 'Haru Imut',
                      experience: '5 Tahun  |  Rating',
                      price: 'Rpxxx.xxx,00',
                      onPressed: () {
                        // Fungsi untuk menampilkan detail dokter
                      },
                    ),
                    SizedBox(height: 8), // Berikan jarak antara setiap card view
                    DoctorCard(
                      imagePath: 'assets/images/cariDokterPage/kucing2.png',
                      specialty: 'Kulit',
                      doctorName: 'Haru Cantik',
                      experience: '3 Tahun  |  Rating',
                      price: 'Rpxxx.xxx,00',
                      onPressed: () {
                        // Fungsi untuk menampilkan detail dokter
                      },
                    ),
                    SizedBox(height: 8), // Berikan jarak antara setiap card view
                    DoctorCard(
                      imagePath: 'assets/images/cariDokterPage/kucing3.png',
                      specialty: 'Mata',
                      doctorName: 'Haru Ganteng',
                      experience: '1 Tahun  |  Rating',
                      price: 'Rpxxx.xxx,00',
                      onPressed: () {
                        // Fungsi untuk menampilkan detail dokter
                      },
                    ),
                    SizedBox(height: 8), // Berikan jarak antara setiap card view
                    DoctorCard(
                      imagePath: 'assets/images/cariDokterPage/kucing4.png',
                      specialty: 'Jantung',
                      doctorName: 'Haru Gemoy',
                      experience: '2 Tahun  |  Rating',
                      price: 'Rpxxx.xxx,00',
                      onPressed: () {
                        // Fungsi untuk menampilkan detail dokter
                      },
                    ),
                    SizedBox(height: 8), // Berikan jarak antara setiap card view
                    // Tambahkan card view ke bawahnya di sini sesuai kebutuhan
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class DoctorSpecialtyItem extends StatelessWidget {
  final String imagePath;
  final String text;

  const DoctorSpecialtyItem({
    Key? key,
    required this.imagePath,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Tambahkan logika ketika item ditekan di sini
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: Column(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 8,
                fontWeight: FontWeight.w500,
                color: Color(0xFF37363B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorCard extends StatelessWidget {
  final String imagePath;
  final String specialty;
  final String doctorName;
  final String experience;
  final String price;
  final VoidCallback onPressed;

  const DoctorCard({
    Key? key,
    required this.imagePath,
    required this.specialty,
    required this.doctorName,
    required this.experience,
    required this.price,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 245, 245, 245),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    specialty,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF94B0B7),
                    ),
                  ),
                  Text(
                    doctorName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0XFF37363B),
                    ),
                  ),
                  Text(
                    experience,
                    style: TextStyle(
                      fontSize: 8,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4A707A),
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        price,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF37363B),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: onPressed,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8), // Mengatur padding
                          minimumSize: Size(64, 32), // Mengatur ukuran minimum tombol
                          textStyle: TextStyle(
                            fontSize: 8, // Mengatur ukuran teks
                            fontWeight: FontWeight.w500,
                          ),
                          backgroundColor: Color(0xFF4A707A),
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
    );
  }
}
