import 'package:flutter/material.dart';
import 'package:future_hub_test/providers/api_service/appointment.dart';

import '../../constants/color.dart';
import '../../constants/size.dart';
import '../../constants/text_style.dart';
import '../../constants/widgets/sub_title_text_style.dart';
import '../../constants/widgets/title_text_style.dart';

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
            borderRadius: BorderRadius.circular(CustomSize.borderRadiusLarge),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TitleTextStyle(
                  titleText: "Delete appointment",
                  titleStyle: robotoFontStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      color: CustomColor.primaryBlue)),
              const SizedBox(
                height: CustomSize.borderRadiusLarge,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SubTitleTextStyle(
                        subTitleText:
                            "Are you sure you want to delete this appointment? ${widget.appointmentId}",
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
                      Expanded(
                        child: SizedBox(
                          height: CustomSize.rowHeight,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    CustomSize.borderRadiusLarge),
                              ),
                              backgroundColor: CustomColor.primaryBlue,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: SubTitleTextStyle(
                              subTitleText: "Cancel",
                              subTitleStyle: robotoFontStyleWC,
                              subTitleAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: CustomSize.marginSmallX,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: CustomSize.rowHeight,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      CustomSize.borderRadiusLarge),
                                ),
                                backgroundColor: CustomColor.primaryBlue,
                              ),
                              onPressed: () {
                                ApiService().deleteAppointments(int.parse(widget.appointmentId)).then((deleteAppointmentRes) {
                                  deleteAppointmentRes.fold((errorResponse) {}, // Handle the error case
                                          (successResponse) {
                                        debugPrint("My delete data is $successResponse");
                                        Navigator.of(context).pop();
                                      });
                                });
                              },
                              child: SubTitleTextStyle(
                                subTitleText: "OK",
                                subTitleStyle: robotoFontStyleWC,
                                subTitleAlign: TextAlign.center,
                              )),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
