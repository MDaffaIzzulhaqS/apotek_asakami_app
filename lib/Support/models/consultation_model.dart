class Doctor {
  final String name;
  final String specialty;
  final String schedule;
  final String description;
  final String imageUrl;
  final String phoneNumber;

  Doctor({
    required this.name,
    required this.specialty,
    required this.schedule,
    required this.description,
    required this.phoneNumber,
    required this.imageUrl,
  });
}

final List<Doctor> doctors = [
  Doctor(
    name: 'Dr. Andi Wijaya',
    imageUrl: 'assets/images/default_profile.png',
    specialty: 'Spesialis Anak',
    schedule: 'Senin - Jumat: 09:00 - 15:00',
    phoneNumber: '+6281227086943',
    description:
        'Dr. Andi Wijaya adalah dokter spesialis anak dengan keahlian konsultasi seputar anak.',
  ),
  Doctor(
    name: 'Dr. Budi Santoso',
    imageUrl: 'assets/images/default_profile.png',
    specialty: 'Spesialis Mata',
    schedule: 'Selasa, Kamis: 10:00 - 14:00',
    phoneNumber: '+6281227086943',
    description:
        'Dr. Budi Santoso adalah dokter spesialis mata dengan keahlian konsultasi seputar mata.',
  ),
  Doctor(
    name: 'Dr. Rini Puspitasari',
    imageUrl: 'assets/images/default_profile.png',
    specialty: 'Spesialis THT',
    schedule: 'Senin, Sabtu: 11:00 - 14:00',
    phoneNumber: '+6281227086943',
    description:
        'Dr. Rini Puspitasari adalah dokter spesialis THT dengan keahlian konsultasi seputar gigi.',
  ),
  Doctor(
    name: 'Dr. Yutskhina Musaarah',
    imageUrl: 'assets/images/default_profile.png',
    specialty: 'Spesialis Psikiater',
    schedule: 'Selasa, Jumat: 10:00 - 14:00',
    phoneNumber: '+6281227086943',
    description:
        'Dr. Yutskhina Musaarah adalah dokter spesialis bedah dengan keahlian konsultasi seputar psikiater',
  ),
];


final List<Doctor> homecareDoctors = [
  Doctor(
    name: 'Dr. Yutskhina Musaarah',
    imageUrl: 'assets/images/default_profile.png',
    specialty: 'Spesialis Homecare 1',
    schedule: 'Senin - Jumat: 09:00 - 15:00',
    phoneNumber: '+6281227086943',
    description:
        'Dr. Yutskhina Musaarah adalah dokter spesialis homecare dengan pengalaman lebih dari 10 tahun.',
  ),
  Doctor(
    name: 'Dr. Ika Maharani',
    imageUrl: 'assets/images/default_profile.png',
    specialty: 'Spesialis Homecare 2',
    schedule: 'Selasa, Kamis: 10:00 - 14:00',
    phoneNumber: '+6281227086943',
    description:
        'Dr. Ika Maharani adalah dokter spesialis homecare dengan keahlian dalam konsultasi.',
  ),
];
