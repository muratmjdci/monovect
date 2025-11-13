import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF121212), Color(0xFF1C1C1E), Colors.black],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Opacity(
          //   opacity: .50,
          //   child: Container(
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         fit: BoxFit.cover,
          //         image: AssetImage("assets/particle_texture.png"),
          //       ),
          //     ),
          //   ),
          // ),
          Column(
            children: [
              Expanded(child: SizedBox()),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Pulsing background
                    AnimatedContainer(
                      duration: Duration(seconds: 2),
                      height: 180,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(198, 245, 76, .3),
                        borderRadius: BorderRadius.circular(200),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
                        child: Container(),
                      ),
                    ),

                    BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 40, sigmaY: 40),
                      child: Container(
                        height: 144,
                        width: 144,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: Colors.white.withOpacity(.05),
                          border: Border.all(
                            color: Colors.white.withOpacity(.1),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.1),
                              blurRadius: 25,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/logo.svg',
                              height: 64,
                              width: 64,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Vectorly",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 20,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Vectorly is loading...",
                      style: TextStyle(
                        color: Colors.white.withOpacity(.60),
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
