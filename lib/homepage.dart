import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sehatyuk/artikel.dart';
import 'package:sehatyuk/cariobat.dart';
import 'package:sehatyuk/cari_artikel.dart';
import 'package:sehatyuk/daftarresume.dart';
import 'package:sehatyuk/informasiobat.dart';
import 'package:sehatyuk/jadwaltemu.dart';
import 'package:sehatyuk/kosong.dart';
import 'package:sehatyuk/med_reminder.dart';
import 'package:sehatyuk/providers/user_provider.dart';
// import 'package:sehatyuk/jadwaltemu.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:sehatyuk/cari_dokter.dart';
import 'package:sehatyuk/profile_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Panggil method untuk menampilkan pop-up setelah halaman selesai dibangun
      _showPopup();
    });
  }

  // Future<void> _fetchToken() async {
  //   // Fetch the token asynchronously
  //   _token = await auth.getToken();
  //   _user_id = await auth.getId();
  // }

  void _showPopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Color(0xff4A707A),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Selamat Datang Aurora",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4A707A),
                    letterSpacing: 0.8,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Selamat datang di SEHATYUK.\nKami siap membantu anda",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff37363B),
                    letterSpacing: 0.8,
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 200),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
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
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    CariDokterPage(),
    InformasiObatPage(),
    ProfilePage(),
  ];

  final List<String> images = [
    'assets/images/homePage/1.jpg',
    'assets/images/homePage/f1.png',
    'assets/images/homePage/3.jpg',
  ];

  final List<String> fitur1 = [
    'assets/images/homePage/f2.png',
    'assets/images/homePage/f1.png',
    'assets/images/homePage/f3.png',
    'assets/images/homePage/f4.png'
  ];
  final List<String> fitur2 = [
    'assets/images/homePage/f6.png',
    'assets/images/homePage/f5.png',
    'assets/images/homePage/f1.png',
    'assets/images/homePage/f2.png',
  ];

  final List<String> ft1 = [
    'Resume Medis',
    'Cari Dokter',
    'Cari Obat',
    'Pengingat Minum Obat',
  ];
  final List<String> ft2 = [
    'Daftar Temu',
    'Diari Kesehatan',
    'Fitur',
    'Fitur',
  ];

  final List<String> articles = [
    'assets/images/homePage/a1.jpg',
    'assets/images/homePage/a2.jpg',
    'assets/images/homePage/a3.jpg'
  ];

  final List<String> judul = [
    'Makanan Sehat untuk Puasa',
    'Olahraga',
    'Menjaga Kesehatan Jantung'
  ];
  
  final List<String> deskripsi= [
    'Temukan rekomendasi makanan sehat kaya nutrisi untuk puasa kuat dan lancar.',
    'Temukan rekomendasi olahraga agar tubuh tetap bugar.',
    'Jaga kesehatan jantung Anda sejak dini.'
  ];
  final List<String> categories = ['Makanan', 'Gaya Hidup', 'Jantung'];
  
  final List<Widget> pages1 = [
    DaftarResumePage(),
    CariDokterPage(),
    CariObatPage(),
    MedicationReminderPage(),
  ];
  final List<Widget> pages2 = [
    JadwalTemuPage(),
    EmptyPage(),
    EmptyPage(),
    EmptyPage(),
  ];

  int currentPageIndex = 0;

  bool fetched = false;

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserProvider>();

    // if(user.userId == null && !fetched){
    //   user.fetchData();
    //   print(user.userId.toString()+"uuuuuuuuuuuuuuuu");
    //   fetched = true;
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // _pages[currentPageIndex],
            // gambar di atas
            Image.asset(
              'assets/images/homePage/top.png',
              height: 209, // Sesuaikan dengan tinggi gambar yang diinginkan
              width: MediaQuery.of(context)
                  .size
                  .width, // Lebar gambar mengisi layar penuh
              fit: BoxFit
                  .cover, // Menyesuaikan gambar dengan lebar dan tinggi yang telah ditentukan
            ),

            // fitur
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: fitur1.asMap().entries.map((entry) {
                String image = entry.value;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pages1[entry.key],
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            image,
                            height: 65,
                            width: 65,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          width: 88,
                          height: 45,
                          child: Text(
                            ft1[entry.key],
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF37363B),
                              letterSpacing: 0.05,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: fitur2.asMap().entries.map((entry) {
                String image = entry.value;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => pages2[entry.key],
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            image,
                            height: 65,
                            width: 65,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 4),
                        Container(
                          width: 88,
                          height: 45,
                          child: Text(
                            ft2[entry.key],
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF37363B),
                              letterSpacing: 0.05,
                            ),
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.fade,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            // carousel
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: false,
                autoPlay: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: Duration(seconds: 2),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                pauseAutoPlayOnTouch: true,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: images.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: 20),
            // dot di bawah carousel
            AnimatedSmoothIndicator(
              activeIndex: _currentIndex,
              count: images.length,
              effect: WormEffect(
                dotHeight: 10,
                dotWidth: 10,
                spacing: 5,
                dotColor: Colors.grey,
                activeDotColor: Color(0xFF4A707A),
                paintStyle: PaintingStyle.fill,
              ),
            ),

            SizedBox(height: 20),
            // artikel
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 21,
                ),
                Text(
                  'Artikel Kesehatan',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4A707A),
                    letterSpacing: 0.08,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  // Navigasi ke halaman yang dituju
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CariArtikelPage()),
                  );
                },
                child: Text(
                  'Lihat Semua',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF4A707A),
                    letterSpacing: 0.05,
                  ),
                ),
              ),
              SizedBox(
                width: 21,
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Column(
            children: articles.asMap().entries.map((entry) {
              String imagePath = entry.value;
              int index = entry.key; // Ambil indeks gambar saat ini
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(width: 21),
                        Container(
                          height: 88,
                          width: 88,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(
                                5), // Tambahkan borderRadius di dalam BoxDecoration
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                                5), // Untuk memastikan gambar terpotong sesuai dengan borderRadius
                            child: Image.asset(
                              imagePath, // Gunakan imagePath langsung
                              height: 65,
                              width: 65,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                            width:
                                15), // Tambahkan ruang horizontal di antara gambar dan teks
                        Expanded(
                          child: Container(
                            // height: 88,
                            width: double
                                .infinity, // Lebar container mengikuti lebar yang tersedia
                            // color: Colors.amber,
                            padding: EdgeInsets.all(
                                20.0), // Beri padding agar teks terlihat lebih baik
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical:
                                          2.0), // Atur padding untuk kontainer kategori
                                  decoration: BoxDecoration(
                                    color: Color(
                                        0xFF94B0B7), // Warna latar belakang kontainer kategori
                                    borderRadius: BorderRadius.circular(
                                        15), // Atur border radius untuk kontainer kategori
                                  ),
                                  child: Text(
                                    '${categories[index]}',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Color(
                                          0xFF37363B), // Warna teks kategori
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.05,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    height: 4), // Spacer vertikal antara teks
                                Text(
                                  judul[
                                      index], // Mengambil judul dari list berdasarkan index gambar saat ini
                                  style: TextStyle(
                                    fontSize:
                                        13, // Mengatur ukuran teks judul
                                    color: Color(0xFF37363B),
                                    fontWeight: FontWeight
                                        .w600, // Membuat teks judul menjadi tebal
                                    letterSpacing: 0.08,
                                  ),
                                  maxLines:
                                      1, // Hanya menampilkan satu baris untuk judul
                                  overflow: TextOverflow
                                      .ellipsis, // Mengatur overflow jika teks terlalu panjang
                                ),
                                SizedBox(
                                    height: 4), // Spacer vertikal antara teks
                                Text(
                                  deskripsi[index],
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  maxLines:
                                      2, // Hanya menampilkan dua baris untuk deskripsi
                                  overflow: TextOverflow
                                      .ellipsis, // Mengatur overflow jika teks terlalu panjang
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal:
                              20.0), // Atur jarak horizontal dari divider
                      child: Divider(
                        color: Color(0xFFDDDDDA),
                      ), // Tambahkan garis divider di antara setiap item
                    ), // Tambahkan garis divider di antara setiap item
                  ],
                ),
              );
            }).toList(),
          ),
          
          ],
        ),
      ),
    );
  }
}