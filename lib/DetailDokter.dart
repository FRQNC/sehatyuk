import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/janji_orang_lain.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/cari_dokter.dart';
import 'package:sehatyuk/primary_button.dart';

class DetailDokterPage extends StatefulWidget {
  const DetailDokterPage({super.key});

  @override
  State<DetailDokterPage> createState() => _DetailDokterPageState();
}

class _DetailDokterPageState extends State<DetailDokterPage> with AppMixin{
  double boxHeight = 35.0;
  bool? isChecked = false;

  List<String> days = ["Sen", "Sel", "Rab", "Kam", "Jum", "Sab", "Min"];
  int i = 0;

  String? selectedPerson = null;
  List<String> relation = ['Saya sendiri', 'Anantha Alsava', 'Rich Brian', 'Orang lain'];

  List<String> doctorInfo = ['Selulitis', 'Dermatofitosis (kurap)', 'Hiperhidrosis osmidrosis', 'Kelainan rambut', 'Kebotakan dan hipertrikosis', 'Dermatitis atopik'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => CariDokterPage()),
            );
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Text(
            'Ujang Suherman',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: 20,
              fontWeight: semi,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: sideMargin, right: sideMargin, top: 8),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 105,
                  ),
                  Positioned(
                    top: 0,
                    child: Row(
                      children: [
                        SizedBox(width: 60,),
                        Container(
                          width: MediaQuery.of(context).size.width-2*sideMargin-60,
                          height: 105,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: boxColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                            child: Row(
                              children: [
                                SizedBox(width: 40,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width-2*sideMargin-130,
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Ujang Suherman',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onPrimary,
                                                fontSize: 15,
                                                fontWeight: semi,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                          ),
                                          Image(
                                            image: AssetImage('assets/images/detailDokterPage/ri_service-fill.png'),
                                          ),
                                          Text(
                                            ' 2 tahun',
                                            style: TextStyle(
                                              color: Theme.of(context).colorScheme.primary,
                                              fontSize: 12,
                                              fontWeight: medium,
                                              letterSpacing: 0.8,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        'Sp. Kulit',
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.onPrimary,
                                          fontSize: 15,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(Radius.circular(5)),
                                        color: Color(0xFFDDDDDA),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                                        child: Row(
                                          children: [
                                            Text(
                                              '5.0 ',
                                              style: TextStyle(
                                                color: Color(0xFFFFC107),
                                                fontSize: 15,
                                                fontWeight: semi,
                                                letterSpacing: 0.8,
                                              ),
                                            ),
                                            Image(
                                              image: AssetImage('assets/images/detailDokterPage/stars.png'),
                                            ),
                                            Text(
                                              ' 16 ulasan',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.onPrimary,
                                                fontSize: 12,
                                                letterSpacing: 0.5,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/detailDokterPage/doctor_1_crop.jpg'),
                    radius: 47.5
                  ),
                ],
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: boxColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/images/detailDokterPage/map_university.png'),
                                    ),
                                    Text(
                                      ' Alumnus',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: semi,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  Image(
                                    image: AssetImage('assets/images/detailDokterPage/dollar.png'),
                                  ),
                                  Text(
                                    ' Rp200.000,00',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.onPrimary,
                                      fontSize: 14,
                                      fontWeight: semi,
                                      letterSpacing: 0.8,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Universitas Indonesia',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            fontWeight: medium,
                            letterSpacing: 0.8,
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(
                          height: 5,
                          color: dividerColor,
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(8.0, 6.0, 8.0, 6.0),
                                child: Row(
                                  children: [
                                    Image(
                                      image: AssetImage('assets/images/detailDokterPage/yes_no.png'),
                                    ),
                                    Text(
                                      ' Kondisi dan Minat Klinis',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: semi,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        BulletList(
                          doctorInfo, // data string
                          14, // font size
                          medium, // font weight
                          Theme.of(context).colorScheme.onPrimary, // color
                          0.8, // letter spacing
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                width: MediaQuery.of(context).size.width,
                // height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: boxColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                            ),
                            Text(
                              ' Informasi Tambahan',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 14,
                                fontWeight: semi,
                                letterSpacing: 0.8,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'Harga yang tertera hanya tarif awal, belum termasuk dengan biaya peralatan lainnya.',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontSize: 14,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Center(
                child: TextButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierColor: Theme.of(context).colorScheme.secondary.withOpacity(0.5),
                      builder: (context) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AlertDialog(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            insetPadding: EdgeInsets.all(25),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(),
                                      ),
                                      GestureDetector(
                                        onTap: () => Navigator.pop(context),
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    'Pilih Jadwal',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: bold,
                                      fontSize: 21,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: () {
                                            _selectDate();
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context).size.height * 0.1,
                                            child: Image(
                                              image: AssetImage('assets/images/detailDokterPage/calendar_primary.png'),
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: Theme.of(context).colorScheme.onSecondary,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  days[i],
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    fontWeight: semi,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  '01 Feb',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.tertiary,
                                                    fontWeight: medium,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Text(
                                                  '08.00 - 13.00',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                    fontWeight: semi,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Theme.of(context).colorScheme.onSecondary,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  days[i+1],
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    fontWeight: semi,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  '02 Feb',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.tertiary,
                                                    fontWeight: medium,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Text(
                                                  '08.00 - 13.00',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                    fontWeight: semi,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Theme.of(context).colorScheme.onSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  days[i+2],
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    fontWeight: semi,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  '03 Feb',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.tertiary,
                                                    fontWeight: medium,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Text(
                                                  '08.00 - 13.00',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                    fontWeight: semi,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Theme.of(context).colorScheme.onSecondary,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  days[i+3],
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    fontWeight: semi,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  '04 Feb',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.tertiary,
                                                    fontWeight: medium,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Text(
                                                  '08.00 - 13.00',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                    fontWeight: semi,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Theme.of(context).colorScheme.onSecondary,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  days[i+4],
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.primary,
                                                    fontWeight: semi,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  '06 Feb',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.tertiary,
                                                    fontWeight: medium,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                                Expanded(child: Container()),
                                                Text(
                                                  '08.00 - 13.00',
                                                  style: TextStyle(
                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                    fontWeight: semi,
                                                    fontSize: 12,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(Radius.circular(10)),
                                            color: Theme.of(context).colorScheme.onSecondary,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 30,),
                                  Text(
                                    'Buat janji untuk siapa?',
                                    style: TextStyle(
                                      color: Theme.of(context).colorScheme.primary,
                                      fontWeight: bold,
                                      fontSize: 21,
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(left: 12.0, right: 12.0),
                                      fillColor: Colors.white,
                                      filled: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary), // Change the color here
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(color: Theme.of(context).colorScheme.tertiary), // Change the color here
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    hint: Text(
                                      'Pilih',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    value: selectedPerson,
                                    isDense: true,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedPerson = newValue;
                                        print('Selected person: $selectedPerson');
                                      });
                                    },
                                    items: relation.map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Theme.of(context).colorScheme.primary,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    dropdownColor: Colors.white,
                                    elevation: 3,
                                    isExpanded: true,
                                    icon: Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Theme.of(context).colorScheme.primary,
                                    )
                                    // icon: SizedBox.shrink(),
                                  ),
                                  SizedBox(height: 40,),
                                  Center(
                                    child: TextButton(
                                      onPressed: () {
                                        if(selectedPerson == "Orang lain"){
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => const BuatJanjiOtherPage()));
                                        }
                                        else if(selectedPerson != null){
                                          showDialog(
                                            context: context,
                                            builder: (context) => Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                AlertDialog(
                                                  backgroundColor: Colors.white,
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.all(25),
                                                  content: SizedBox(
                                                    width: MediaQuery.of(context).size.width,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Container(),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () => Navigator.pop(context),
                                                              child: Icon(
                                                                Icons.close,
                                                                color: Theme.of(context).colorScheme.primary,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 50.0),
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                "BERHASIL",
                                                                style: TextStyle(
                                                                  color: Theme.of(context).colorScheme.primary,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 25,
                                                                  letterSpacing: 2.0,
                                                                ),
                                                                ),
                                                                SizedBox(
                                                                  width: 175,
                                                                  child: Divider(
                                                                    color: dividerColor,
                                                                    thickness: 3,
                                                                  ),
                                                                )
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 15.0),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 4, bottom: 0),
                                                                child: Text(
                                                                  "Berhasil membuat janji bersama dokter!",
                                                                  style: TextStyle(
                                                                    color: Theme.of(context).colorScheme.onPrimary,
                                                                    fontSize: 14,
                                                                  )
                                                                  ),
                                                              ),
                                                              Divider(
                                                                color: dividerColor,
                                                                thickness: 1,
                                                              ),
                                                              Padding(
                                                                padding: EdgeInsets.only(top: 4, bottom: 0),
                                                                child: Text(
                                                                  "Lekas sembuh",
                                                                  style: TextStyle(
                                                                    color: Theme.of(context).colorScheme.primary,
                                                                    fontSize: 20,
                                                                    fontWeight: semi,
                                                                    letterSpacing: 1.5
                                                                  )
                                                                  ),
                                                              ),
                                                              Divider(
                                                                color: dividerColor,
                                                                thickness: 1,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: const EdgeInsets.only(top: 20.0, bottom:15),
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                children: [
                                                                  PrimaryButton(containerWidth: MediaQuery.of(context).size.width*0.3, onPressed: (){}, buttonText: "Buat Janji", fontSize: 15),
                                                                  PrimaryButton(containerWidth: MediaQuery.of(context).size.width*0.3, onPressed: (){}, buttonText: "Cek Janji", fontSize: 15)
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          );
                                        }
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Theme.of(context).colorScheme.primary,
                                      ),
                                      child: Text(
                                        'Buat Janji',
                                        style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: semi,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Image(
                            image: AssetImage('assets/images/detailDokterPage/wavy_line.png'),
                          ),
                        ],
                      )
                    );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    'Buat Janji',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: semi,
                      color: Colors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime? selectedDate = DateTime.now();

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 7)),
      locale: Locale('id', 'ID'),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xFF4A707A),
              secondary: Color(0xFFC2C8C5),
              tertiary: Color(0xFF94B0B7),
              onPrimary: Color(0xFFDDDDDA), // body text color
              onSecondary: Color(0xFF37363B),
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
}