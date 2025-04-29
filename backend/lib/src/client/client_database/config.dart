import 'package:backend/shared_database.dart';

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
