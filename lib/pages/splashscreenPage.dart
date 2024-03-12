import 'package:career_recommendation_system/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(Duration(seconds: 8), () {
      // Navigate to the HomePage after the delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.directions, size: 65, color: Colors.deepPurple,),
            const SizedBox(height: 8,),
            Text(
              "Career Recommendation \nSystem",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(
                fontSize: 26.5,
                fontWeight: FontWeight.w500,
              ),
            ),

            Text(
              "Help us determine your future...",
              style: GoogleFonts.lato(
                color: Colors.deepPurple,
                fontSize: 18,
                fontStyle: FontStyle.italic
              ),
            ),
            SvgPicture.asset(
                "lib/images/undraw_right_direction_tge8.svg",
              width: 200,
              height: 200,
            )
          ],
        ),
      ),
    );
  }
}
