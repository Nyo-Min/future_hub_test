class Appointment {
  final int id;
  final String title;
  final String customerName;
  final String company;
  final String appointmentDescription;
  final DateTime appointmentDateTime;
  final double latitude;
  final double longitude;

  Appointment({
    required this.id,
    required this.title,
    required this.customerName,
    required this.company,
    required this.appointmentDescription,
    required this.appointmentDateTime,
    required this.latitude,
    required this.longitude,
  });

  // Convert Appointment to Map (SQLite format)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'customer_name': customerName,
      'company': company,
      'appointment_description': appointmentDescription,
      'appointment_date_time': appointmentDateTime.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Convert Map to Appointment (used for reading from SQLite)
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      title: map['title'],
      customerName: map['customer_name'],
      company: map['company'],
      appointmentDescription: map['appointment_description'],
      appointmentDateTime: DateTime.parse(map['appointment_date_time']),
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
