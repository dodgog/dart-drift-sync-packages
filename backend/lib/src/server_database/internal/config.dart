import 'package:backend/shared_database.dart';

class ServerDatabaseConfig extends DatabaseConfig {
  ServerDatabaseConfig(//{ClientNode? clientNode}
      // TODO: the stupidest way to declare client's priority in conflict
      //  resolution
      // ) : super(false, clientNode?? ClientNode("3Server"));
      )
      : super(true);
}
