import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';

class DatabaseConfig {
  // final ClientNode uniqueClientNode;
  final bool isServer;

  const DatabaseConfig(
    this.isServer,
  );
}

class ServerDatabaseConfig extends DatabaseConfig {
  ServerDatabaseConfig(//{ClientNode? clientNode}
      // TODO: the stupidest way to declare client's priority in conflict
      //  resolution
      // ) : super(false, clientNode?? ClientNode("3Server"));
      )
      : super(true);
}

class ClientDatabaseConfig extends DatabaseConfig {
  final String clientId;
  final String userId;
  final String userToken;

  ClientDatabaseConfig({
    required this.clientId,
    required this.userId,
    required this.userToken,
  }) : super(false);
}

class InvalidDatabaseConfigException implements Exception {
  final String message;
  InvalidDatabaseConfigException(this.message);
}
