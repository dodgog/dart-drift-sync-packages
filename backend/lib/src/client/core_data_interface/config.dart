import 'package:backend/shared_library.dart';

class CoreDataClientConfig extends DatabaseConfig {
  final String clientId;
  final String userId;
  final String userToken;

  CoreDataClientConfig({
    required this.clientId,
    required this.userId,
    required this.userToken,
  }) : super(false);
}
