import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';


class ApiException {
  List<String> getExceptionMessage(DioException exception) {
    String hostErrorMessage =
        "Unable to resolve host \"rewardappapi.upgapp.com\"";
    switch (exception.type) {
      case DioExceptionType.badResponse:
        return [
          "Bad Response Error",
          "Check API url or parameters are invalid"
        ];
      case DioExceptionType.connectionError:
        return ["API Error", hostErrorMessage];
      case DioExceptionType.connectionTimeout:
        return ["Connection Timeout", hostErrorMessage];
      case DioExceptionType.cancel:
        return ["Request Cancelled", "Request was canceled"];
      case DioExceptionType.receiveTimeout:
        return ["Receive Timeout", hostErrorMessage];
      default:
        return ["Unknown Error", 'If you are using a VPN, please disconnect and try again.'];
    }
  }
}
