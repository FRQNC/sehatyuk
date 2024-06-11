import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/models/obat.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';
import 'package:sehatyuk/tambah_obat.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/providers/obat_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/auth/auth.dart';

class PilihObatUntukPengingatPage extends StatefulWidget {
  const PilihObatUntukPengingatPage({super.key});

  @override
  State<PilihObatUntukPengingatPage> createState() =>
      _PilihObatUntukPengingatPageState();
}

class _PilihObatUntukPengingatPageState
    extends State<PilihObatUntukPengingatPage> with AppMixin {
  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";
  String searchQuery = "";

  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _fetchToken();
  }

  Future<void> _fetchToken() async {
    _token = await auth.getToken();
    _user_id = await auth.getId();
    context.read<ObatProvider>().fetchData(_token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var obat = context.watch<ObatProvider>();
    var filteredObats = obat.searchObats(searchQuery);

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
                                controller: searchController,
                                onChanged: (value) {
                                  setState(() {
                                    searchQuery = value;
                                  });
                                },
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
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Consumer<ObatProvider>(
                      builder: (context, obat, _) {
                        return GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: 1,
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: 2.5,
                          children: filteredObats.map((item) {
                            return GestureDetector(
                              onTap: () {},
                              child: ObatView(
                                id: item.idObat.toString(),
                                imagePath: item.fotoObat,
                                text: item.namaObat,
                                additionaltext: item.jenisObat["jenis_obat"],
                                token: _token,
                                obat: item,
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ObatView extends StatelessWidget {
  final String id;
  final String imagePath;
  final String text;
  final String additionaltext;
  final String token;
  Obat obat;

  ObatView(
      {required this.id,
      required this.imagePath,
      required this.text,
      required this.additionaltext,
      required this.token,
      required this.obat});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      height: MediaQuery.of(context).size.height * 0.1,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 3),
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
                    child: CachedNetworkImage(
                      imageUrl: '${Endpoint.url}obat_image/$id',
                      httpHeaders: <String, String>{
                        'accept': 'application/json',
                        'Authorization': 'Bearer $token',
                      },
                      width: 91,
                      height: 70,
                    ),
                  ),
                ),
                Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          text,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.9),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          additionaltext,
                          style: const TextStyle(
                              color: Color(0xFF94B0B7),
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.9),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    )),
                Expanded(
                    flex: 2,
                    child: PrimaryButton(
                      buttonText: "Pilih",
                      fontSize: 12,
                      containerWidth: 0,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TambahPengingatObat(
                                      obat: obat,
                                    )));
                      },
                    ))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
