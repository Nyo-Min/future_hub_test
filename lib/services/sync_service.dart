import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:future_hub_test/constants/store_manager.dart';

import '../database/appointment_manager.dart';
import 'package:http/http.dart' as http;

class SyncService {
  late Dio _dio;

  SyncService() {
    _dio = Dio(BaseOptions(
      // baseUrl: 'http://localhost:3000',  // Use 10.0.2.2 for Android Emulator
      baseUrl: 'http://10.0.2.2:3000/', // Use 10.0.2.2 for Android Emulator
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      responseType: ResponseType.json,
      contentType: "application/json",
    ));
  }

  List<Appointment> offlineAdded = [];
  List<Appointment> offlineUpdated = [];
  List<int> offlineDeleted = [];

  Future<void> addAppointmentToAPI(Appointment newAppointment) async {
        try {
          final response =
          await _dio.post('appointments', data: newAppointment.toMap());
          if (response.statusCode == 201 || response.statusCode == 200) {
            debugPrint("Appointment synced create : ${response.data}");
          } else {
            debugPrint("Failed to sync appointment");
          }
        } catch (e) {
          debugPrint("Error syncing appointment: $e");
        }// debugPrint("No internet connection.");
  }

  // Sync delete an appointment
  Future<void> deleteAppointmentFromAPI(int id) async {
    debugPrint("You delete id $id");
      try {
            final response = await _dio.delete('appointments/$id');
            if(response.statusCode == 200){
              print("Delete successful $id");
            }

        // final response = await _dio.delete('appointments/$id');
        // final response = await _dio.delete('http://10.0.2.2:3000/appointments/$id');
      } catch (e) {
        print("Error syncing appointment deletion: $e");
      }
  }

  // Sync delete an appointment
  // Future<void> updateAppointmentInAPI(Appointment updateAppointmentList) async {
  //   int myId = updateAppointmentList.id;
  //   debugPrint("My appointment is ${updateAppointmentList.toString()}");
  //   try {
  //     final response = await _dio.put('appointments/$myId', data: updateAppointmentList.toMap());
  //     if(response.statusCode == 200){
  //       print("update successful $myId");
  //     }
  //   } catch (e) {
  //     print("Error syncing appointment deletion: $e");
  //   }
  // }

  Future<void> updateAppointmentInAPI(Appointment updateAppointmentList) async {
    int myId = updateAppointmentList.id;
    debugPrint("My appointment is ${updateAppointmentList.toString()}");
    try {
      final response = await _dio.put('appointments/$myId', data: updateAppointmentList.toMap());
      if(response.statusCode == 200){
        print("update successful $myId");
      }

      if (response.statusCode == 200) {
        // Successful update
        print("Appointment updated successfully.");
        // Handle successful update, maybe parse the response and update local data
      } else {
        // Something went wrong, maybe the ID was not found
        print("Failed to update appointment: ${response.statusCode}");
      }
    } catch (e) {
      print("Error syncing appointment deletion: $e");
    }
  }
  // Check if device is online
  static Future<bool> isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return !connectivityResult.contains(ConnectivityResult.none);
  }


Future<void> checkOnlineStatus() async {
    if(await SyncService.isOnline()){
      debugPrint("Connected internet!!!!");
      await syncWithAPI();
    }else{
      debugPrint("Not available internet!!!");
    }
  }
  Future<void> syncWithAPI() async {
    try {
      // Sync Added Appointments
      for (var appointment in StoreManager.getAppointmentList) {
        debugPrint("My list is ${appointment.toString()}");
        await addAppointmentToAPI(appointment);
      }

      // Sync Updated Appointments
      for (var updateAppointmentList in StoreManager.getUpdatedList) {
        debugPrint("my $updateAppointmentList");
        await updateAppointmentInAPI(updateAppointmentList);

        // await updateAppointmentInAPI();
      }

      // Sync Deleted Appointments
      for (var deleteIdNo in StoreManager.offlineDelete) {
        await deleteAppointmentFromAPI(deleteIdNo);
      }

      // Clear offline change lists
        StoreManager.clearAppointments();
        StoreManager.clearDeletedIdList();
        offlineDeleted.clear();

      // Optionally, fetch updated data from API and refresh local storage
      // await _fetchAllAppointmentsFromAPI();
    } catch (error) {
      print('Error syncing with the API: $error');
    }
  }
}