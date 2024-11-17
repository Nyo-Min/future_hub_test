import 'package:flutter/material.dart';
import 'package:future_hub_test/pages/delete/delete_confirm_alert.dart';
import 'package:future_hub_test/pages/update/update_page.dart';
import 'package:go_router/go_router.dart';

import '../../constants/color.dart';
import '../../constants/size.dart';
import '../../models/appointment_response.dart';
import '../../providers/api_service/appointment.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<AppointmentResponse> appointmentList = [];
  @override
  void initState() {
    super.initState();
    ApiService().getAppointments().then((allAppointmentRes) {
      allAppointmentRes.fold((errorResponse) {}, // Handle the error case
          (successResponse) {
        appointmentList.addAll(successResponse);
        debugPrint("My data is ${successResponse.length}");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: appointmentList.length,
        itemBuilder: (context, index) {
          final appointment = appointmentList[index];
          return Card(
              child: Column(
            children: [
              Text("Title : ${appointmentList[index].title}"),
              Text("Customer Name : ${appointmentList[index].customerName}"),
              Text("Company : ${appointmentList[index].company}"),
              Text(
                  "Appointment Desc : ${appointmentList[index].appointmentDescription}"),
              Text("Date Time ${appointmentList[index].appointmentDateTime}"),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: CustomColor.historyBtn,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(CustomSize.borderRadiusSmall)),
                ),
                onPressed: () async {
                  debugPrint("you click me for update");
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UpdatePage(
                            appointmentId: int.parse(appointmentList[index].id))),
                  );

                },
                child: Text("Update"),
              ),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: CustomColor.historyBtn,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(CustomSize.borderRadiusSmall)),
                ),
                onPressed: () async {
                  debugPrint("you click me for delete");
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return DeleteConfirmAlert(appointmentId: appointmentList[index].id,);
                    },
                  );
                },
                child: Text("delete"),
              ),
              ElevatedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: CustomColor.historyBtn,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(CustomSize.borderRadiusSmall)),
                ),
                onPressed: () async {
                  debugPrint("you click me for create");
                  context.pushNamed("/create_page");
                },
                child: Text("create"),
              ),
            ],
          ));
        },
      ),
    );
  }
}
