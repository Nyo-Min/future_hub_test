import 'package:flutter/material.dart';
import '../../models/appointment_response.dart';
import '../../providers/api_service/appointment.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<CreatePage> {
  final _formKey = GlobalKey<FormState>();
  final ApiService _apiService = ApiService();

  // Controller for text inputs
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _appointmentDateController = TextEditingController();

  // Function to handle form submission
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Get input values
      String title = _titleController.text;
      String customerName = _customerNameController.text;
      String company = _companyController.text;
      String appointmentDescription = _descriptionController.text;
      double latitude = double.parse(_latitudeController.text);
      double longitude = double.parse(_longitudeController.text);
      DateTime appointmentDateTime = DateTime.parse(_appointmentDateController.text);
      debugPrint("param is $title $customerName $company $appointmentDescription $latitude $longitude $appointmentDateTime");

      Map<String, dynamic> data = {
        "id": 0, // The id will be generated by the backend
        "title": title,
        "customer_name": customerName,
        "company": company,
        "appointment_description": appointmentDescription,
        "appointment_date_time": appointmentDateTime,
        "appointment_location": Location(latitude: latitude, longitude: longitude),
      };

      // Call the API to create the appointment
      // bool success = await _apiService.createAppointments(data).then();
      ApiService().createAppointments(data).then((allAppointmentRes) {
        allAppointmentRes.fold((errorResponse) {}, // Handle the error case
                (successResponse) {
          debugPrint("Success");
            });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Appointment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _customerNameController,
                decoration: InputDecoration(labelText: 'Customer Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the customer name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _companyController,
                decoration: InputDecoration(labelText: 'Company'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the company name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Appointment Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an appointment description';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _latitudeController,
                decoration: InputDecoration(labelText: 'Latitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the latitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _longitudeController,
                decoration: InputDecoration(labelText: 'Longitude'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the longitude';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _appointmentDateController,
                decoration: InputDecoration(labelText: 'Appointment Date (yyyy-MM-ddTHH:mm:ss)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the appointment date and time';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Add Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}









// import 'package:flutter/material.dart';
//
// class CreatePage extends StatefulWidget {
//   const CreatePage({super.key});
//
//   @override
//   State<CreatePage> createState() => _CreatePageState();
// }
//
// class _CreatePageState extends State<CreatePage> {
//
//   // Controller for text inputs
//   final TextEditingController _titleController = TextEditingController();
//   final TextEditingController _customerNameController = TextEditingController();
//   final TextEditingController _companyController = TextEditingController();
//   final TextEditingController _descriptionController = TextEditingController();
//   final TextEditingController _latitudeController = TextEditingController();
//   final TextEditingController _longitudeController = TextEditingController();
//   final TextEditingController _appointmentDateController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         ),
//         body: Center(
//           child: Text("Create Page"),
//         )
//     );
//
//
//
//   }
