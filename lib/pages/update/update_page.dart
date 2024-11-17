import 'package:flutter/material.dart';

import '../../models/appointment_response.dart';
import '../../providers/api_service/appointment.dart';

class UpdatePage extends StatefulWidget {
  final int appointmentId;
  const UpdatePage({super.key, required this.appointmentId});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {

  List<AppointmentResponse> appointmentList = [];

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Text("Edit Page ${widget.appointmentId}"),
      )
    );
  }
}
