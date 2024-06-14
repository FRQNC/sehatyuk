import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TentangAplikasiPage extends StatelessWidget {
  TentangAplikasiPage({super.key});

  // List of dummy person names
  final List<String> personNames = [
    'Arya Aydin Margono',
    'Muhamad Furqon Al-Haqqi',
    'Nabil Hanif Achmaddiredja',
    'Setyawan Humay Senja',
    'Tattha Maharany Yasmin Akbar'
  ];

  // Dummy links for each person (replace with actual links later)
  final List<String> personLinks = [
    'https://github.com/aryaayy',
    'https://github.com/FRQNC',
    'https://github.com/NabilHanifA',
    'https://github.com/HumaySenja',
    'https://github.com/tatxha',
  ];

  // Function to launch URL
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
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          "Tentang Aplikasi",
          style: TextStyle(color: Theme.of(context).colorScheme.primary, fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tentang SehatYuk',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'SehatYuk adalah sebuah aplikasi di mana pengguna dapat memesan janji temu dengan dokter.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Tim Kami',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true, // Add this to prevent unbounded height error
              physics: NeverScrollableScrollPhysics(), // Prevent inner scrolling
              itemCount: personNames.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    "\u2022 ${personNames[index]}",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  onTap: () => _launchURL(context, personLinks[index]),
                );
              },
            ),
            SizedBox(height: 20), // Add some spacing before the footer
            Center(
              child: TextButton(
                onPressed: () {
                  _launchURL(context, "https://github.com/FRQNC/sehatyuk");
                },
                child: Text(
                  "\u00a9 2024 SehatYuk",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
