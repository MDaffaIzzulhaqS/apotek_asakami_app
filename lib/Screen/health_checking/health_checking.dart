import 'package:apotek_asakami_app/Screen/health_checking/blood_pressure_check.dart';
import 'package:apotek_asakami_app/Screen/health_checking/blood_sugar_check.dart';
import 'package:apotek_asakami_app/Screen/health_checking/cholesterol_check.dart';
import 'package:apotek_asakami_app/Screen/health_checking/full_check.dart';
import 'package:apotek_asakami_app/Screen/health_checking/uric_acid_check.dart';
import 'package:apotek_asakami_app/Widget/ads_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HealthChecking extends StatefulWidget {
  const HealthChecking({super.key});

  @override
  State<HealthChecking> createState() => HealthCheckingState();
}

class HealthCheckingState extends State<HealthChecking> {
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
                    screen: const BloodPressureCheck(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purpleAccent,
                    textStyle: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  icon: const Icon(Icons.list_alt_rounded),
                  label: const Text('Cek Tekanan Darah'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const BloodSugarCheck(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purpleAccent,
                    textStyle: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  icon: const Icon(Icons.list_alt_rounded),
                  label: const Text('Cek Gula Darah'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const UridAcidCheck(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purpleAccent,
                    textStyle: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  icon: const Icon(Icons.list_alt_rounded),
                  label: const Text('Cek Asam Urat'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const CholesterolCheck(),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.purpleAccent,
                    textStyle: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  icon: const Icon(Icons.list_alt_rounded),
                  label: const Text('Cek Kolesterol'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextButton.icon(
                  onPressed: () => PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const FullCheck(),
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
                  icon: const Icon(Icons.list_alt_rounded),
                  label: const Text('Cek Lengkap'),
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
