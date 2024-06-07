import 'package:flutter/material.dart';
import 'package:sehatyuk/edit_pengingat_minum_obat.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/pilih_obat_untuk_pengingat.dart';
import 'package:sehatyuk/primary_button.dart';
import 'package:intl/intl.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/providers/pengingat_minum_obat_provider.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    var pengingat_minum_obat = context.watch<PengingatMinumObatProvider>();

    if(pengingat_minum_obat.pengingatMinumObatList.isEmpty){
      pengingat_minum_obat.fetchData(_token);
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
                      Container(
                        constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height * 0.65),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextButton(
                            onPressed: () {},
                            child: Text(
                              "Lihat Semua",
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.primary,
                              ),
                            )),

                            
                          ],
                        ),
                      )
                    ],
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
                          id_pengingat: pengingat_minum_obat.pengingatMinumObatList[index].idPengingat.toString(),
                          // fotoObat: pengingat_minum_obat.pengingatMinumObatList[index].fotoObat,
                          // namaObat: pengingat_minum_obat.pengingatMinumObatList[index].namaObat,
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
  final String id_pengingat;
  // final String namaObat;
  // final String fotoObat;
  final String dosis;
  final String sendok;
  final String jadwal;
  final String aturan;
  // final VoidCallback onPressed;

  const PengingatMinumObatCard({
    Key? key,
    required this.token,
    required this.id_pengingat,
    // required this.namaObat,
    // required this.fotoObat,
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
              color: Colors.amber,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(8.0),
              //   image: DecorationImage(
              //     image: CachedNetworkImageProvider(
              //       '${Endpoint.url}dokter_image/$id_dokter',
              //       headers: <String, String>{
              //         'accept': 'application/json',
              //         'Authorization': 'Bearer $token',
              //       },
                    
              //     ),
              //     fit: BoxFit.cover,
              //   ),
              // ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   specialty,
                  //   style: TextStyle(
                  //     fontSize: 10,
                  //     fontWeight: FontWeight.w500,
                  //     color: Color(0xFF94B0B7),
                  //   ),
                  // ),
                  // Text(
                  //   namaObat,
                  //   style: TextStyle(
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w600,
                  //     color: Color(0XFF37363B),
                  //   ),
                  // ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        dosis.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF37363B),
                        ),
                      ),
                      Text(
                        sendok,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF37363B),
                        ),
                      ),
                      Text(
                        jadwal,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: Color(0XFF37363B),
                        ),
                      ),
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
                  Text(
                    aturan,
                    style: TextStyle(
                      fontSize: 10,
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