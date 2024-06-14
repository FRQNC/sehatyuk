import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';

class CariArtikelPage extends StatefulWidget {
  const CariArtikelPage({super.key});

  @override
  State<CariArtikelPage> createState() => _CariArtikelPageState();
}

class _CariArtikelPageState extends State<CariArtikelPage> with AppMixin {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Cari Artikel',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Cari Artikel sesuai dengan kebutuhan Anda',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF37363B),
                  ),
                ),
                SizedBox(height: 32),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Cari Artikel',
                    suffixIcon: Icon(Icons.search,
                        color: Theme.of(context).colorScheme.primary),
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
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 4, horizontal: 16),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 80),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Color(0xFFF5F5F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 8),
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
                                  Spacer(),
                                  Icon(Icons.tune,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primary),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Column(
                      children: articles.asMap().entries.map((entry) {
                        String imagePath = entry.value;
                        int index = entry.key;
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 88,
                                  width: 88,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      imagePath,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.0, vertical: 2.0),
                                          decoration: BoxDecoration(
                                            color: Color(0xFF94B0B7),
                                            borderRadius:
                                                BorderRadius.circular(15),
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
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 0),
                              child: Divider(
                                color: Color(0xFFDDDDDA),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
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
