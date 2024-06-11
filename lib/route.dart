import 'package:flutter/material.dart';
import 'package:sehatyuk/cariobat.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/cari_dokter.dart';
import 'package:sehatyuk/cari_artikel.dart';
import 'package:sehatyuk/jadwaltemu.dart';
import 'package:sehatyuk/profile_page.dart';
import 'package:sehatyuk/providers/route_provider.dart';
import 'package:provider/provider.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final List<Widget> _pages = [
    HomePage(),
    CariDokterPage(),
    JadwalTemuPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    var routeIdx = context.watch<RouteProvider>();
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[routeIdx.pageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          routeIdx.pageIndex = index;
        },
        indicatorColor: Color(0xFF7697A0),
        selectedIndex: routeIdx.pageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_hospital),
            label: 'Cari Dokter',
          ),
          NavigationDestination(
            icon: Icon(Icons.assignment_rounded),
            label: 'Daftar Temu',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
