import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF056C49),
      body: Container(
        width: screenSize.width,
        height: screenSize.height,
        decoration: BoxDecoration(
          color: const Color(0xFF056C49),
          image: DecorationImage(
            fit: BoxFit.fitWidth,
            image: Image.network(
              'https://i.imgur.com/YQBQh7N.png',
            ).image,
          ),
        ),
        alignment: const AlignmentDirectional(0, 0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Align(
                    alignment: const AlignmentDirectional(-0.2, 0),
                    child: Image.network(
                      'https://imgur.com/ziSeq5r.png',
                      width: 171,
                      height: 107,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Container(
                              width: 170,
                              height: 170,
                              decoration: BoxDecoration(
                                color: const Color(0xFFCCDDD7),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFF879F97),
                                  width: 6,
                                ),
                              ),
                              alignment: const AlignmentDirectional(0, 0),
                              child: Lottie.network(
                                'https://assets3.lottiefiles.com/packages/lf20_TmewUx.json',
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0, 15, 0, 0),
                            child: Text(
                              'P L A T E S H A R E',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.acme(
                                color: Colors.white,
                                fontSize: 38,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          Text(
                            'Transforma tu cocina en una aventura',
                            style: GoogleFonts.lato(
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 100,
                                  height: 100,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF056C49),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Image.network(
                      'https://i.imgur.com/VhMzz4T.png',
                      width: 100,
                      height: 100,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
