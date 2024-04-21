import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/tambah_relasi.dart';
import 'package:sehatyuk/profile_page.dart';
import 'package:sehatyuk/primary_button.dart';

class RelasiInfo {
  String relasiNama,
      relasiStatus,
      relasiImagePath;
  RelasiInfo(
      {required this.relasiNama,
      required this.relasiStatus,
      required this.relasiImagePath});
}

class RelasiPage extends StatefulWidget {
  const RelasiPage({super.key});

  @override
  State<RelasiPage> createState() => _RelasiPageState();
}

class _RelasiPageState extends State<RelasiPage> with AppMixin {

  List<RelasiInfo> relasiItem = [
    RelasiInfo(relasiNama: "Anantha Alsava",relasiStatus: "Kakak", relasiImagePath: 'assets/images/relasiPage/girl_1.jpg'),
    RelasiInfo(relasiNama: "Rich Brian",relasiStatus: "Adik", relasiImagePath: 'assets/images/relasiPage/boy_1.jpg'),
  ];

  @override
    Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const ProfilePage()));
          },
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: sideMargin, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Relasi",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.5)),
                      SizedBox(height: 8),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 32),
                  Column(
                    children: [
                      Container(
                        constraints: BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height * 0.65),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            //Med item card
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: relasiItem.length,
                              itemBuilder: (context, index){
                                return relasiItemView(relasiItem[index]);
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
                        padding: const EdgeInsets.all(0),
                        child: Center(
                          child: PrimaryButton(
                              buttonText: "Tambah",
                              containerWidth: 160,
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => const TambahRelasiPage()));
                              },
                              fontSize: 15),
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

  Column relasiItemView(RelasiInfo relasiInfo) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 20),
          height: 120,
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
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            relasiInfo.relasiNama,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 14,
                                fontWeight:FontWeight.w600,
                                letterSpacing: 1.9),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Text(
                            relasiInfo.relasiStatus,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12,
                                fontWeight:FontWeight.w500,
                                letterSpacing: 1.9),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      )
                    ),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.withOpacity(0.5), // Warna border
                          width: 0, // Lebar border
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        image: DecorationImage(
                          image: AssetImage(relasiInfo.relasiImagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
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