import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';

class ArtikelPage extends StatefulWidget {
  const ArtikelPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  State<ArtikelPage> createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> with AppMixin{
  
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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
          padding: const EdgeInsets.only(top: 24.0),
          child: Column(
                children: 
                <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Cari Artikel',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              // backgroundColor: Colors,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Cari Artikel dengan spesialisasi yang sesuai dengan keluhan anda',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFF37363B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                      SizedBox(height: 20),
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
                                    height: 88, width: 88,
                                    decoration: BoxDecoration(
                                      color: Colors.black12,
                                      borderRadius: BorderRadius.circular(5), // Tambahkan borderRadius di dalam BoxDecoration
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5), // Untuk memastikan gambar terpotong sesuai dengan borderRadius
                                      child: Image.asset(
                                        imagePath, // Gunakan imagePath langsung
                                        height: 65,
                                        width: 65,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                      width:15), // Tambahkan ruang horizontal di antara gambar dan teks
                                  Expanded(
                                    child: Container(
                                      // height: 88,
                                      width: double.infinity, // Lebar container mengikuti lebar yang tersedia
                                      // color: Colors.amber,
                                      padding: EdgeInsets.all(20.0), // Beri padding agar teks terlihat lebih baik
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 10.0,vertical:2.0), // Atur padding untuk kontainer kategori
                                            decoration: BoxDecoration(
                                              color: Color( 0xFF94B0B7), // Warna latar belakang kontainer kategori
                                              borderRadius: BorderRadius.circular( 15), // Atur border radius untuk kontainer kategori
                                            ),
                                            child: Text(
                                              '${categories[index]}',
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Color(   0xFF37363B), // Warna teks kategori
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
                                              fontSize:13, // Mengatur ukuran teks judul
                                              color: Color(0xFF37363B),
                                              fontWeight: FontWeight.w600, // Membuat teks judul menjadi tebal
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
                ],
          
                //   articles.asMap().entries.map((entry) {
                //   String imagePath = entry.value;
                //   int index = entry.key; // Ambil indeks gambar saat ini
                //   return Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 24.0,),
                //     child: Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.start,
                //           children: [
                //             SizedBox(width: 21),
                //             Container(
                //               height: 88,
                //               width: 88,
                //               decoration: BoxDecoration(
                //                 color: Colors.black12,
                //                 borderRadius: BorderRadius.circular(
                //                     5), // Tambahkan borderRadius di dalam BoxDecoration
                //               ),
                //               child: ClipRRect(
                //                 borderRadius: BorderRadius.circular(
                //                     5), // Untuk memastikan gambar terpotong sesuai dengan borderRadius
                //                 child: Image.asset(
                //                   imagePath, // Gunakan imagePath langsung
                //                   height: 65,
                //                   width: 65,
                //                   fit: BoxFit.cover,
                //                 ),
                //               ),
                //             ),
                //             SizedBox(
                //                 width:
                //                     15), // Tambahkan ruang horizontal di antara gambar dan teks
                //             Expanded(
                //               child: Container(
                //                 // height: 88,
                //                 width: double
                //                     .infinity, // Lebar container mengikuti lebar yang tersedia
                //                 // color: Colors.amber,
                //                 padding: EdgeInsets.all(
                //                     20.0), // Beri padding agar teks terlihat lebih baik
                //                 child: Column(
                //                   crossAxisAlignment: CrossAxisAlignment.start,
                //                   children: [
                //                     Container(
                //                       padding: EdgeInsets.symmetric(
                //                           horizontal: 10.0,
                //                           vertical:
                //                               2.0), // Atur padding untuk kontainer kategori
                //                       decoration: BoxDecoration(
                //                         color: Color(
                //                             0xFF94B0B7), // Warna latar belakang kontainer kategori
                //                         borderRadius: BorderRadius.circular(
                //                             15), // Atur border radius untuk kontainer kategori
                //                       ),
                //                       child: Text(
                //                         '${categories[index]}',
                //                         textAlign: TextAlign.left,
                //                         style: TextStyle(
                //                           fontSize: 12,
                //                           color: Color(
                //                               0xFF37363B), // Warna teks kategori
                //                           fontWeight: FontWeight.w500,
                //                           letterSpacing: 0.05,
                //                         ),
                //                       ),
                //                     ),
                //                     SizedBox(
                //                         height: 4), // Spacer vertikal antara teks
                //                     Text(
                //                       judul[
                //                           index], // Mengambil judul dari list berdasarkan index gambar saat ini
                //                       style: TextStyle(
                //                         fontSize:
                //                             13, // Mengatur ukuran teks judul
                //                         color: Color(0xFF37363B),
                //                         fontWeight: FontWeight
                //                             .w600, // Membuat teks judul menjadi tebal
                //                         letterSpacing: 0.08,
                //                       ),
                //                       maxLines:
                //                           1, // Hanya menampilkan satu baris untuk judul
                //                       overflow: TextOverflow
                //                           .ellipsis, // Mengatur overflow jika teks terlalu panjang
                //                     ),
                //                     SizedBox(
                //                         height: 4), // Spacer vertikal antara teks
                //                     Text(
                //                       deskripsi[index],
                //                       style: TextStyle(
                //                         fontSize: 12,
                //                       ),
                //                       maxLines:
                //                           2, // Hanya menampilkan dua baris untuk deskripsi
                //                       overflow: TextOverflow
                //                           .ellipsis, // Mengatur overflow jika teks terlalu panjang
                //                     ),
                //                   ],
                //                 ),
                //               ),
                //             ),
                //             SizedBox(width: 15),
                //           ],
                //         ),
          
                //         Padding(
                //           padding: const EdgeInsets.symmetric(
                //               horizontal:
                //                   20.0), // Atur jarak horizontal dari divider
                //           child: Divider(
                //             color: Color(0xFFDDDDDA),
                //           ), // Tambahkan garis divider di antara setiap item
                //         ), // Tambahkan garis divider di antara setiap item
                //       ],
                //     ),
                //   );
                // }).toList(),
              ),
        ),
      )
      //  This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
