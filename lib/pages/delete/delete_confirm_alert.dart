import 'package:flutter/material.dart';
import 'package:future_hub_test/constants/store_manager.dart';

import '../../constants/color.dart';
import '../../constants/size.dart';
import '../../constants/text_style.dart';
import '../../constants/widgets/header_text_style.dart';
import '../../constants/widgets/sub_title_text_style.dart';
import '../../database/database_helper.dart';
import '../../services/sync_service.dart';

class DeleteConfirmAlert extends StatefulWidget {
  final String appointmentId;
  const DeleteConfirmAlert({
    super.key,
    required this.appointmentId
  });
  @override
  State<DeleteConfirmAlert> createState() => _DeleteConfirmAlertState();
}

class _DeleteConfirmAlertState extends State<DeleteConfirmAlert> {
  // AlertDialogCustom alertDialogCustom = AlertDialogCustom();

  @override
  void initState() {
    super.initState();
  }

  Future<void> deleteAppointmentId(int myId) async {
    // Insert the appointment into the database
    int result = await LocalDatabase.deleteAppointment(myId);
    debugPrint("Appointment deleted with ID: $myId");
    if (result > 0) {
      popContext();
      // SyncService().syncDeleteAppointment(myId);
    } else {
      debugPrint("Failed to delete appointment with ID $myId");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(CustomSize.paddingMedium),
          margin: const EdgeInsets.only(top: 16),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(CustomSize.borderRadiusMediumX),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              HeaderTextStyle(
                  headerText: "Delete appointment",
                  headerStyle: robotoFontStyle.copyWith(
                      fontWeight: FontWeight.bold,
                  ),
              headerAlign: TextAlign.left,),
              const SizedBox(
                height: CustomSize.marginSmall,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitleTextStyle(
                        subTitleText:
                            "Are you sure you want to delete this appointment?",
                        subTitleStyle: robotoFontStyle)
                  ],
                ),
              ),
              const SizedBox(
                height: CustomSize.borderRadiusLarge,
              ),
              Container(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: CustomSize.marginLarge,
                      ),
                      SizedBox(
                        // height: CustomSize.rowHeight,
                        child: GestureDetector(
                          // style: ElevatedButton.styleFrom(
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(
                          //         CustomSize.borderRadiusLarge),
                          //   ),
                          //   backgroundColor: CustomColor.primaryBlue,
                          // ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: SubTitleTextStyle(
                            subTitleText: "Cancel",
                            subTitleStyle: robotoFontStyle.copyWith(color: CustomColor.primaryBlue),
                            subTitleAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: CustomSize.marginMedium,
                      ),
                      SizedBox(
                        // height: CustomSize.rowHeight,
                        child: GestureDetector(
                            // style: ElevatedButton.styleFrom(
                            //   shape: RoundedRectangleBorder(
                            //     borderRadius: BorderRadius.circular(
                            //         CustomSize.borderRadiusLarge),
                            //   ),
                            //   backgroundColor: CustomColor.primaryBlue,
                            // ),
                            onTap: () async {
                              // ApiService().deleteAppointments(int.parse(widget.appointmentId)).then((deleteAppointmentRes) {
                              //   deleteAppointmentRes.fold((errorResponse) {}, // Handle the error case
                              //           (successResponse) {
                              //         debugPrint("My delete data is $successResponse");
                              //         Navigator.of(context).pop();
                              //       });
                              // });
                              StoreManager.offlineDelete = [int.parse(widget.appointmentId)];
                              deleteAppointmentId(int.parse(widget.appointmentId));
                              await SyncService().checkOnlineStatus();
                            },
                            child: SubTitleTextStyle(
                              subTitleText: "Delete",
                              subTitleStyle: robotoFontStyle.copyWith(color: Colors.red),
                              subTitleAlign: TextAlign.center,
                            )),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }

  void popContext() {
    Navigator.of(context).pop();
  }
}
