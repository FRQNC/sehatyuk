import 'package:flutter/material.dart';
import 'package:sehatyuk/cariobat.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/cari_dokter.dart';
import 'package:sehatyuk/cari_artikel.dart';
import 'package:sehatyuk/profile_page.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  final List<Widget> _pages = [
    HomePage(),
    CariDokterPage(),
    CariObatPage(),
    ProfilePage(),
  ];
  
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color(0xFF7697A0),
        selectedIndex: currentPageIndex,
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
            icon: Icon(Icons.medical_services),
            label: 'Cari Obat',
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