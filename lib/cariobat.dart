import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/homepage.dart';
import 'package:sehatyuk/informasiobat.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:sehatyuk/providers/obat_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';


class CariObatPage extends StatefulWidget {
  const CariObatPage({super.key});

  @override
  State<CariObatPage> createState() => _CariObatPageState();
}

class _CariObatPageState extends State<CariObatPage> with AppMixin{
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
    // Fetch the token asynchronously
    _token = await auth.getToken();
    _user_id = await auth.getId();
    // Once token is fetched, trigger a rebuild of the widget tree
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var obat = context.watch<ObatProvider>();

    if(obat.obats.isEmpty){
      obat.fetchData(_token);
    }

    var filteredObats = obat.searchObats(searchQuery);

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
              SizedBox(height: 8), // Adding some space between the texts
              Text(
                'Cari informasi obat yang anda butuhkan disini',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 10.0,
                  color: Color(0xFF37363B),
                ),
              ),
              SizedBox(height: 32),
              TextField(
                  controller: searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Cari Obat',
                    suffixIcon: Icon(Icons.search, color: Theme.of(context).colorScheme.primary),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF94B0B7),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF94B0B7),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                    hintStyle: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFC2C8C5),
                    ),
                  ),
                ),
              SizedBox(height: 24),
              Consumer<ObatProvider>(
                builder: (context, obat, _) {
                  return GridView.count(
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    children: filteredObats.map((item) {
                      return GestureDetector(
                        onTap: () {
                          //apa yang bakal dilakuin kalau kontainer obatnya ditekan
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => InformasiObatPage(obat: item, token: _token)),
                          );
                        },
                        child: GridItem(
                          id: item.idObat.toString(),
                          imagePath: item.fotoObat,
                          text: item.namaObat,
                          additionaltext: item.jenisObat["jenis_obat"],
                          token: _token
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
              // GridView.count(
              //   shrinkWrap: true,
              //   crossAxisCount: 3,
              //   children: [
              //     GridItem(imagePath: 'assets/images/CariObatPage/image1.jpg', text: 'Paracetamol', additionaltext: 'kapsul'),
              //     GridItem(imagePath: 'assets/images/CariObatPage/image2.jpg', text: 'Ibuprofen', additionaltext: 'tablet'),
              //     GridItem(imagePath: 'assets/images/CariObatPage/image3.jpg', text: 'Amoxicillin', additionaltext: 'sirup'),
              //     GridItem(imagePath: 'assets/images/CariObatPage/image4.jpg', text: 'Omeprazole', additionaltext: 'sirup'),
              //     GridItem(imagePath: 'assets/images/CariObatPage/image5.jpg', text: 'Metformin HCl', additionaltext: 'tablet'),
              //     GridItem(imagePath: 'assets/images/CariObatPage/image6.jpg', text: 'Aspirin', additionaltext: 'tablet'),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String id;
  final String imagePath;
  final String text;
  final String additionaltext;
  final String token;

  GridItem({required this.id, required this.imagePath, required this.text, required this.additionaltext, required this.token});

  @override
  Widget build(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(4.0),
    padding: EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: Colors.grey[200],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: '${Endpoint.url}obat_image/$id',
          httpHeaders: <String, String>{
            'accept': 'application/json',
            'Authorization': 'Bearer $token',
          },
          width: 91,
          height: 70,
        ),
        // Image.asset(
        //   imagePath, // Path to the image asset
        //   width: 91,
        //   height: 70,
        // ),
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
  );
  }
}
