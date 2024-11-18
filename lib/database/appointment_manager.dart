class Appointment {
  int id;  // SQLite primary key
  String title;
  String customerName;
  String company;
  String description;
  DateTime appointmentDateTime;
  double latitude;
  double longitude;

  Appointment({
    required this.id,
    required this.title,
    required this.customerName,
    required this.company,
    required this.description,
    required this.appointmentDateTime,
    required this.latitude,
    required this.longitude,
  });

  // Convert Appointment to Map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'customerName': customerName,
      'company': company,
      'description': description,
      'appointmentDateTime': appointmentDateTime.toIso8601String(),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  // Convert Map to Appointment
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      title: map['title'],
      customerName: map['customerName'],
      company: map['company'],
      description: map['description'],
      appointmentDateTime: DateTime.parse(map['appointmentDateTime']),
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }
}
