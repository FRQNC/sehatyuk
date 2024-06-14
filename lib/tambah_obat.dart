import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sehatyuk/auth/auth.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/med_reminder.dart';
import 'package:sehatyuk/models/pengingat_minum_obat.dart';
import 'package:sehatyuk/providers/pengingat_minum_obat_provider.dart';
import 'package:sehatyuk/templates/button/primary_button.dart';
import 'package:sehatyuk/models/obat.dart';
import 'package:sehatyuk/providers/endpoint.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sehatyuk/templates/form/form_dropdown.dart';
import 'package:sehatyuk/templates/form/form_text.dart';

class TambahPengingatObat extends StatefulWidget {
  final Obat obat;
  const TambahPengingatObat({Key? key, required this.obat}) : super(key: key);

  @override
  State<TambahPengingatObat> createState() => _TambahPengingatObatState();
}

class _TambahPengingatObatState extends State<TambahPengingatObat>
    with AppMixin {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  int count = 0;
  AuthService auth = AuthService();
  String _token = "";
  String _user_id = "";
  TextEditingController _namaObatController = TextEditingController();
  String nama_obat = "";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchToken();
    nama_obat = widget.obat.namaObat;
    _namaObatController = TextEditingController(text: nama_obat);
  }

  Future<void> _fetchToken() async {
    _token = await auth.getToken();
    _user_id = await auth.getId();
    setState(() {});
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1924),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        _dateController.text = picked.toString().split(" ")[0];
      });
    }
  }

  TextEditingController _dateController = TextEditingController();
  TextEditingController _dosisController = TextEditingController();
  TextEditingController _sendokController = TextEditingController(text: "sdm");
  TextEditingController _jadwalController =
      TextEditingController(text: "Sehari");
  TextEditingController _aturanController =
      TextEditingController(text: "Sebelum makan");

  String _selectedValueDosis = "";
  String _selectedValuePeriode = "";
  String _selectedValueHari = "";
  String _selectedValueKaliSehari = "";
  String _selectedValueAturanMinum = "";

  PengingatMinumObatProvider pengingat = PengingatMinumObatProvider();

  Future<bool> createData() async {
    int idObat = widget.obat.idObat;
    int idUser = int.parse(_user_id);
    int dosis = int.parse(_dosisController.text);
    String sendok = _sendokController.text;
    String jadwal = _jadwalController.text;
    String aturan = _aturanController.text;

    PengingatMinumObat newData = PengingatMinumObat(
        idObat: idObat,
        idUser: idUser,
        dosis: dosis,
        sendok: sendok,
        jadwal: jadwal,
        aturan: aturan,
        obat: {},
        user: {});

    bool isSucceed = await pengingat.createPengingatMinumObat(_token, newData);

    return isSucceed;
  }

  @override
  Widget build(BuildContext context) {
    var pengingatMinumObatProvider = Provider.of<PengingatMinumObatProvider>(context, listen: false);
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
          'Tambah Pengingat Minum Obat',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sideMargin),
        child: Padding(
          padding: const EdgeInsets.only(top: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          formImageInputView(inputLabel: "Foto Obat*"),
                          FormText(
                            validator: notNullValidator,
                            inputLabel: "Nama Obat *",
                            controller: _namaObatController,
                            readOnly: true,
                          ),
                          FormText(
                            validator: notNullValidator,
                            inputLabel: "Dosis *",
                            hintText: "Masukkan dosis (angka)",
                            controller: _dosisController,
                          ),
                          FormDropdown(
                            inputLabel: "Sendok *",
                            value: _sendokController.text,
                            dropDownItems: ["sdm", "sdt"],
                            onChanged: (String? newValue) {
                              setState(() {
                                _sendokController.text = newValue!;
                              });
                            },
                          ),
                          FormDropdown(
                            inputLabel: "Jadwal *",
                            value: _jadwalController.text,
                            dropDownItems: [
                              "Sehari",
                              "Dua Hari",
                              "Tiga Hari",
                              "Seminggu"
                            ],
                            onChanged: (String? newValue) {
                              setState(() {
                                _jadwalController.text = newValue!;
                              });
                            },
                          ),
                          FormDropdown(
                            inputLabel: "Aturan Minum *",
                            value: _aturanController.text,
                            dropDownItems: ["Sebelum makan", "Setelah Makan"],
                            onChanged: (String? newValue) {
                              setState(() {
                                _aturanController.text = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: _isLoading ? Center(child: CircularProgressIndicator()): PrimaryButton(
                        buttonText: "Simpan",
                        containerWidth: 160,
                        fontSize: 18,
                        onPressed: () async {
                          setState(() {
                            _isLoading = true;
                          });
                          bool isSucceed = await createData();
                          if (isSucceed) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Berhasil Membuat Pengingat!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            Navigator.popUntil(context, (route) {
                              return count++ == 3;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MedicationReminderPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Gagal Membuat Pengingat!'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                          setState(() {
                            _isLoading = false;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding formImageInputView({
    String inputLabel = "",
    double labelFontSize = 14,
    double labelLetterSpacing = 1.5,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                inputLabel,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: labelFontSize,
                  letterSpacing: labelLetterSpacing,
                ),
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              '${Endpoint.url}obat_image/${widget.obat.idObat}',
                          httpHeaders: <String, String>{
                            'accept': 'application/json',
                            'Authorization': 'Bearer $_token',
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding formDropdownInputView({
    required String inputLabel,
    double labelFontSize = 14,
    double labelLetterSpacing = 1.5,
    required String hintText,
    required List<String> items,
    required String selectedValue,
    required ValueChanged<String?>? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            inputLabel,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: labelFontSize,
              letterSpacing: labelLetterSpacing,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: hintText,
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                dropdownColor: Colors.white,
                value: selectedValue.isEmpty ? null : selectedValue,
                onChanged: onChanged,
                items: items.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
