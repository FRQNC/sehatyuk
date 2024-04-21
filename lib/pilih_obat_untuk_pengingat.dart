import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class PilihObatUntukPengingatPage extends StatefulWidget {
  const PilihObatUntukPengingatPage({super.key});

  @override
  State<PilihObatUntukPengingatPage> createState() =>
      _PilihObatUntukPengingatPageState();
}

class _PilihObatUntukPengingatPageState
    extends State<PilihObatUntukPengingatPage> with AppMixin {
  List<MedicationInfo> medItem = [
    MedicationInfo(
        medicationName: "Metformin HCI",
        medicationType: "Tablet",
        medicationDescription: "Lorem ipsum",
        medicationImagePath:
            'assets/images/pilihObatUntukPengingatPage/Metformin.png'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text("Pilih Obat",
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: semi,
              fontSize: 20,
              letterSpacing: 1.3,
            )),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sideMargin),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  hintText: "Cari obat",
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                                  suffixIcon: IconButton(
                                      icon: Icon(
                                        Icons.search,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      onPressed: () {}),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: medItem.length,
                  itemBuilder: (context, index) {
                    return medicationReminderItemView(medItem[index]);
                  })
            ],
          ),
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
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1.9),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              medInfo.medicationType,
                              style: const TextStyle(
                                  color: Color(0xFF94B0B7),
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.9),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                medInfo.medicationDescription,
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 1.9),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                    Expanded(
                        flex: 2,
                        child: PrimaryButton(
                          buttonText: "Pilih",
                          fontSize: 12,
                          containerWidth: 0,
                          onPressed: () {},
                        ))
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
