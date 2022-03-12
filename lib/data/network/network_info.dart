import 'package:data_connection_checker/data_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImplementor implements NetworkInfo {
  final DataConnectionChecker _dataConnectionChecker;
  NetworkInfoImplementor(
     this._dataConnectionChecker,
  );

  @override
  Future<bool> get isConnected => _dataConnectionChecker.hasConnection;
}
