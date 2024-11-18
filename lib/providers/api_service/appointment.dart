import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:future_hub_test/database/appointment_manager.dart';

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

  Future<Either<dynamic, bool>> createAppointments(Appointment appointment) async {
    debugPrint("My data is ${appointment.toString()}");
    try {
      final response = await _dio.post('/appointments', data: {
      'title': appointment.title,
      'customer_name': appointment.customerName,
      'company': appointment.company,
      'description': appointment.description,
      'appointmentDateTime': appointment.appointmentDateTime.toIso8601String(),
      'latitude': appointment.latitude,
      'longitude': appointment.longitude,
      },);
      debugPrint("createAppointment response ${response.data}");
      return right(true);
    } on DioException catch (error) {
      debugPrint("createAppointment error response is ${error.response?.data}");
      return left(false);
    }
  }


  Future<Either<String, Appointment>> getAppointmentById(int id) async {
    try {
      debugPrint("Fetching appointment with ID: $id");
      final response = await _dio.get('/appointments/$id',
      queryParameters: {"id" : id }
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        debugPrint("Response: ${response.data}");

        // Convert the response data to AppointmentIdResponse
        Appointment appointment = Appointment.fromMap(response.data);
        debugPrint("Successfully fetched appointment: ${appointment.toString()}");

        // Return the successful response with the AppointmentIdResponse object
        return right(appointment);
      } else {
        return left("Appointment not found");
      }
    } on DioException catch (error) {
      // Handle Dio specific errors (e.g., network issues, server errors)
      debugPrint("Dio error: ${error.message}");
      return left("Error occurred: ${error.message}");
    } catch (e) {
      // Handle any other unexpected errors
      debugPrint("Unexpected error: $e");
      return left("Unexpected error occurred: $e");
    }
  }

  Future<Either<bool, bool>> deleteAppointments(int id) async {
    try {
      // final response = await _dio.get('/appointments');
      final response = await _dio.delete('/appointments/$id');
      // debugPrint("deleteAppointments response ${response.data}");
      // Appointment deleted successfully
      return right(true);
    } on DioException catch (error) {
      debugPrint("getAllAppointment error response is ${error.response?.data}");
      return left(false);
    }
  }
}
