import 'package:backend/client_definitions.dart';

/// A client-specific reducer of all events into nodes
extension ClientNodeHelper on SharedAttributesDrift {
  Future<int> cleanAndReduceAttributeTable() async {
    final deletedCount = await cleanAttributesTable();

    return await insertAllEventsIntoAttributes();
  }

  Future<List<DocumentNodeObj>> getDocuments() async {
    final attributes = await getAttributes().get();
    return DocumentNodeObj.fromAllAttributes(attributes);
  }

  Future<List<SimpleNodeObj>> getScribbles() async {
    final attributes = await getAttributes().get();
    return SimpleNodeObj.fromAllAttributes(attributes);
  }
}
