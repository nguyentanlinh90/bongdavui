import 'dart:io'; //InternetAddress utility
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart'; //For StreamController/Stream


class ConnectInternet{
  //static final Connection _singleton = Connection._internal();
  // Connection._internal();

  ConnectInternet();
  // static Connection getInstance() => _singleton;

  StreamController? connectionChangeController;

  Stream get connectionChange => connectionChangeController!.stream;
  bool hasConnection = false;
  bool _isDisposed = false;
  Connectivity? _connectivity;

  void onChangedListener() {
    connectionChangeController = StreamController.broadcast();
    _connectivity ??= Connectivity();
    _connectivity!.onConnectivityChanged.listen((value) {
      if(_isDisposed) {
        return;
      }
      _updateConnectionStatus(value);
    });
  }

  void dispose() {
    if(connectionChangeController!=null){
      connectionChangeController!.close();
      _isDisposed =true;
    }
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  //  print('result ${result.toString()}');
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        connectionChangeController!.sink.add(true);
        break;
      case ConnectivityResult.none:
        hasConnection = false;
        connectionChangeController!.sink.add(false);
        break;
      default:
        hasConnection = true;
        break;
    }
  }
  Future<bool> checkConnection() async {
    bool previousConnection = hasConnection;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        hasConnection = true;
        //print('có');
      } else {
        hasConnection = false;
       // print('không');
      }
    } on SocketException catch (_) {
     // print('catch');
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
    // _checkConnection();
  }

  Future<bool> checkInternet()async {
    bool hasConnection = true;
    connectionChangeController = StreamController.broadcast();
    _connectivity = Connectivity();
    _connectivity!
        .checkConnectivity()
        .then((value) {
      switch (value) {
        case ConnectivityResult.wifi:
        case ConnectivityResult.mobile:
        //    print('có ConnectInternet');
          hasConnection = true;
          break;
        case ConnectivityResult.none:
        //    print('không ConnectInternet');
          hasConnection = false;
          break;
        default:
          hasConnection = true;
          //  print('default ConnectInternet');
          break;
      }
    });
    return hasConnection;
  }
}

ConnectInternet connection = ConnectInternet();