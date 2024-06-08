import 'package:flutter/material.dart';

class FormDate extends StatefulWidget {
  final String inputLabel;
  final double labelFontSize;
  final double labelLetterSpacing;
  final bool readOnly;
  final String hintText;
  final double hintTextSize;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const FormDate({
    super.key,
    required this.inputLabel,
    this.labelFontSize = 14,
    this.labelLetterSpacing = 1.5,
    this.readOnly = true,
    this.hintText = "",
    this.hintTextSize = 12,
    required this.controller,
    this.validator
  });

  @override
  _FormDateState createState() => _FormDateState();
}

class _FormDateState extends State<FormDate> {

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1924),
        lastDate: DateTime.now());
    if (picked != null) {
      setState((){
        widget.controller.text = picked.toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.inputLabel,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: widget.labelFontSize,
              letterSpacing: widget.labelLetterSpacing,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              height: 35,
              decoration: BoxDecoration(
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: TextFormField(
                readOnly: widget.readOnly,
                onTap: () => _selectDate(context),
                controller: widget.controller,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontSize: widget.hintTextSize,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  suffixIcon: IconButton(
                    padding: EdgeInsets.only(bottom: 1),
                    icon: Icon(
                      Icons.calendar_today,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: widget.validator,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
