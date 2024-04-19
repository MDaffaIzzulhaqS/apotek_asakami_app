import 'package:apotek_asakami_app/Screen/main_menu.dart';
import 'package:apotek_asakami_app/Widget/build_page.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          bottom: 80,
        ),
        child: PageView(
          controller: controller,
          onPageChanged: (index) => setState(
            () => isLastPage = index == 2,
          ),
          children: [
            buildPage(
              color: Colors.white,
              urlImage: 'assets/images/images_onboarding_1.png',
              title: 'Pembelian Obat',
              subtitle: 'Tidak suka menunggu di Antrian Apotek?\n'
                  'Kami peduli terhadap kesehatan Anda dan menghargai waktu Anda.\n'
                  'Dengan Aplikasi Asakami, semua kebutuhan medis Anda hanya dengan sekali klik.',
            ),
            buildPage(
              color: Colors.white,
              urlImage: 'assets/images/images_onboarding_2_1.png',
              title: 'Konsultasi Kesehatan',
              subtitle: 'Asakami menyediakan cek kesehatan seperti\n'
                  'tekanan darah, gula darah, asam urat, dan kolesterol.',
            ),
            buildPage(
              color: Colors.white,
              urlImage: 'assets/images/images_onboarding_3.png',
              title: 'Layanan Homecare',
              subtitle:
                  'Kami juga menyediakan layanan homecare untuk memberikan kemudahan.',
            ),
          ],
        ),
      ),
      bottomSheet: isLastPage
          ? TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurple[400],
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const MainMenu(),
                  ),
                );
              },
              child: const Text(
                'Mulai',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            )
          : Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => controller.jumpToPage(3),
                    child: const Text('Lewati'),
                  ),
                  Center(
                    child: SmoothPageIndicator(
                      controller: controller,
                      count: 3,
                      effect: WormEffect(
                        spacing: 16,
                        dotColor: Colors.black26,
                        activeDotColor: Colors.teal.shade700,
                      ),
                      onDotClicked: (index) => controller.animateToPage(
                        index,
                        duration: const Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.easeIn,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => controller.nextPage(
                      duration: const Duration(
                        milliseconds: 500,
                      ),
                      curve: Curves.easeInOut,
                    ),
                    child: const Text('Selanjutnya'),
                  ),
                ],
              ),
            ),
    );
  }
}
