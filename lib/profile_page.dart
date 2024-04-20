import 'package:flutter/material.dart';
import 'package:sehatyuk/welcome.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  final Color boxColor = const Color(0x5ED9D9D9);
  final Color dividerColor = const Color(0xFFD9D9D9);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20.0, 54.0, 20.0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Column(
                      //profile
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Profil",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 18.0,
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
                                child: Row(
                                  children: <Widget>[
                                    const Expanded(
                                      flex: 1,
                                      child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              'assets/images/profilePage/profile_pic.jpg'),
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
                                              const Text(
                                                "Aurora Alsava",
                                                style: TextStyle(
                                                    color: Color(0xFF37363B),
                                                    fontSize: 14.0,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.9),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Divider(
                                                  height: 5,
                                                  color: dividerColor),
                                              const Text(
                                                "081312345690",
                                                style: TextStyle(
                                                    color: Color(0xFF94B0B7),
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.9),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Divider(
                                                  height: 5,
                                                  color: dividerColor),
                                              const Text(
                                                "aurorasvv@upi.edu",
                                                style: TextStyle(
                                                    color: Color(0xFF94B0B7),
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.9),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Divider(
                                                  height: 5,
                                                  color: dividerColor)
                                            ],
                                          ),
                                        )),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xff4a707a),
                                    ),
                                    child: const Text(
                                      "Ubah",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14
                                      ),
                                    )
                                    ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      //informasi umum
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
                          child: Column(
                            children : <Widget>[
                              TextButton(
                                onPressed: () {},
                                child: Row(
                                  children : <Widget>[
                                     Expanded( //icon
                                      flex: 1,
                                      child: Icon(Icons.group, color: Theme.of(context).colorScheme.primary)
                                      ),
                                      const Expanded( //text
                                       flex: 3,
                                       child: Text(
                                        "Relasi",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff37363B),
                                          fontWeight: FontWeight.w500
                                        ) 
                                        )
                                      ),
                                      Expanded( //arrow
                                       flex: 1,
                                       child: Icon(Icons.chevron_right_sharp, color: Theme.of(context).colorScheme.primary)
                                      )
                                  ]
                                ),
                              ),
                              const Divider(height: 5),
                              TextButton(
                                onPressed: (){},
                                child: Row(
                                  children : <Widget>[
                                    Expanded( //icon
                                      flex: 1,
                                      child: Icon(Icons.help, color: Theme.of(context).colorScheme.primary)
                                      ),
                                      const Expanded( //text
                                       flex: 3,
                                       child: Text(
                                        "Pusat Bantuan",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff37363B),
                                          fontWeight: FontWeight.w500
                                        ) 
                                        )
                                      ),
                                      Expanded( //arrow
                                       flex: 1,
                                       child: Icon(Icons.chevron_right_sharp, color: Theme.of(context).colorScheme.primary)
                                      )
                                  ]
                                ),
                              ),
                              const Divider(height: 5),
                              TextButton(
                                onPressed: (){},
                                child: Row(
                                  children : <Widget>[
                                    Expanded( //icon
                                      flex: 1,
                                      child: Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary)
                                      ),
                                      const Expanded( //text
                                       flex: 3,
                                       child: Text(
                                        "Tentang Aplikasi",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff37363B),
                                          fontWeight: FontWeight.w500
                                        ) 
                                        )
                                      ),
                                      Expanded( //arrow
                                       flex: 1,
                                       child: Icon(Icons.chevron_right_sharp, color: Theme.of(context).colorScheme.primary)
                                      )
                                  ]
                                ),
                              ),
                            ]
                          )
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Column(
                      // Pengaturan Akun
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
                          child : Column(
                            children : <Widget>[
                              TextButton(
                                onPressed: () {},
                                child: Row(
                                  children : <Widget>[
                                     Expanded( //icon
                                      flex: 1,
                                      child: Icon(Icons.password, color: Theme.of(context).colorScheme.primary)
                                      ),
                                      const Expanded( //text
                                       flex: 3,
                                       child: Text(
                                        "Ganti Password",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff37363B),
                                          fontWeight: FontWeight.w500
                                        ) 
                                        )
                                      ),
                                      Expanded( //arrow
                                       flex: 1,
                                       child: Icon(Icons.chevron_right_sharp, color: Theme.of(context).colorScheme.primary)
                                      )
                                  ]
                                ),
                              ),
                              const Divider(height: 5),
                              TextButton(
                                onPressed: (){ Navigator.push(context, MaterialPageRoute(builder:(context) => const WelcomePage(),));},
                                child: Row(
                                  children : <Widget>[
                                    Expanded( //icon
                                      flex: 1,
                                      child: Icon(Icons.logout, color: Theme.of(context).colorScheme.primary)
                                      ),
                                      const Expanded( //text
                                       flex: 3,
                                       child: Text(
                                        "Keluar",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xff37363B),
                                          fontWeight: FontWeight.w500
                                        ) 
                                        )
                                      ),
                                      Expanded( //arrow
                                       flex: 1,
                                       child: Icon(Icons.chevron_right_sharp, color: Theme.of(context).colorScheme.primary)
                                      )
                                  ]
                                ),
                              )
                            ]
                          )
                        )
                      ],
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
