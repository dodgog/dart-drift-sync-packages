import 'dart:io';
import 'dart:async';
import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart' as pg;
import 'package:backend/server_database.dart';
import 'package:backend/messaging.dart';
import 'package:backend/client_definitions.dart';

late final ServerDatabase store;

// Enhanced logging middleware
Middleware logAllRequests() {
  return (Handler innerHandler) {
    return (Request request) async {
      print('⬅️ ${request.method} ${request.requestedUri}');

      final response = await innerHandler(request);

      print('➡️ ${response.statusCode} ${request.method} ${request.requestedUri}');
      if (response.statusCode >= 400) {
        print('❌ Error response body: ${await response.readAsString()}');
      }

      return response;
    };
  };
}

// Configure routes - add POST endpoint
final _router = Router()
  ..put('/data', _putDataHandler)
  ..post('/data', _putDataHandler); // Add POST handler using same logic

// PUT handler
Future<Response> _putDataHandler(Request request) async {
  try {
    final body = await request.readAsString();
    final postQuery = PostBundlesQuery.fromJson(jsonDecode(body));

    final postResponse = await store.interpretIncomingPostBundlesQueryAndRespond(postQuery);

    return Response.ok(
      jsonEncode(postResponse.toJson()),
      headers: {'content-type': 'application/json'},
    );
  } catch (e) {
    print('Error processing request: $e');
    return Response.internalServerError(
      body: 'Error processing request: ${e.toString()}',
    );
  }
}

void main(List<String> args) async {
  // Initialize PostgreSQL database
  store = ServerDatabase(
    initialConfig: ServerDatabaseConfig(),
    executor: PgDatabase(
      endpoint: pg.Endpoint(
        host: 'localhost',
        database: 'postgres',
        username: 'postgres',
        password: 'postgres',
      ),
      settings: pg.ConnectionSettings(sslMode: pg.SslMode.disable),
    ),
  );

  // Initialize the test user that matches the client
  await store.serverDrift.usersDrift.createUser(userId: "user1", name: "user1");

  await store.serverDrift.usersDrift.authUser(userId: "user1", token: "user1token");

  await store.serverDrift.sharedUsersDrift.createClient(userId: "user1", clientId: "client1");

  final ip = InternetAddress.anyIPv4;
  final handler = Pipeline().addMiddleware(logAllRequests()).addHandler(_router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
