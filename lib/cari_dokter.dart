import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/DetailDokter.dart';
import 'package:sehatyuk/providers/doctor_provider.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:cached_network_image/cached_network_image.dart';

class CariDokterPage extends StatefulWidget {
  const CariDokterPage({Key? key}) : super(key: key);

  @override
  State<CariDokterPage> createState() => _CariDokterPageState();
}

class _CariDokterPageState extends State<CariDokterPage> {
  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";
  String searchQuery = "";
  String selectedSpecialty = "";

  TextEditingController searchController = TextEditingController();

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
    await context.read<DoctorProvider>().fetchData(_token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var doctor = context.watch<DoctorProvider>();

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   leading: GestureDetector(
      //     onTap: (){
      //       Navigator.pop(
      //         context,
      //         MaterialPageRoute(builder: (context) => HomePage()),
      //       );
      //     },
      //     child: Icon(
      //       Icons.arrow_back_rounded,
      //       color: Theme.of(context).colorScheme.primary,
      //     ),
      //   ),
      // ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 32),
                Text(
                  'Cari Dokter',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Cari dokter dengan spesialisasi yang sesuai dengan keluhan anda',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF37363B),
                  ),
                ),
                SizedBox(height: 32),
                TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
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
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF94B0B7),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    hintStyle: TextStyle(
                      fontSize: 10,
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
                            setState(() {
                              selectedSpecialty = "";
                            });
                          },
                          child: Text(
                            'Lihat Semua',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
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
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/tht.png', text: 'THT', onTap: () {
                        setState(() {
                          selectedSpecialty = 'Sp. THT';
                        });
                      }),
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/jantung.png', text: 'Jantung', onTap: () {
                        setState(() {
                          selectedSpecialty = 'Sp. Jantung';
                        });
                      }),
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/kulit.png', text: 'Kulit', onTap: () {
                        setState(() {
                          selectedSpecialty = 'Sp. Kulit';
                        });
                      }),
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/mata.png', text: 'Mata', onTap: () {
                        setState(() {
                          selectedSpecialty = 'Sp. Mata';
                        });
                      }),
                      DoctorSpecialtyItem(imagePath: 'assets/images/cariDokterPage/tulang.png', text: 'Tulang', onTap: () {
                        setState(() {
                          selectedSpecialty = 'Sp. Tulang';
                        });
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                // Tampilkan daftar dokter sesuai dengan hasil pencarian
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
                    SizedBox(height: 8),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: doctor.doctors.length,
                      itemBuilder: (context, index) {
                        var currentDoctor = doctor.doctors[index];
                        if (searchQuery.isNotEmpty &&
                            !currentDoctor.namaLengkap.toLowerCase().contains(searchQuery.toLowerCase())) {
                          return Container(); // Jika tidak cocok dengan pencarian, kembalikan widget kosong
                        }
                        if (selectedSpecialty.isNotEmpty && currentDoctor.spesialis != selectedSpecialty) {
                          return Container(); // Jika tidak cocok dengan spesialisasi, kembalikan widget kosong
                        }
                        return DoctorCard(
                          token: _token,
                          id_dokter: currentDoctor.id.toString(),
                          imagePath: currentDoctor.foto,
                          specialty: currentDoctor.spesialis,
                          doctorName: currentDoctor.namaLengkap,
                          experience: '${currentDoctor.pengalaman.toString()} tahun | ${currentDoctor.rating.toString()}',
                          price: currentDoctor.harga.toString(),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => DetailDokterPage(doctor: currentDoctor)),
                            );
                          },
                        );
                      },
                    ),
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
  final VoidCallback onTap;

  const DoctorSpecialtyItem({
    Key? key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
                        'Rp${NumberFormat.currency(locale: 'id_ID', symbol: '').format(int.parse(price))}',
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
