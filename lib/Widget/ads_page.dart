import 'dart:async';
import 'package:flutter/material.dart';

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
            color: Colors.red,
          ),
          Container(
            color: Colors.green,
          ),
          Container(
            color: Colors.blue,
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
