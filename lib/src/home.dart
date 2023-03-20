import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Ini Home",
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'FiraSans',
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Stack(
          children: [
            Positioned(
              left: 10,
              top: 260,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Hello World",
                      style: TextStyle(
                          color: Colors.black87,
                          fontFamily: 'Minecrafter',
                          fontSize: 25,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {
                          context.go('/settings');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueGrey,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            )),
                        child: const Padding(
                          padding: EdgeInsets.all(16),
                          child: Text(
                            "Masuk Setting",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontFamily: "FiraSans"),
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Center(
                      child: ElevatedButton(
                          onPressed: () {
                            context.go("/weather");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueGrey,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              )),
                          child: const Padding(
                            padding: EdgeInsets.all(16),
                            child: Text(
                              "Check Weather",
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "FiraSans"),
                            ),
                          )),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              child: Image.asset(
                "assets/images/kucing.jpg",
                width: 250,
                height: 125,
              ),
            ),
          ],
        ));
  }
}
