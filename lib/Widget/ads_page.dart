import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AdsPage extends StatefulWidget {
  const AdsPage({super.key});

  @override
  State<AdsPage> createState() => _AdsPageState();
}

class _AdsPageState extends State<AdsPage> {
  PageController adsController = PageController(
    initialPage: 0,
  );
  Timer? time;
  int adsNumber = 0;

  @override
  void initState() {
    time = Timer.periodic(const Duration(seconds: 3), (time) => runAds());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: PageView(
        controller: adsController,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: AssetImage('assets/images/poster_1.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: AssetImage('assets/images/poster_2.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: const DecorationImage(
                image: AssetImage('assets/images/poster_3.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  runAds() {
    setState(() {
      if (adsNumber < 2) {
        adsNumber++;
      } else {
        adsNumber = 0;
      }
      adsController.animateToPage(
        adsNumber,
        duration: const Duration(seconds: 2),
        curve: Curves.linear,
      );
    });
  }
}
