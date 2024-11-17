import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:future_hub_test/models/appointment_response.dart';

import '../../constants/error_handler.dart';

class ApiService {
  late Dio _dio;

  ApiService() {
    _dio = Dio(BaseOptions(
      // baseUrl: 'http://localhost:3000',  // Use 10.0.2.2 for Android Emulator
      baseUrl: 'http://10.0.2.2:3000', // Use 10.0.2.2 for Android Emulator
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      headers: {
        'Content-Type': 'application/json', // Set the default content type
        'Accept': 'application/json', // Set Accept header to application/json
      },
    ));
  }

    Future<Either<dynamic, bool>> createAppointments(Map<String, dynamic> createData) async {
    try {
      final response = await _dio.post('/appointments', data: createData);
      // debugPrint("getAllAppointment response ${response.data}");
      return right(true);
    } on DioException catch (error) {
      debugPrint("getAllAppointment error response is ${error.response?.data}");
      return left(false);
    }
  }

  Future<Either<dynamic, List<AppointmentResponse>>> getAppointments() async {
    try {
      final response = await _dio.get('/appointments');
      // debugPrint("getAllAppointment response ${response.data}");
      List<dynamic> data = response.data;
      List<AppointmentResponse> successResponse =
          data.map((json) => AppointmentResponse.fromJson(json)).toList();
      return right(successResponse);
    } on DioException catch (error) {
      debugPrint("getAllAppointment error response is ${error.response?.data}");
      var errorResponse = errorHandler(error);
      return left(errorResponse);
    }
  }

  Future<Either<bool, bool>> deleteAppointments(int id) async {
    try {
      // final response = await _dio.get('/appointments');
      final response = await _dio.delete('/appointments/$id');
      // debugPrint("getAllAppointment response ${response.data}");
      // Appointment deleted successfully
      return right(true);
    } on DioException catch (error) {
      debugPrint("getAllAppointment error response is ${error.response?.data}");
      return left(false);
    }
  }
}
