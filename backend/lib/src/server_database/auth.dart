import 'package:backend/src/server_database/database.dart';

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
