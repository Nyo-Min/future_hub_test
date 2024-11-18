import 'dart:core';

import '../database/appointment_manager.dart';

class StoreManager {

  // Static variable to hold the name
  static List<Appointment> offlineAdded = [];
  static List<int> offlineDelete = [];
  static List<Appointment> offlineUpdate = [];
  static int updateCount = 3;

  // Getter for name
  static List<Appointment> get getAppointmentList => List.unmodifiable(offlineAdded);
  static List<int> get getDeletedIdList => List.unmodifiable(offlineDelete);
  static List<Appointment> get getUpdatedList => List.unmodifiable(offlineUpdate);
  static int get getUpdateCount => updateCount;


  // Setter for name
  static set getAppointmentList(List<Appointment> updateData) {
    offlineAdded = updateData;
  }
  static set getDeletedIdList(List<int> updateData) {
    offlineDelete = updateData;
  }
  static set getUpdatedList(List<Appointment> updateData) {
    offlineUpdate = updateData;
  }

  // Method to clear the offlineAdded list
  static void clearAppointments() {
    offlineAdded.clear();
  }
  static void clearDeletedIdList() {
    offlineDelete.clear();
  }
  static void clearUpdatedList() {
    offlineUpdate.clear();
  }

  static set getUpdateCount(int updateData) {
    updateCount = updateData;
  }

}