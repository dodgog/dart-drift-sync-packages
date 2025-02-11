// import 'package:drift/drift.dart';
//
// import 'event_types.dart';
// import 'shared_events.drift.dart';
// import 'shared_nodes.drift.dart';
//
// // apply client time and server time as last modified fields
// // later we should change it to using the vector clock ts
//
// // with edits and deletes need to ensure that the node exists (by providing
// // an object)
//
// class UnsupportedEventException implements Exception {
//   final String message;
//   UnsupportedEventException(this.message);
// }
//
// class UnsupportedEventFormatException extends UnsupportedEventException {
//   UnsupportedEventFormatException(super.message);
// }
//
//
// class DBAW extends SharedNodesDrift{
//   DBAW(super.db);
// }
//
//
//
// Future<Node> applyEvent(
//     Event event, DBAW dbAccessorWrapper) async {
//   if (event.type == EventTypes.create) {
//     return applyCreateEvent(event);
//   }
//
//   if (event.targetNodeId == null) {
//     throw UnsupportedEventFormatException(
//         "Target nodeId is null in a mutation event");
//   }
//
//   final node = await getNodeById(event.targetNodeId!);
//
//   final replacedNode =
//
//   switch (event.type) {
//     case EventTypes.edit:
//       applyEditEventToNode(event, node);
//     case EventTypes.delete:
//       applyDeleteEventToNode(event, node);
//     default:
//       throw UnsupportedEventException("No such event supported ${event.type}");
//   }
// }
//
// Node applyEditEventToNode(Event event, Node node) {
//   assert(event.targetNodeId == node.id);
//   assert(event.type == EventTypes.edit);
//
//   return node.copyWith(
//     content: event.content.nodeContent,
//     clientTimeStamp: event.clientTimeStamp,
//     serverTimeStamp: Value(event.serverTimeStamp),
//   );
// }
//
// Node applyDeleteEventToNode(Event event, Node node) {
//   assert(event.targetNodeId == node.id);
//   assert(event.type == EventTypes.delete);
//
//   return node.copyWith(
//     isDeleted: true,
//     clientTimeStamp: event.clientTimeStamp,
//     serverTimeStamp: Value(event.serverTimeStamp),
//   );
// }
//
// Node applyCreateEvent(Event event) {
//   assert(event.targetNodeId != null);
//   assert(event.type == EventTypes.create);
//
//   return Node(
//     id: event.targetNodeId!,
//     clientTimeStamp: event.clientTimeStamp,
//     serverTimeStamp: event.serverTimeStamp,
//     userId: event.content.userId,
//     isDeleted: false,
//     content: event.content.nodeContent,
//     type: event.content.nodeType,
//   );
// }
