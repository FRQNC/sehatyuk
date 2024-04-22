import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sehatyuk/main.dart';

class DetailResumePage extends StatefulWidget {
  const DetailResumePage({super.key});

  @override
  State<DetailResumePage> createState() => _DetailResumePageState();
}

class _DetailResumePageState extends State<DetailResumePage> with AppMixin{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
       appBar: AppBar(
         leading: BackButton(
           color: Theme.of(context).colorScheme.primary,
         ),
         title: Text(
          "Resume Medis",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
            fontWeight: semi,
            fontSize: 20,
          )
          ),
      ),
    );
  }
}