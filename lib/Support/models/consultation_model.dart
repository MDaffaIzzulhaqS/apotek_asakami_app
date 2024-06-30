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
        'Dr. Andi Wijaya adalah dokter spesialis anak dengan pengalaman lebih dari 10 tahun.',
  ),
  Doctor(
    name: 'Dr. Budi Santoso',
    imageUrl: 'assets/images/default_profile.png',
    specialty: 'Spesialis Bedah',
    schedule: 'Selasa, Kamis: 10:00 - 14:00',
    phoneNumber: '+6281227086943',
    description:
        'Dr. Budi Santoso adalah dokter spesialis bedah dengan keahlian dalam operasi minimal invasif.',
  ),
];


final List<Doctor> homecareDoctors = [
  Doctor(
    name: 'Dr. Andi Wijaya',
    imageUrl: 'assets/images/default_profile.png',
    specialty: 'Spesialis Anak',
    schedule: 'Senin - Jumat: 09:00 - 15:00',
    phoneNumber: '+6281227086943',
    description:
        'Dr. Andi Wijaya adalah dokter spesialis anak dengan pengalaman lebih dari 10 tahun.',
  ),
  Doctor(
    name: 'Dr. Budi Santoso',
    imageUrl: 'assets/images/default_profile.png',
    specialty: 'Spesialis Bedah',
    schedule: 'Selasa, Kamis: 10:00 - 14:00',
    phoneNumber: '+6281227086943',
    description:
        'Dr. Budi Santoso adalah dokter spesialis bedah dengan keahlian dalam operasi minimal invasif.',
  ),
];
