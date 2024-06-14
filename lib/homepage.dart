import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:sehatyuk/cariobat.dart';
import 'package:sehatyuk/cari_artikel.dart';
import 'package:sehatyuk/daftarresume.dart';
import 'package:sehatyuk/med_reminder.dart';
import 'package:sehatyuk/providers/route_provider.dart';
import 'package:sehatyuk/providers/user_provider.dart';
import 'package:sehatyuk/route.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";
  bool _isInitialized = false;

  UserProvider user = UserProvider();

  Future<void> _fetchToken() async {
    _token = await auth.getToken();
    _user_id = await auth.getId();
    _fetchData();
    setState(() {
      _isInitialized = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchToken();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool? openedFirstTime = prefs.getBool('openedFirstTime');

      if (openedFirstTime == null || openedFirstTime == true) {
        _showPopup();
        await prefs.setBool('openedFirstTime', false);
      }
    });
  }

  Future<void> _fetchData() async{
    user = Provider.of<UserProvider>(context, listen: false);
    await user.fetchData();
  }

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
          content: _isInitialized ? Column(
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
                    "Selamat Datang ${user.userData.namaLengkap}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff4A707A),
                      letterSpacing: 0.8,
                    ),
                    textAlign: TextAlign.start,
                  )),
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
          ) : Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  int _currentIndex = 0;

  final List<String> images = [
    'assets/images/homePage/1.jpg',
    'assets/images/homePage/f1.png',
    'assets/images/homePage/3.jpg',
  ];

  final List<String> fitur1 = [
    'assets/images/homePage/f3.png',
    'assets/images/homePage/f6.png',
    'assets/images/homePage/f2.png',
    'assets/images/homePage/f4.png'
  ];

  final List<String> ft1 = [
    'Buat Janji',
    'Resume Medis',
    'Cari Obat',
    'Pengingat Minum Obat',
  ];

  final List<Widget> pages1 = [
    RoutePage(),
    DaftarResumePage(),
    CariObatPage(),
    MedicationReminderPage(),
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

  final List<String> deskripsi = [
    'Temukan rekomendasi makanan sehat kaya nutrisi untuk puasa kuat dan lancar.',
    'Temukan rekomendasi olahraga agar tubuh tetap bugar.',
    'Jaga kesehatan jantung Anda sejak dini.'
  ];
  final List<String> categories = ['Makanan', 'Gaya Hidup', 'Jantung'];
  int currentPageIndex = 0;

  bool fetched = false;

  @override
  Widget build(BuildContext context) {
    var route = context.watch<RouteProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/homePage/top.png',
              height: 209,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: fitur1.asMap().entries.map((entry) {
                  String image = entry.value;
                  return GestureDetector(
                    onTap: () {
                      if (entry.key == 0) {
                        route.pageIndex = 1;
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages1[entry.key],
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages1[entry.key],
                          ),
                        );
                      }
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ClipOval(
                          child: Image.asset(
                            image,
                            height: MediaQuery.of(context).size.width * 0.15,
                            width: MediaQuery.of(context).size.width * 0.15,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 8),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.25,
                          height: MediaQuery.of(context).size.height * 0.05,
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
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.width * 0.05),
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
            SizedBox(height: MediaQuery.of(context).size.width * 0.1),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CariArtikelPage()),
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
                int index = entry.key;
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
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.asset(
                                imagePath,
                                height: 65,
                                width: 65,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF94B0B7),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Text(
                                      '${categories[index]}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Color(0xFF37363B),
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.05,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    judul[index],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF37363B),
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.08,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    deskripsi[index],
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 15),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Divider(
                          color: Color(0xFFDDDDDA),
                        ),
                      ),
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
