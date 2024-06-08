import 'package:flutter/material.dart';

class FormText extends StatefulWidget {
  final String inputLabel;
  final double labelFontSize;
  final double labelLetterSpacing;
  final bool readOnly;
  final String hintText;
  final double hintTextSize;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const FormText({
    super.key,
    required this.inputLabel,
    this.labelFontSize = 14,
    this.labelLetterSpacing = 1.5,
    this.readOnly = false,
    this.hintText = "",
    this.hintTextSize = 12,
    this.keyboardType = TextInputType.text,
    required this.controller,
    this.validator,
  });

  @override
  State<FormText> createState() => _FormTextState();
}

class _FormTextState extends State<FormText> {
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
                controller: widget.controller,
                keyboardType: widget.keyboardType,
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