import 'package:apotek_asakami_app/Screen/consultation/consultation.dart';
import 'package:apotek_asakami_app/Screen/homecare/homecare.dart';
import 'package:apotek_asakami_app/Widget/ads_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() {
  runApp(const Service());
}

class Service extends StatefulWidget {
  const Service({super.key});

  @override
  State<Service> createState() => _ServiceState();
}

class _ServiceState extends State<Service> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const AdsPage(),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const Consultation(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    textStyle: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  icon: const Icon(Icons.chat_rounded),
                  label: const Text('Konsultasi'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const HomeCare(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                    textStyle: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  icon: const Icon(Icons.home_rounded),
                  label: const Text('Home Care'),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
