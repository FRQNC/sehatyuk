import 'package:flutter/material.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/primary_button.dart';

class MedicationInfo {
  String medicationName,
      medicationType,
      medicationDescription,
      medicationImagePath;
  MedicationInfo(
      {required this.medicationName,
      required this.medicationType,
      required this.medicationDescription,
      required this.medicationImagePath});
}

class MedicationReminderPage extends StatefulWidget {
  const MedicationReminderPage({super.key});

  @override
  State<MedicationReminderPage> createState() => _MedicationReminderPageState();
}

class _MedicationReminderPageState extends State<MedicationReminderPage> with AppMixin {

  List<MedicationInfo> medItem = [
    MedicationInfo(medicationName: "Paracetamol",medicationType: "Kapsul",medicationDescription: "Lorem ipsum", medicationImagePath: 'assets/images/medReminderPage/paracetamol.png'),
    MedicationInfo(medicationName: "Ibuprofen",medicationType: "Tablet",medicationDescription: "Lorem ipsum", medicationImagePath: 'assets/images/medReminderPage/ibuprofen.png'),
    MedicationInfo(medicationName: "Amoxicillin",medicationType: "Sirup",medicationDescription: "Lorem ipsum", medicationImagePath: 'assets/images/medReminderPage/amoxicillin.png'),
    MedicationInfo(medicationName: "Omeprazole",medicationType: "Sirup",medicationDescription: "Lorem ipsum", medicationImagePath: 'assets/images/medReminderPage/omeprazole.png'),
  ];

  @override
  Widget build(BuildContext context) {
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
                        "Lorem Ipsum",
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
                            //Med item card
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: medItem.length,
                              itemBuilder: (context, index){
                                return medicationReminderItemView(medItem[index]);
                              }
                            )
                          ],
                        ),
                      )
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
                              onPressed: () {},
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

  Column medicationReminderItemView(MedicationInfo medInfo) {
    return Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                height: 140,
                                padding: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 4,
                                      offset: Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 3,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Image.asset(
                                                medInfo.medicationImagePath,
                                                width: 70,
                                                height: 70,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    medInfo.medicationName,
                                                    style: TextStyle(
                                                        color: Theme.of(context).colorScheme.onPrimary,
                                                        fontSize: 18.0,
                                                        fontWeight:FontWeight.w600,
                                                        letterSpacing: 1.9),
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    medInfo.medicationType,
                                                    style: const TextStyle(
                                                        color: Color(
                                                            0xFF94B0B7),
                                                        fontSize: 12.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        letterSpacing: 1.9),
                                                    overflow: TextOverflow
                                                        .ellipsis,
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(top:8.0),
                                                    child: Text(
                                                      medInfo.medicationDescription,
                                                      style: TextStyle(
                                                          color: Theme.of(context).colorScheme.onPrimary,
                                                          fontSize: 13.0,
                                                          fontWeight: FontWeight.w600,
                                                          letterSpacing: 1.9),
                                                      overflow: TextOverflow
                                                          .ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              )
                                              ),
                                          Expanded(
                                            flex: 2,
                                            child: PrimaryButton(buttonText: "Edit",fontSize: 12,containerWidth: 0,onPressed: (){},)
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
  }
}
