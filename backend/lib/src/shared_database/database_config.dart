class DatabaseConfig {
  // final ClientNode uniqueClientNode;
  final bool isServer;

  const DatabaseConfig(
    this.isServer,
  );
}

class InvalidDatabaseConfigException implements Exception {
  final String message;

  InvalidDatabaseConfigException(this.message);
}

class DatabaseInitException implements Exception {
  final String message;

  DatabaseInitException(this.message);
}
