import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionTile extends StatelessWidget {
  final int index;
  final String question;
  final Widget inputWidget; // New prop to accept input widget

  QuestionTile({Key? key, required this.index, required this.question, required this.inputWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "${index + 1}.${'  '} ${question}",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 19.0,
                fontWeight: FontWeight.w600
              ),
            ),
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: inputWidget, // Use inputWidget instead of TextField
          ),
        ],
      ),
    );
  }
}
