import 'package:apotek_asakami_app/Screen/apoteker/apoteker_profile.dart';
import 'package:apotek_asakami_app/Screen/apoteker/checkout_rekap.dart';
import 'package:apotek_asakami_app/Screen/apoteker/homecare_recap.dart';
import 'package:apotek_asakami_app/Screen/apoteker/transaction_recap.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class ApotekerBottomNavBar extends StatelessWidget {
  const ApotekerBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    PersistentTabController controller;
    controller = PersistentTabController(initialIndex: 0);
    List<Widget> buildScreens() {
      return [
        const TransactionRecap(),
        const CheckoutRecap(),
        const HomeCareRecap(),
        const ApotekerProfile(),
      ];
    }

    List<PersistentBottomNavBarItem> navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.list_alt_rounded),
          title: ("Rekap Pembayaran"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.list_alt_rounded),
          title: ("Rekap Pembelian"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.list_alt_rounded),
          title: ("Rekap Cek Homecare"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person_rounded),
          title: ("Profil"),
          activeColorPrimary: Colors.white,
          inactiveColorPrimary: Colors.grey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: controller,
      screens: buildScreens(),
      items: navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.deepPurple,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: const NavBarDecoration(
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(
          milliseconds: 200,
        ),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(
          milliseconds: 200,
        ),
      ),
      navBarStyle: NavBarStyle.style6,
    );
  }
}
