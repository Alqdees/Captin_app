
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class DataServer with ChangeNotifier {
  final DatabaseReference _databaseRef; // Reference to the Firebase database
  Object? _localData; // Local data stored in the app

  DataServer(this._databaseRef) {
    _localData = {}; // Initialize local data as an empty map
    _startListener(); // Start the listener
  }

  void _startListener() {
    _databaseRef.onValue.listen((event) {
      if (event.snapshot.value != null) {
        final serverData = event.snapshot.value; // Convert the data from the snapshot to a Map
        _compareData(serverData!); // Compare server data with local data
      }
    });
  }

  void _compareData(Object serverData) {
    if (_localData == serverData) { // Check if server data is different from local data
      _localData = serverData; // Update local data
      notifyListeners(); // Notify listeners that data has changed
    }
  }
}