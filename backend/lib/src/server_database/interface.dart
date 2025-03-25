import 'package:backend/messaging.dart';

abstract interface class ServerDatabaseInterface {

  Future<void> initialize();

  Future<QueryResponse<T>> interpretQueryAndRespond<T extends BaseQuery>(
      T query);

  Future<void> createAuthedUserAndClient(
      String userId, String userName, String clientId, String token);
}
