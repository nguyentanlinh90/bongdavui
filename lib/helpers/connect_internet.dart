import 'dart:io'; //InternetAddress utility
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart'; //For StreamController/Stream


class ConnectInternet{
  ConnectInternet();

  StreamController? connectionChangeController;

  Stream get connectionChange => connectionChangeController!.stream;
  bool hasConnection = false;
  bool _isDisposed = false;
  Connectivity? _connectivity;

  void onChangedListener() {
    connectionChangeController = StreamController.broadcast();
    _connectivity ??= Connectivity();
    _connectivity!.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      if(_isDisposed) {
        return;
      }
      _updateConnectionStatus(results.isNotEmpty ? results.first : ConnectivityResult.none);
    });
  }

  void dispose() {
    if(connectionChangeController!=null){
      connectionChangeController!.close();
      _isDisposed =true;
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.vpn:
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.other:
      case ConnectivityResult.satellite:
        hasConnection = true;
        connectionChangeController!.sink.add(true);
        break;
      case ConnectivityResult.none:
        hasConnection = false;
        connectionChangeController!.sink.add(false);
        break;
    }
  }
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
      } else {
        hasConnection = false;
      }
    } on SocketException catch (_) {
      hasConnection = false;
    }

    //The connection status changed send out an update to all listeners
    if (previousConnection != hasConnection) {
      //  connectionChangeController!.add(hasConnection);
    }

    return hasConnection;
  }
  void _connectionChange(ConnectivityResult result) {
    _updateConnectionStatus(result);
  }

  Future<bool> checkInternet() async {
    connectionChangeController ??= StreamController.broadcast();
    _connectivity ??= Connectivity();
    final List<ConnectivityResult> results =
        await _connectivity!.checkConnectivity();
    final value = results.isNotEmpty ? results.first : ConnectivityResult.none;
    switch (value) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.vpn:
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.other:
      case ConnectivityResult.satellite:
        return true;
      case ConnectivityResult.none:
        return false;
    }
  }
}

ConnectInternet connection = ConnectInternet();
