import 'package:backend/client_library.dart';

/// A client-specific reducer of all events into nodes
extension ClientNodeHelper on AttributesDrift {
  Future<int> cleanAndReduceAttributeTable() async {
    await cleanAttributesTable();

    return await insertAllEventsIntoAttributes();
  }

  Future<List<Attribute>> getAttributesById(String entityId) async {
    return await getAttributesForEntity(entityId: entityId).get();
  }
}
