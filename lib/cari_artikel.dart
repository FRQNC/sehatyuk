import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/DetailDokter.dart';

class CariArtikelPage extends StatefulWidget {
  const CariArtikelPage({super.key});

  @override
  State<CariArtikelPage> createState() => _CariArtikelPageState();
}

class _CariArtikelPageState extends State<CariArtikelPage> with AppMixin{
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
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 88, width: 88, // ganti jadi responsif
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(5), // Untuk memastikan gambar terpotong sesuai dengan borderRadius
                                    child: Image.asset(
                                      imagePath, // Gunakan imagePath langsung
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
                              ],
                            ),
                                  
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal:
                                      0), // Atur jarak horizontal dari divider
                              child: Divider(
                                color: Color(0xFFDDDDDA),
                              ), // Tambahkan garis divider di antara setiap item
                            ), // Tambahkan garis divider di antara setiap item
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
