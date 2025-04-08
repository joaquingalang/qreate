import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {

  final Connectivity _connectivity = Connectivity();

  // Check Device Network Connectivity
  Future<bool> checkConnectivity() async {
    final List<ConnectivityResult> connectivityResult = await _connectivity.checkConnectivity();

    // If there is no network connection return false
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return false;
    }

    // Otherwise return true
    return true;
  }

  // Get Network Connectivity Stream
  StreamSubscription<List<ConnectivityResult>> getSubscription(void Function(List<ConnectivityResult>) onData) {
    return _connectivity.onConnectivityChanged.listen(onData);
  }

}