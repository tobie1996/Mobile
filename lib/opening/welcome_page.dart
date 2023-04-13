import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gspresence/opening/delayed_animation.dart';
import 'package:gspresence/opening/social_page.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(
            vertical: 60,
            horizontal: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                DelayedAnimation(
                  delay: 2500,
                  child: Container(
                    
                    height: 300,
                    child: Image.asset('images/image3.jpg'),                  
                  ),
                ),
                DelayedAnimation(
                  delay: 3500,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 30,
                      bottom: 20,
                    ),
                    child: Text(
                      "Application de Gestion du personnel",
                      
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        color: Colors.grey,
                        fontSize: 16,
                      ), 
                    ),
                  ),
                ),
                SizedBox(height: 100,),
                DelayedAnimation(
                  delay: 4500,
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo,
                          shape: StadiumBorder(),
                          padding: EdgeInsets.all(13)),
                      child: Text('COMMENCER'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SocialPage(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
