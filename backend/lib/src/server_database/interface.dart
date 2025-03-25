abstract interface class ServerDatabaseInterface {
  Future<void> initialize();

  Future<Map<String, dynamic>> interpretQueryAndRespond(
      Map<String, dynamic> query);

  Future<void> createAuthedUserAndClient(
      String userId, String userName, String clientId, String token);
}
