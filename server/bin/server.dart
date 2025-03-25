import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:backend/server_interface.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart' as pg;
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';

late final ServerDatabaseInterface store;

// Enhanced logging middleware
Middleware logAllRequests() {
  return (Handler innerHandler) {
    return (Request request) async {
      print('⬅️ ${request.method} ${request.requestedUri}');

      final response = await innerHandler(request);

      print(
          '➡️ ${response.statusCode} ${request.method} ${request.requestedUri}');
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

    final response = await store.interpretQueryAndRespond(jsonDecode(body));

    return Response.ok(
      jsonEncode(response),
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
  store = ServerDatabase.create(
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

  store.createAuthedUserAndClient(
    "user1",
    "user1name",
    "client1",
    "user1token",
  );

  final ip = InternetAddress.anyIPv4;
  final handler =
      Pipeline().addMiddleware(logAllRequests()).addHandler(_router.call);

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(handler, ip, port);
  print('Server listening on port ${server.port}');
}
