import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/informasiobat.dart';

class CariObatPage extends StatelessWidget {
  const CariObatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: (){
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cari Obat',
                style: TextStyle(
                  fontFamily: 'Poppins', // Font family
                  fontWeight: FontWeight.w600, // Semibold weight
                  fontSize: 16.0,
                  color: Color(0xFF4A707A),
                ),
              ),
              SizedBox(height: 10), // Adding some space between the texts
              Text(
                'Cari informasi obat yang anda butuhkan disini',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 10.0,
                  color: Color(0xFF37363B),
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: 30.0, left: 10.0, right: 10.0, bottom: 20),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xFFF5F5F5),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF94B0B7)),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    labelText: 'Cari Obat',
                    labelStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 10.0,
                      color: Color(0xFFC2C8C5),
                    ),
                    suffixIcon: Icon(Icons.search, color: Color(0xFF94B0B7)),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Filter',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: Color(0xFF37363B),
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(Icons.tune, color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFF5F5F5)), // Set button background color
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: BorderSide(color: Color(0xFF94B0B7)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: [
            GridItem(imagePath: 'assets/images/CariObatPage/image1.jpg', text: 'Paracetamol', additionaltext: 'kapsul'),
            GridItem(imagePath: 'assets/images/CariObatPage/image2.jpg', text: 'Ibuprofen', additionaltext: 'tablet'),
            GridItem(imagePath: 'assets/images/CariObatPage/image3.jpg', text: 'Amoxicillin', additionaltext: 'sirup'),
            GridItem(imagePath: 'assets/images/CariObatPage/image4.jpg', text: 'Omeprazole', additionaltext: 'sirup'),
            GridItem(imagePath: 'assets/images/CariObatPage/image5.jpg', text: 'Metformin HCl', additionaltext: 'tablet'),
            GridItem(imagePath: 'assets/images/CariObatPage/image6.jpg', text: 'Aspirin', additionaltext: 'tablet'),
          ],
        ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String imagePath;
  final String text;
  final String additionaltext;

  GridItem({required this.imagePath, required this.text, required this.additionaltext});

  @override
Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      //apa yang bakal dilakuin kalau kontainer obatnya ditekan
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => InformasiObatPage()),
      );
    },
    child: Container(
      margin: EdgeInsets.all(4.0),
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath, // Path to the image asset
            width: 91,
            height: 70,
          ),
          SizedBox(height: 2.0),
          Text(
            text, // Text to display
            style: TextStyle(
              color: Color(0xFF4A707A),
              fontWeight: FontWeight.w600,
              fontSize: 11.0,
            ),
          ),
          SizedBox(height: 2.0), // Add some space between the existing text and the additional text
          Text(
            additionaltext, // Display the additional text
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 9.0, // Adjust font size as needed
              color: Color(0xFF37363B), // Adjust color as needed
            ),
          ),
        ],
      ),
    ),
  );
  }
}
