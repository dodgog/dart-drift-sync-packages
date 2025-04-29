import 'package:backend/client_definitions.dart';
import 'package:backend/client.dart';

/// A client-specific reducer of all events into nodes
extension ClientNodeHelper on AttributesDrift {
  Future<int> cleanAndReduceAttributeTable() async {
    final deletedCount = await cleanAttributesTable();

    return await insertAllEventsIntoAttributes();
  }

  Future<List<Attribute>> getAttrubutesById(String entityId) async {
    return await getAttributesForEntity(entityId: entityId).get();
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
