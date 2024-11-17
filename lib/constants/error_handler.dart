import 'dart:convert';
import '../../models/error_response.dart';
import '../../providers/api_exception.dart';

dynamic errorHandler(error){
    dynamic errorResponse;
    List<String> list = ApiException().getExceptionMessage(error);
    Map<String, String> jsonObject = {
      'status': list[0],
      'message': list[1],
    };
    String jsonString = jsonEncode(jsonObject);
    final errorResponseData = json.decode(jsonString.toString());
    errorResponse = ErrorResponse.fromMap(errorResponseData);
    return errorResponse;
}