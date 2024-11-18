import 'package:flutter/material.dart';
import 'package:future_hub_test/constants/widgets/label_text_style.dart';
import 'package:future_hub_test/constants/widgets/sub_title_text_style.dart';
import 'package:future_hub_test/pages/google_map/google_map_page.dart';
import 'package:go_router/go_router.dart';

import '../../constants/color.dart';
import '../../constants/size.dart';
import '../../constants/text_style.dart';
import '../../constants/widgets/title_text_style.dart';
import '../../database/appointment_manager.dart';
import '../../database/database_helper.dart';
import '../../services/sync_service.dart';
import '../delete/delete_confirm_alert.dart';
import '../update/update_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Appointment>> _appointments;
  @override
  void initState() {
    super.initState();
    setState(() {
      _appointments = LocalDatabase.getAllAppointments();
    });
    checkOnlineStatus();

  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: TitleTextStyle(
            titleText: "APPOINTMENT LISTS",
            titleStyle: robotoFontStyleWC,
          ),
        ),
        backgroundColor: CustomColor.primaryBlue,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
      ),
      body: Column(
        children: [
          Container(
              width: size.width,
              margin: const EdgeInsets.all(CustomSize.marginSmall),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            CustomSize.borderRadiusMediumX), // Rounded corners
                      ),
                      elevation: 10, // Shadow elevation
                      backgroundColor: CustomColor.primaryBlue),
                  onPressed: () async {
                    debugPrint("You click create button");
                    await context.pushNamed("/create_page");
                    setState(() {
                      _appointments = LocalDatabase.getAllAppointments();
                    });
                  },
                  child: const Text(
                    "Create +",
                    style: TextStyle(color: Colors.white),
                  ))),
          Expanded(
            child: FutureBuilder<List<Appointment>>(
              future: _appointments,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No appointments found"));
                }
                var appointments = snapshot.data!;
                return ListView.builder(
                  itemCount: appointments.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: CustomSize.marginSmallX),
                      child: Card(
                          color: CustomColor.homeMenuBtn,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: size.width,
                                  decoration: const BoxDecoration(
                                      // color: Colors.blue
                                      ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            left: CustomSize.paddingSmall,
                                            right: CustomSize.paddingSmall,
                                          ),
                                          alignment: Alignment.centerLeft,
                                          child: TitleTextStyle(
                                            titleText:
                                                "Title : ${appointments[index].title}",
                                            titleStyle: robotoFontStyle.copyWith(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(
                                                    15), // Apply rounded corner to the top-right
                                              ),
                                            ),
                                            width: 80,
                                            alignment: Alignment.center,
                                            child: GestureDetector(
                                                onTap: () async {
                                                  debugPrint("You click me");
                                                  debugPrint(
                                                      "you click me for update");
                                                  await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => UpdatePage(
                                                            appointmentId: int
                                                                .parse(appointments[
                                                                        index]
                                                                    .id
                                                                    .toString()))),
                                                  );
                                                  setState(() {
                                                    _appointments = LocalDatabase
                                                        .getAllAppointments();
                                                  });
                                                },
                                                child: LabelTextStyle(
                                                    labelText: "Update",
                                                    labelStyle:
                                                        robotoFontStyleWC)),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(
                                                    15), // Apply rounded corner to the top-right
                                              ),
                                            ),
                                            alignment: Alignment.center,
                                            width: 80,
                                            child: GestureDetector(
                                                onTap: () async {
                                                  await showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return DeleteConfirmAlert(
                                                        appointmentId:
                                                            appointments[index]
                                                                .id
                                                                .toString(),
                                                      );
                                                    },
                                                  );
                                                  setState(() {
                                                    _appointments = LocalDatabase
                                                        .getAllAppointments();
                                                  });
                                                },
                                                child: LabelTextStyle(
                                                    labelText: "Delete",
                                                    labelStyle:
                                                        robotoFontStyleWC)),
                                          )
                                        ],
                                      )
                                    ],
                                  )),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: CustomSize.paddingSmall,
                                    right: CustomSize.paddingSmall,
                                    bottom: CustomSize.paddingSmall),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SubTitleTextStyle(
                                        subTitleText: "Customer Name : ${appointments[index].customerName}",
                                        subTitleStyle: robotoFontStyle
                                    ),
                                    SubTitleTextStyle(
                                        subTitleText: "Company : ${appointments[index].company}",
                                        subTitleStyle: robotoFontStyle
                                    ),
                                    SubTitleTextStyle(
                                        subTitleText: "Appointment Desc : ${appointments[index].description}",
                                        subTitleStyle: robotoFontStyle
                                    ),
                                    SubTitleTextStyle(
                                        subTitleText: "Date Time ${appointments[index].appointmentDateTime}",
                                        subTitleStyle: robotoFontStyle
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => GoogleMapPage(
                                              latitude: appointments[index]
                                                  .latitude
                                                  .toString(),
                                              longitude: appointments[index]
                                                  .longitude
                                                  .toString(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(Icons.location_on_rounded),
                                          Text(
                                              "Location ${appointments[index].latitude} * ${appointments[index].longitude}")
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    );
                  },
                );
              },
            ),
          ),
          const SizedBox(height: CustomSize.marginMedium,)
        ],
      ),
    );
  }

  Future<void> checkOnlineStatus() async {
    await SyncService().checkOnlineStatus();
  }


}
