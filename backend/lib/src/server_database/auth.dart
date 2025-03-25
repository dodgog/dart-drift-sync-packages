import 'package:backend/src/server_database/database.dart';

class UnauthorizedException implements Exception {
  final String message;

  UnauthorizedException(this.message);
}

extension Auth on ServerDatabase {
  Future<bool> verifyUser(String userId, String token) async {
    return await serverDrift.usersDrift
        .userExistsAndAuthed(
          userId: userId,
          token: token,
        )
        .getSingle();
  }

  Future<void> createUserClientAndAuth(
      String userId, String userName, String clientId, String token) async {
    await serverDrift.usersDrift.createUser(userId: userId, name: userName);

    await serverDrift.usersDrift.authUser(userId: userId, token: token);

    await serverDrift.sharedDrift.sharedUsersDrift
        .createClient(userId: userId, clientId: clientId);
  }
}
