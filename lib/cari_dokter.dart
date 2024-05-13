import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/DetailDokter.dart';
import 'package:sehatyuk/providers/doctor_provider.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/providers/endpoint.dart';

class CariDokterPage extends StatefulWidget {
  const CariDokterPage({super.key});

  @override
  State<CariDokterPage> createState() => _CariDokterPageState();
}

class _CariDokterPageState extends State<CariDokterPage> with AppMixin{
  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";

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
  }

  @override
  Widget build(BuildContext context) {
    var doctor = context.watch<DoctorProvider>();

    if(doctor.doctors.isEmpty){
      doctor.fetchData(_token);
    }

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
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Cari dokter dengan spesialisasi yang sesuai dengan keluhan anda',
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
                    suffixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF94B0B7),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    enabledBorder: OutlineInputBorder( // Garis batas ketika TextField tidak dalam keadaan terfokus
                      borderSide: BorderSide(
                        color: Color(0xFF94B0B7),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder( // Garis batas ketika TextField dalam keadaan terfokus
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary, // Menggunakan warna utama tema saat dalam keadaan terfokus
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    hintStyle: TextStyle(
                      fontSize: 10,
                      // fontWeight: FontWeight.w400,
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
                        color: Theme.of(context).colorScheme.primary,
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
                              fontWeight: medium,
                              color: Theme.of(context).colorScheme.primary,
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
                        color: Theme.of(context).colorScheme.primary,
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
                                  Icon(Icons.tune, color: Theme.of(context).colorScheme.primary), // Add tune icon
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
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: doctor.doctors.length,
                      itemBuilder: (context, index) {
                        return DoctorCard(
                          token: _token,
                          id_dokter: doctor.doctors[index].id.toString(),
                          imagePath: doctor.doctors[index].foto,
                          specialty: doctor.doctors[index].spesialis,
                          doctorName: doctor.doctors[index].namaLengkap,
                          experience: '${doctor.doctors[index].pengalaman.toString()} tahun | ${doctor.doctors[index].rating.toString()}',
                          price: doctor.doctors[index].harga.toString(),
                          onPressed: () {
                            // Add your onPressed logic here
                          },
                        );
                      },
                    ),
                    // DoctorCard(
                    //   imagePath: 'assets/images/cariDokterPage/doctor_1.jpg',
                    //   specialty: 'Kulit',
                    //   doctorName: 'Ujang Suherman',
                    //   experience: '2 Tahun  |  5.0',
                    //   price: 'Rp200.000,00',
                    //   onPressed: () {
                    //     Navigator.push(context, MaterialPageRoute(builder: (context) => const DetailDokterPage()));
                    //   },
                    // ),
                    // SizedBox(height: 8), // Berikan jarak antara setiap card view
                    // DoctorCard(
                    //   imagePath: 'assets/images/cariDokterPage/doctor_2.jpeg',
                    //   specialty: 'THT',
                    //   doctorName: 'Farah Septian',
                    //   experience: '3 Tahun  |  4.5',
                    //   price: 'Rp295.000,00',
                    //   onPressed: () {
                    //     // Fungsi untuk menampilkan detail dokter
                    //   },
                    // ),
                    // SizedBox(height: 8), // Berikan jarak antara setiap card view
                    // DoctorCard(
                    //   imagePath: 'assets/images/cariDokterPage/doctor_3.jpeg',
                    //   specialty: 'Mata',
                    //   doctorName: 'Agus Ibrahim',
                    //   experience: '3 Tahun  |  4.7',
                    //   price: 'Rp275.000,00',
                    //   onPressed: () {
                    //     // Fungsi untuk menampilkan detail dokter
                    //   },
                    // ),
                    // SizedBox(height: 8), // Berikan jarak antara setiap card view
                    // DoctorCard(
                    //   imagePath: 'assets/images/cariDokterPage/doctor_4.jpeg',
                    //   specialty: 'Jantung',
                    //   doctorName: 'Amanda Charisma',
                    //   experience: '2 Tahun  |  5.0',
                    //   price: 'Rp300.000,00',
                    //   onPressed: () {
                    //     // Fungsi untuk menampilkan detail dokter
                    //   },
                    // ),
                    // SizedBox(height: 8), // Berikan jarak antara setiap card view
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
  final String token;
  final String id_dokter;
  final String imagePath;
  final String specialty;
  final String doctorName;
  final String experience;
  final String price;
  final VoidCallback onPressed;

  const DoctorCard({
    Key? key,
    required this.token,
    required this.id_dokter,
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
                  image: NetworkImage(
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
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
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
    );
  }
}
