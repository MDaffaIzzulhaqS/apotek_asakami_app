import 'package:flutter/material.dart';

void main() {
  runApp(const Profile());
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            const CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage(
                'assets/images/default_profile.png',
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            itemProfile(
              'Nama',
              'Daffa',
              Icons.person_rounded,
            ),
            const SizedBox(
              height: 10,
            ),
            itemProfile(
              'No Handphone',
              '+6281227086943',
              Icons.phone_rounded,
            ),
            const SizedBox(
              height: 10,
            ),
            itemProfile(
              'Email',
              'izzulhaqdaffasuyanto@gmail.com',
              Icons.email_rounded,
            ),
            const SizedBox(
              height: 10,
            ),
            itemProfile(
              'Alamat',
              'Purwokerto',
              Icons.person_rounded,
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.deepPurple[400],
                  minimumSize: const Size.fromHeight(40),
                ),
                onPressed: () {},
                child: const Text(
                  'Ubah Profil',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.deepPurple.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData),
      ),
    );
  }
}
