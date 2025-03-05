import 'package:backend/shared_definitions.dart';

// AIUSE to refactor from apply event to node

class UnsupportedEventException implements Exception {
  final String message;
  UnsupportedEventException(this.message);
}

class UnsupportedEventFormatException extends UnsupportedEventException {
  UnsupportedEventFormatException(super.message);
}

extension AttributeApplicator on SharedAttributesDrift {
  /// Apply events against a database in one drift transaction
  Future<int> applyListOfEventsToAttributes(List<Event> events) async {
    int counter = 0;
    for (final event in events) {
      final result = await applyEventToAttributes(event);
      if (result) counter++;
    }
    return counter;
  }

  /// Apply an event to the attributes table using Last-Write-Wins (LWW)
  /// Returns true if the event was applied, false if it was rejected due to timestamp
  Future<bool> applyEventToAttributes(Event event) async {
    // The SQL will handle the LWW comparison
    final result = await insertEventIntoAttributes(
      entityId: event.entityId,
      attribute: event.attribute,
      value: event.value,
      timestamp: event.timestamp,
    );

    return result > 0;
  }
}
