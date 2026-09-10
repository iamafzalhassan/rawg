import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract interface class ConnectionChecker {
  Future<bool> get isConnected;

  Stream<bool> get onStatusChange;
}

class ConnectionCheckerImpl implements ConnectionChecker {
  final InternetConnection internetConnection;

  ConnectionCheckerImpl(this.internetConnection);

  @override
  Future<bool> get isConnected async => await internetConnection.hasInternetAccess;

  @override
  Stream<bool> get onStatusChange => internetConnection.onStatusChange.map((status) => status == InternetStatus.connected);
}
