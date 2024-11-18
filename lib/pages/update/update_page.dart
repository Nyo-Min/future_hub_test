import 'package:flutter/material.dart';
import 'package:future_hub_test/constants/size.dart';
import 'package:future_hub_test/constants/text_style.dart';
import 'package:future_hub_test/constants/widgets/title_text_style.dart';
import 'package:future_hub_test/pages/create/widgets/custom_text_form_field.dart';
import 'package:future_hub_test/pages/update/widgets/success_dialog.dart';
import '../../constants/color.dart';
import '../../constants/store_manager.dart';
import '../../database/appointment_manager.dart';
import '../../database/database_helper.dart';
import '../../services/sync_service.dart';

class UpdatePage extends StatefulWidget {
  final int appointmentId;
  const UpdatePage({super.key, required this.appointmentId});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _formKey = GlobalKey<FormState>();

  // Controller for text inputs
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  final TextEditingController _appointmentDateController =
      TextEditingController();

  // Function to handle form submission
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // Get input values
      String title = _titleController.text;
      String customerName = _customerNameController.text;
      String company = _companyController.text;
      String description = _descriptionController.text;
      double latitude = double.parse(_latitudeController.text);
      double longitude = double.parse(_longitudeController.text);
      DateTime appointmentDateTime =
          DateTime.parse(_appointmentDateController.text);
      debugPrint(
          "param is $title $customerName $company $description $latitude $longitude $appointmentDateTime");

      Appointment newAppointment = Appointment(
        id: widget.appointmentId,
        title: title,
        customerName: customerName,
        company: company,
        description: description,
        appointmentDateTime: appointmentDateTime, // Example datetime
        latitude: latitude, // Example latitude (New York)
        longitude: longitude, // Example longitude (New York)
      );

      // Insert the appointment into the database
      int result = await LocalDatabase.updateAppointment(newAppointment);
      debugPrint("Appointment added with ID: $result");
      if (result == 1) {
        showSuccessDialog();
      }
      StoreManager.getUpdatedList = [
        newAppointment
      ];
      await SyncService().checkOnlineStatus();
    }
  }

  @override
  void initState() {
    super.initState();
    _loadAppointment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: TitleTextStyle(
            titleText: "Edit Appointment",
            titleStyle: robotoFontStyleWC,
          ),
        ),
        backgroundColor: CustomColor.primaryBlue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const SizedBox(
                height: CustomSize.marginSmall,
              ),
              CustomTextFormField(
                  titleController: _titleController,
                  labelText: "Enter title",
                  errorText: "Please enter a title"),
              CustomTextFormField(
                  titleController: _customerNameController,
                  labelText: "Enter customer name",
                  errorText: "Please enter the customer name"),
              CustomTextFormField(
                  titleController: _companyController,
                  labelText: "Enter company",
                  errorText: "Please enter the company name"),
              CustomTextFormField(
                  titleController: _descriptionController,
                  labelText: "Enter appointment description",
                  errorText: "Please enter an appointment description"),
              CustomTextFormField(
                  titleController: _latitudeController,
                  labelText: "Enter latitude",
                  errorText: "Please enter the latitude"),
              CustomTextFormField(
                  titleController: _longitudeController,
                  labelText: "Enter longitude",
                  errorText: "Please enter the longitude"),
              CustomTextFormField(
                  titleController: _appointmentDateController,
                  labelText: "Enter appointment date (yyyy-MM-ddTHH:mm:ss)",
                  errorText: "Please enter the appointment date and time"),
              const SizedBox(
                height: CustomSize.marginSmallX,
              ),
              ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            CustomSize.borderRadiusMediumX), // Rounded corners
                      ),
                      elevation: 10, // Shadow elevation
                      backgroundColor: CustomColor.primaryBlue),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 17),
                    child: TitleTextStyle(
                        titleText: 'Update Appointment',
                        titleStyle: robotoFontStyleWC),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  _loadAppointment() async {
    Appointment? appointment =
        await LocalDatabase.getAppointmentById(widget.appointmentId);
    if (appointment != null) {
      debugPrint("My update id ${appointment.id}");
      setState(() {
        _titleController.text = appointment.title;
        _customerNameController.text = appointment.customerName;
        _companyController.text = appointment.company;
        _descriptionController.text = appointment.description;
        _latitudeController.text = appointment.latitude.toString();
        _longitudeController.text = appointment.longitude.toString();
        _appointmentDateController.text =
            appointment.appointmentDateTime.toString();
      });
    } else {
      print("Appointment not found");
    }
  }

  void showSuccessDialog() {
    successDialog(
        context,
        "Appointment update successful",
        'assets/lotties/success.json'
    );
  }
}