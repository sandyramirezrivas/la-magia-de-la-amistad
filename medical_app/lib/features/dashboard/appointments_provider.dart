import 'package:flutter_riverpod/flutter_riverpod.dart';

class Appointment {
  final String doctorName;
  final String specialty;
  final String date;
  final String location;
  final String status;

  Appointment({
    required this.doctorName,
    required this.specialty,
    required this.date,
    required this.location,
    required this.status,
  });
}

final appointmentsProvider = Provider<List<Appointment>>((ref) {
  return [
    Appointment(
      doctorName: "Dr. Carlos Méndez",
      specialty: "Cardiología",
      date: "Lunes 14 abr · 10:30 AM",
      location: "Clínica Central, Piso 4",
      status: "Confirmada",
    ),
  ];
});

final nextAppointmentProvider = Provider<Appointment?>((ref) {
  final appointments = ref.watch(appointmentsProvider);
  return appointments.isNotEmpty ? appointments.first : null;
});
