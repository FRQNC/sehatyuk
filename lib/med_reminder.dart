import 'package:flutter/material.dart';
import 'package:sehatyuk/edit_pengingat_minum_obat.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/pilih_obat_untuk_pengingat.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';
import 'package:intl/intl.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/providers/pengingat_minum_obat_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sehatyuk/providers/endpoint.dart';

class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  State<MedicationReminderPage> createState() => _MedicationReminderPageState();
}

class _MedicationReminderPageState extends State<MedicationReminderPage> with AppMixin {

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
    await context.read<PengingatMinumObatProvider>().fetchData(_token, _user_id);
  }

  @override
  Widget build(BuildContext context) {
    var pengingat_minum_obat = context.watch<PengingatMinumObatProvider>();

    if(pengingat_minum_obat.pengingatMinumObatList.isEmpty){
      // pengingat_minum_obat.fetchData(_token);
      pengingat_minum_obat.fetchData(_token, _user_id);
    }
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: sideMargin, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Pengingat Minum Obat",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Jangan lewati obat Anda. Tambahkan pengingat untuk meminum obat.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: pengingat_minum_obat.pengingatMinumObatList.length,
                      itemBuilder: (context, index) {
                        return PengingatMinumObatCard(
                          token: _token,
                          idPengingat: pengingat_minum_obat.pengingatMinumObatList[index].idPengingat.toString(),
                          idUser: pengingat_minum_obat.pengingatMinumObatList[index].idUser.toString(),
                          idObat: pengingat_minum_obat.pengingatMinumObatList[index].idObat.toString(),
                          // fotoObat: pengingat_minum_obat.pengingatMinumObatList[index].fotoObat,
                          // namaObat: pengingat_minum_obat.pengingatMinumObatList[index].namaObat,
                          fotoObat: pengingat_minum_obat.pengingatMinumObatList[index].obat["foto_obat"],
                          namaObat: pengingat_minum_obat.pengingatMinumObatList[index].obat["nama_obat"],
                          dosis: pengingat_minum_obat.pengingatMinumObatList[index].dosis.toString(),
                          sendok: pengingat_minum_obat.pengingatMinumObatList[index].sendok,
                          jadwal: pengingat_minum_obat.pengingatMinumObatList[index].jadwal,
                          aturan: pengingat_minum_obat.pengingatMinumObatList[index].aturan,

                          
                          // onPressed: () {
                          //   Navigator.push(
                          //     context, 
                          //     MaterialPageRoute(builder: (context) => DetailDokterPage(doctor: pengingat_minum_obat.pengingatMinumObatList[index])),
                          //   );

                          //   // Add your onPressed logic here
                          // },
                        );
                      },
                    ),
                  ],
                ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Center(
                          child: PrimaryButton(
                              buttonText: "Tambah",
                              containerWidth: 160,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const PilihObatUntukPengingatPage()));
                              },
                              fontSize: 18),
                        ),
                      )
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

class PengingatMinumObatCard extends StatelessWidget {
  final String token;
  final String idPengingat;
  final String idUser;
  final String idObat;
  final String namaObat;
  final String fotoObat;
  final String dosis;
  final String sendok;
  final String jadwal;
  final String aturan;
  // final VoidCallback onPressed;

  const PengingatMinumObatCard({
    Key? key,
    required this.token,
    required this.idPengingat,
    required this.idUser,
    required this.idObat,
    required this.namaObat,
    required this.fotoObat,
    required this.dosis,
    required this.sendok,
    required this.jadwal,
    required this.aturan,
    // required this.onPressed,
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
              // color: Colors.amber,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    '${Endpoint.url}obat_image/$idObat',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        namaObat,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF37363B),
                        ),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        onPressed: () async {
                          bool deleted = await context.read<PengingatMinumObatProvider>().deleteData(token, idPengingat);

                          // bool deleted = await context.read<JanjiTemuProvider>().deleteData(token, id_janji_temu);
                          if (deleted) {
                            // Jika penghapusan berhasil, lakukan sesuatu, misalnya, tampilkan pesan sukses atau perbarui tampilan
                            print('Pengingat berhasil dihapus');
                          } else {
                            // Jika penghapusan gagal, lakukan sesuatu, misalnya, tampilkan pesan error
                            print('Gagal menghapus pengingat');
                          }
                          // Navigator.of(context).pop(); // 
                          // Tambahkan logika untuk menghapus obat di sini
                        },
                      ),
                    ],
                  ),

                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$dosis $sendok x $jadwal',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF37363B),
                        ),
                      ),
                      // Text(
                      //   sendok,
                      //   style: TextStyle(
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w600,
                      //     color: Color(0XFF37363B),
                      //   ),
                      // ),
                      // Text(
                      //   jadwal,
                      //   style: TextStyle(
                      //     fontSize: 10,
                      //     fontWeight: FontWeight.w600,
                      //     color: Color(0XFF37363B),
                      //   ),
                      // ),
                      // ElevatedButton(
                      //   onPressed: onPressed,
                      //   style: ElevatedButton.styleFrom(
                      //     padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8), // Mengatur padding
                      //     minimumSize: Size(64, 24), // Mengatur ukuran minimum tombol
                      //     textStyle: TextStyle(
                      //       fontSize: 12, // Mengatur ukuran teks
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //     backgroundColor: Theme.of(context).colorScheme.primary,
                      //   ),
                      //   child: Text(
                      //     'Detail',
                      //     style: TextStyle(
                      //       color: Color(0xFFFFFFFF),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Text(
                    aturan,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).colorScheme.primary,
                    ),
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