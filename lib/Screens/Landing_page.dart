import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            child: isDarkMode
                ? Image.asset('assets/landing Image/landingBgDark.png',
                height: MediaQuery.of(context).size.height * .65
            )
                : Image.asset('assets/landing Image/LandingBgBright.png',
                height: MediaQuery.of(context).size.height * .65),
            // color: Colors.cyanAccent.withOpacity(.15),
          ),

          Center(
            child: Container(
              // decoration: const BoxDecoration(
              //   gradient: LinearGradient(
              //     colors: [
              //
              //     ],
              //     begin: Alignment.topLeft,
              //     end: Alignment.bottomRight,
              //   ),
              //   ),
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/landing Image/landingImage.png',
                      height: MediaQuery.of(context).size.height * .55,

                      fit: BoxFit.fill,
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.width*.28,
                      child: Column(
                        children: [
                          Text(
                            "Spend Smarter",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Save More",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),

                     Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(30),
                        child: InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.width * .13,
                            width: MediaQuery.of(context).size.width * .5,

                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context).colorScheme.primary,
                                  Theme.of(context).colorScheme.secondary,
                                  Theme.of(context).colorScheme.secondary,
                                ],
                              ),

                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                "Get Started",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/signin');
                          },
                          child: Text(
                            "Log in",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
