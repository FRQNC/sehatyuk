import 'package:flutter/material.dart';

class FormDropdown extends StatelessWidget {
  final String inputLabel;
  final String value;
  final List<String> dropDownItems;
  final void Function(String?) onChanged;
  final double labelFontSize;
  final double labelLetterSpacing;

  const FormDropdown({
    super.key,
    required this.inputLabel,
    required this.value,
    required this.dropDownItems,
    required this.onChanged,
    this.labelFontSize = 14,
    this.labelLetterSpacing = 1.5,
  });

  @override
  Widget build(BuildContext context) {
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
              height: 35,
              padding: const EdgeInsets.fromLTRB(8,0,8,0),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: DropdownButtonFormField<String>(
                alignment: Alignment.bottomCenter,
                value: value,
                onChanged: onChanged,
                decoration: InputDecoration(
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  border: InputBorder.none,
                  fillColor: Colors.white,
                  filled: true,
                ),
                items: dropDownItems
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }).toList(),
                dropdownColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
