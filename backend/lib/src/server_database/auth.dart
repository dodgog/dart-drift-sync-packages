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
}
