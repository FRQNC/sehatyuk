import 'package:flutter/material.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';

class InformasiObatPage extends StatefulWidget {
  const InformasiObatPage({super.key});

  @override
  State<InformasiObatPage> createState() => _InformasiObatPageState();
}

class _InformasiObatPageState extends State<InformasiObatPage> with AppMixin {
  double boxHeight = 35.0;
  bool? isChecked = false;

  void alterChecked(bool? newBool){
    setState(() {
      isChecked = newBool;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // Implementasi tampilan halaman informasi obat
    var scaffold = Scaffold(
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
        title: Text(
          'Informasi Obat',
          style: TextStyle(
            fontWeight: semi,
            fontSize: 16,
            color: Theme.of(context).colorScheme.primary,
            letterSpacing: 0.8,
          ),
          ),
        // backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // foto
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width * 0.4,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(31, 0, 0, 0),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.asset(
                      'assets/images/detailObatPage/obat1.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // nama obat
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 20), // padding container
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.37),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(15), // padding text
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Paracetamol',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: semi,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Untuk meredakan demam, sakit kepala, nyeri otot, dan sakit gigi.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: medium,
                      letterSpacing: 0.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          // informasi tambahan
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40, top: 20), // padding container
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.37),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(15), // padding text
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Komposisi',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: semi,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Setiap tablet mengandung Paracetamol 500mg..',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: medium,
                      letterSpacing: 0.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1, left: 1, top: 10, bottom: 10),
                    child: Divider(
                      color: Theme.of(context).colorScheme.primaryContainer, // Atur warna divider sesuai keinginan Anda
                      thickness: 1, // Atur ketebalan divider sesuai keinginan Anda
                    ),
                  ),
                  Text(
                    'Dosis',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: semi,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Dewasa 2-3 tablet sehari. Anak-anak 1 tablet sehari',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: medium,
                      letterSpacing: 0.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1, left: 1, top: 10, bottom: 10),
                    child: Divider(
                      color: Theme.of(context).colorScheme.primaryContainer, // Atur warna divider sesuai keinginan Anda
                      thickness: 1, // Atur ketebalan divider sesuai keinginan Anda
                    ),
                  ),
                  Text(
                    'Perhatian',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: semi,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Hati-hati penggunaan pada pasien dengan gagal ginjal, gangguan fungsi hati, dan alergi atau mengalami hipersensitivitas terhadap paracetamol. Kategori kehamilan : Kategori B: Mungkin dapat digunakan oleh wanita hamil. Penelitian pada hewan uji tidak memperlihatkan ada nya risiko terhadap janin, namun belum ada bukti penelitian langsung terhadap wanita hamil.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: medium,
                      letterSpacing: 0.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 1, left: 1, top: 10, bottom: 10),
                    child: Divider(
                      color: Theme.of(context).colorScheme.primaryContainer, // Atur warna divider sesuai keinginan Anda
                      thickness: 1, // Atur ketebalan divider sesuai keinginan Anda
                    ),
                  ),
                  Text(
                    'Efek Samping',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: semi,
                      color: Theme.of(context).colorScheme.primary,
                      letterSpacing: 0.5,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Pemakaian obat umumnya memiliki efek samping tertentu dan sesuai dengan masing-masing individu. Jika terjadi efek samping yang berlebih dan berbahaya, harap konsultasikan kepada tenaga medis. Efek samping yang mungkin terjadi dalam penggunaan obat adalah: - Penggunaan untuk jangka waktu lama dan dosis besar dapat menyebabkan kerusakan fungsi hati. - Reaksi hipersensitifitas/ alergi.',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: medium,
                      letterSpacing: 0.5,
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                    textAlign: TextAlign.start,
                    maxLines: 10,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50,)
        ],
      ),
    ),


    );
    return scaffold;
  }
}
