import 'package:backend/client_definitions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:backend/client_database.dart';
import 'package:backend/messaging.dart';
import 'dart:convert';

class DataSyncService extends ChangeNotifier {
  final String serverUrl;
  final ClientDatabase db;

  DataSyncService({required this.serverUrl, required this.db});

  /// Only does events, does not handle reduction
  Future<void> sync() async {
    try {
      final postQuery = await db.pushEvents();
      final response = await http.post(
        Uri.parse(serverUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(postQuery.toJson()),
      );

      if (response.statusCode == 200) {
        final postResponse = PostBundlesResponse.fromJson(
          jsonDecode(response.body),
        );
        await db.pullEvents(postResponse);
        notifyListeners();
      } else {
        throw Exception('Failed to sync data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error syncing data: $e');
      rethrow;
    }
  }
}
