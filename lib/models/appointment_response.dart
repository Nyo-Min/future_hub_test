class AppointmentResponse {
  final dynamic id;
  final String title;
  final String customerName;
  final String company;
  final String appointmentDescription;
  final DateTime appointmentDateTime;
  final Location appointmentLocation;

  AppointmentResponse({
    required this.id,
    required this.title,
    required this.customerName,
    required this.company,
    required this.appointmentDescription,
    required this.appointmentDateTime,
    required this.appointmentLocation,
  });

  // Factory constructor to create an Appointment instance from JSON
  factory AppointmentResponse.fromJson(Map<String, dynamic> json) {
    return AppointmentResponse(
      id: json['id'],
      title: json['title'],
      customerName: json['customer_name'],
      company: json['company'],
      appointmentDescription: json['appointment_description'],
      appointmentDateTime: DateTime.parse(json['appointment_date_time']),
      appointmentLocation: Location.fromJson(json['appointment_location']),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  // Factory constructor to create a Location instance from JSON
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
