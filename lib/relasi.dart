import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/tambah_relasi.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';
import 'package:sehatyuk/providers/relasi_provider.dart';
import 'package:sehatyuk/models/relasi.dart';

class RelasiPage extends StatefulWidget {
  const RelasiPage({super.key});

  @override
  State<RelasiPage> createState() => _RelasiPageState();
}

class _RelasiPageState extends State<RelasiPage> with AppMixin {

  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";

  List<Relasi> relasiList = [];

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
    var relasiProvider = context.read<RelasiProvider>();
    await relasiProvider.fetchData(_user_id, _token);
    relasiList = relasiProvider.relasiList;
  }

  @override
    Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
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
                        'Mempermudah orang-orang terdekat anda dalam membuat janji dengan dokter',
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
                              itemCount: relasiList.length,
                              itemBuilder: (context, index){
                                return relasiItemView(relasiList[index], _token);
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

  Column relasiItemView(Relasi relasiInfo, String token) {
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
                            relasiInfo.namaLengkap,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: 14,
                                fontWeight:FontWeight.w600,
                                letterSpacing: 1.9),
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 8),
                          Text(
                            relasiInfo.tipe,
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
                          image: CachedNetworkImageProvider(
                            '${Endpoint.url}relasi_image/${relasiInfo.id_relasi}',
                            headers: <String, String>{
                                'accept': 'application/json',
                                'Authorization': 'Bearer $token',
                              },
                            ),
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