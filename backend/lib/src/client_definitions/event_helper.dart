import 'package:backend/client_definitions.dart';

extension ClientEventHelper on EventsDrift {
  /// WARNING: Do not nest into more transactions as that is not supported by
  /// postgres drift
  /// [docs](https://drift.simonbinder.eu/dart_api/transactions/#supported-implementations)
  Future<int> insertLocalEventListTransaction(List<Event> events) async {
    int counter = 0;
    await transaction(() async {
      for (final event in events) {
        counter += await insertLocalEvent(
          id: event.id,
          type: event.type,
          clientId: event.clientId,
          targetNodeId: event.targetNodeId,
          clientTimeStamp: event.clientTimeStamp,
          content: event.content,
        );
      }
    });
    return counter;
  }
}
