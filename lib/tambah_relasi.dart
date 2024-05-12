import 'package:flutter/material.dart';
import 'package:sehatyuk/main.dart';
import 'package:sehatyuk/primary_button.dart';
import 'package:sehatyuk/relasi.dart';


class TambahRelasiPage extends StatefulWidget {
  const TambahRelasiPage({super.key});

  @override
  State<TambahRelasiPage> createState() => _TambahRelasiPageState();
}

class _TambahRelasiPageState extends State<TambahRelasiPage> with AppMixin {
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
          'Tambah Relasi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: sideMargin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Text("Isi Identitas Diri",
            //         style: TextStyle(
            //             color: Theme.of(context).colorScheme.primary,
            //             fontSize: 20,
            //             fontWeight: FontWeight.w600,
            //             letterSpacing: 1.5)),
            //     // SizedBox(
            //     //   height: 15,
            //     // ),
            //     // Text(
            //     //   "Lorem Ipsum",
            //     //   style: TextStyle(
            //     //     fontSize: 14,
            //     //     color: Theme.of(context).colorScheme.onPrimary,
            //     //   ),
            //     // )
            //   ],
            // ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formkey,
                    child: Column(
                      children: [
        
                        formImageInputView(
                            inputLabel: "Foto *",
                            ),
                        formTextInputView(
                            inputLabel: "Nama Lengkap *",
                            hintText: "Masukkan nama lengkap"),
                        formTextInputView(
                            inputLabel: "Nomor BPJS/Asuransi",
                            hintText: "Masukkan nomor BPJS/Asuransi"),
                        formDateInputView(
                            inputLabel: "Tanggal Lahir *",
                            hintText: "Masukkan tanggal lahir", readOnly: true),
                        formTextInputView(
                            inputLabel: "Nomor Telepon *",
                            hintText: "Masukkan nomor telepon",
                            keyboardType: TextInputType.phone),
                        formTextInputView(
                            inputLabel: "Alamat *",
                            hintText: "Masukkan alamat"),
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => const RelasiPage()));
                        },
                      ),
                    ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Padding formTextInputView(
      {String inputLabel = "",
      double labelFontSize = 14,
      double labelLetterSpacing = 1.5,
      bool readOnly = false,
      String initialValue = "",
      String hintText = "",
      double hintTextSize = 12,
      TextInputType keyboardType = TextInputType.text,
      String? Function(String?)? validator,}) {
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
              child: TextFormField(
                readOnly: readOnly,
                initialValue: initialValue,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontSize: hintTextSize,
                      color: Theme.of(context).colorScheme.secondary),
                ),
                validator: validator,
              ),
            ),
          ),
        ],
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
                    Center(
                      child: Icon(
                        Icons.person,
                        size: 60,
                        color: Color(0xFF4A707A),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFF4A707A),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
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

  Padding formDateInputView(
      {String inputLabel = "",
      double labelFontSize = 14,
      double labelLetterSpacing = 1.5,
      bool readOnly = false,
      String hintText = "",
      double hintTextSize = 12,
      String? Function(String?)? validator,}) {
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
              child: TextFormField(
                readOnly: readOnly,
                onTap: () => _selectDate(context),
                controller: _dateController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(8),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: hintText,
                  hintStyle: TextStyle(
                      fontSize: hintTextSize,
                      color: Theme.of(context).colorScheme.secondary),
                  suffixIcon: IconButton(
                      icon: Icon(Icons.calendar_month_outlined, color: Theme.of(context).colorScheme.primary,),
                      onPressed: () => _selectDate(context)),
                ),
                validator: validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}