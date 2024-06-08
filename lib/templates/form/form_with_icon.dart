import 'package:flutter/material.dart';

class FormWithIcon extends StatefulWidget {
  final String inputLabel;
  final IconData icon;
  final double labelFontSize;
  final double labelLetterSpacing;
  final bool readOnly;
  final bool obscureText;
  final String hintText;
  final double hintTextSize;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final VoidCallback onPressed;

  const FormWithIcon({
    super.key,
    required this.inputLabel,
    required this.icon,
    this.labelFontSize = 14,
    this.labelLetterSpacing = 1.5,
    this.readOnly = false,
    this.obscureText = false,
    this.hintText = "",
    this.hintTextSize = 12,
    this.keyboardType = TextInputType.text,
    required this.controller,
    required this.onPressed,
    this.validator,
  });

  @override
  State<FormWithIcon> createState() => _FormWithIconState();
}

class _FormWithIconState extends State<FormWithIcon> {
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
                obscureText: widget.obscureText,
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
                      widget.icon,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    onPressed: widget.onPressed,
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