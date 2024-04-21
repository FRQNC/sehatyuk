import 'package:flutter/material.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/primary_button.dart';

class TambahPengingatObat extends StatefulWidget {
  const TambahPengingatObat({super.key});

  @override
  State<TambahPengingatObat> createState() => _TambahPengingatObatState();
}

class _TambahPengingatObatState extends State<TambahPengingatObat>
    with AppMixin {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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

  String _selectedValueDosis = "";
  String _selectedValuePeriode = "";
  String _selectedValueHari = "";
  String _selectedValueKaliSehari = "";
  String _selectedValueAturanMinum = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {},
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          'Tambah Pengingat Minum Obat',
          style: TextStyle(
            fontSize: 18,
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
                padding: const EdgeInsets.only(top: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          formImageInputView(inputLabel: "Foto Obat*"),
                          formDropdownInputView(
                            inputLabel: "Dosis Obat *",
                            hintText: "Pilih",
                            items: ["1/2 tablet", "1 tablet", "2 tablet"],
                            selectedValue: _selectedValueDosis,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedValueDosis = newValue!;
                              });
                            },
                          ),
                          formDropdownInputView(
                            inputLabel: "Periode Minum Obat *",
                            hintText: "Pilih",
                            items: ["7 hari", "14 hari", "Sampai habis"],
                            selectedValue: _selectedValuePeriode,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedValuePeriode = newValue!;
                              });
                            },
                          ),
                          formDropdownInputView(
                            inputLabel: "Pilih Hari *",
                            hintText: "Pilih",
                            items: ["Senin", "Selasa", "Rabu"],
                            selectedValue: _selectedValueHari,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedValueHari = newValue!;
                              });
                            },
                          ),
                          formDropdownInputView(
                            inputLabel: "Berapa Kali Sehari *",
                            hintText: "Pilih",
                            items: ["1 x", "2 x", "3 x"],
                            selectedValue: _selectedValueKaliSehari,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedValueKaliSehari = newValue!;
                              });
                            },
                          ),
                          formDropdownInputView(
                            inputLabel: "Aturan Minum *",
                            hintText: "Pilih",
                            items: ["Sebelum makan", "Setelah Makan"],
                            selectedValue: _selectedValueAturanMinum,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedValueAturanMinum = newValue!;
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
                      child: PrimaryButton(
                        buttonText: "Simpan",
                        containerWidth: 160,
                        fontSize: 18,
                        onPressed: () {},
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
          // Teks dan container gambar di kiri
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
              SizedBox(height: 10), // Spacer
              GestureDetector(
                onTap: () {
                  // Tambahkan Function
                },
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.5), // Placeholder color
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: Image.asset(
                          'assets/images/pilihObatUntukPengingatPage/Metformin.png',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
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
                border: Border.all(
                    color: Theme.of(context).colorScheme.primary),
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
                    fontSize: 12, // Adjust as needed
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


