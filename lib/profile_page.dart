import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/LoadPage.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/edit_profile.dart';
import 'package:sehatyuk/ganti_password.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/providers/user_provider.dart';
import 'package:sehatyuk/tentang_aplikasi.dart';
import 'package:sehatyuk/relasi.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sehatyuk/providers/route_provider.dart';
import 'package:url_launcher/url_launcher.dart';


class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Color boxColor = const Color(0x5ED9D9D9);
  final Color dividerColor = const Color(0xFFD9D9D9);

  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    await _fetchToken();
    await _fetchData();
    setState(() {
      _isInitialized = true;
    });
  }

  Future<void> _fetchToken() async {
    _token = await auth.getToken();
    _user_id = await auth.getId();
    setState(() {});
  }

  Future<void> _fetchData() async {
    await Provider.of<UserProvider>(context, listen: false).fetchData();
  }

  Future<void> _refreshData() async {
    await Provider.of<UserProvider>(context, listen: false).fetchData();
  }

  Future<void> _logout() async {
  auth.removeAuth();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var routeProvider = Provider.of<RouteProvider>(context, listen: false);
  prefs.setBool("openedFirstTime", true);
  await Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => LoadPage()),
  );
  routeProvider.pageIndex = 0;
}

  void _launchURL(BuildContext context, String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: _isInitialized ? SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(height: 32),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Profil",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 2.4)),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: BoxDecoration(
                              color: boxColor,
                              borderRadius: BorderRadius.circular(15)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Consumer<UserProvider>(
                                    builder: (context, data, _) {
                                  return Row(
                                    children: <Widget>[
                                      Expanded(
                                        flex: 1,
                                        child: CircleAvatar(
                                            backgroundImage:
                                                _token.isNotEmpty
                                                    ? CachedNetworkImageProvider(
                                                        '${Endpoint.url}user_image/${data.userData.id_user}/${data.userData.photoUrl}',
                                                        headers: <String, String>{
                                                          'accept': 'application/json',
                                                          'Authorization': 'Bearer $_token',
                                                        },
                                                      )
                                                    : AssetImage('assets/default.jpg') as ImageProvider,
                                            radius: 37.5),
                                      ),
                                      Expanded(
                                          flex: 3,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                15, 15, 8, 0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Text(
                                                  data.userData.namaLengkap,
                                                  style: TextStyle(
                                                      color: Color(0xFF37363B),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1.9),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Divider(
                                                    height: 5,
                                                    color: dividerColor),
                                                Text(
                                                  data.userData.noTelp,
                                                  style: TextStyle(
                                                      color: Color(0xFF94B0B7),
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1.9),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Divider(
                                                    height: 5,
                                                    color: dividerColor),
                                                Text(
                                                  data.userData.email,
                                                  style: TextStyle(
                                                      color: Color(0xFF94B0B7),
                                                      fontSize: 12.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      letterSpacing: 1.9),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Divider(
                                                    height: 5,
                                                    color: dividerColor)
                                              ],
                                            ),
                                          )),
                                    ],
                                  );
                                }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                    onPressed: () async {
                                      final result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EditProfilePage()));
                                      if (result) {
                                        await _refreshData();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff4a707a),
                                    ),
                                    child: const Text(
                                      "Ubah",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Informasi Umum",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.6)),
                        const SizedBox(height: 8.0),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: boxColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const RelasiPage()));
                                },
                                child: Row(children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.group,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  const Expanded(
                                      flex: 3,
                                      child: Text("Relasi",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff37363B),
                                              fontWeight: FontWeight.w500))),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.chevron_right_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))
                                ]),
                              ),
                              const Divider(height: 5),
                              TextButton(
                                onPressed: () {
                                  _launchURL(context, "https://github.com/FRQNC/sehatyuk");
                                },
                                child: Row(children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.help,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  const Expanded(
                                      flex: 3,
                                      child: Text("Pusat Bantuan",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff37363B),
                                              fontWeight: FontWeight.w500))),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.chevron_right_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))
                                ]),
                              ),
                              const Divider(height: 5),
                              TextButton(
                                onPressed: () {
                                   Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                               TentangAplikasiPage()));
                                },
                                child: Row(children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.info_outline,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  const Expanded(
                                      flex: 3,
                                      child: Text("Tentang Aplikasi",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff37363B),
                                              fontWeight: FontWeight.w500))),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.chevron_right_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))
                                ]),
                              ),
                            ])),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Pengaturan Akun",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.6)),
                        const SizedBox(height: 7.0),
                        Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: boxColor,
                                borderRadius: BorderRadius.circular(15)),
                            child: Column(children: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const GantiPasswordPage(),
                                      ));
                                },
                                child: Row(children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.password,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  const Expanded(
                                      flex: 3,
                                      child: Text("Ganti Password",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff37363B),
                                              fontWeight: FontWeight.w500))),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.chevron_right_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))
                                ]),
                              ),
                              const Divider(height: 5),
                              TextButton(
                                onPressed: () {
                                  _logout();
                                },
                                child: Row(children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.logout,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary)),
                                  const Expanded(
                                      flex: 3,
                                      child: Text("Keluar",
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Color(0xff37363B),
                                              fontWeight: FontWeight.w500))),
                                  Expanded(
                                      flex: 1,
                                      child: Icon(Icons.chevron_right_sharp,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary))
                                ]),
                              )
                            ]))
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ) : Center(child: CircularProgressIndicator())
    );
  }
}
