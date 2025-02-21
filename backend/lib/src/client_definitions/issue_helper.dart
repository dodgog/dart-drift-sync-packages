import 'package:backend/client_definitions.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:uuidv7/uuidv7.dart';

Event issueRawDocumentCreateEventFromContent(NodeContent content) {
  return Event(
    // THINK: where should assignment of id happen? maybe on insertion?
    // for now it's in a helper function for insertion
    id: generateUuidV7String(),
    // THINK: generation happens here and also on the next stage
    targetNodeId: generateUuidV7String(),
    type: EventTypes.create,
    // THINK: happens on the actual insert
    clientId: "toPopulate",
    timestamp: HLC().issueLocalEventPacked(),
    content: EventContent(
      "wow",
      // THINK where is config values like client and user assigned
      "toPopulate",
      EventTypes.create,
      NodeTypes.document,
      content,
    ),
  );
}

Event issueRawCreateEventFromNodeTEST(Node node) {
  return Event(
    // THINK: where should assignment of id happen? maybe on insertion?
    // for now it's in a helper function for insertion
    id: generateUuidV7String(),
    // THINK: generation happens here and also on the next stage
    targetNodeId: generateUuidV7String(),
    type: EventTypes.create,
    // THINK: happens on the actual insert
    clientId: "toPopulate",
    timestamp: HLC().issueLocalEventPacked(),
    content: EventContent(
      "wow",
      // THINK where is config values like client and user assigned
      "toPopulate",
      EventTypes.create,
      node.type,
      node.content,
    ),
  );
}

extension NodeEvents on Node {
  Event issueRawEditEventFromMutatedContent(
    NodeContent nodeContent,
  ) {
    return Event(
      id: generateUuidV7String(),
      type: EventTypes.edit,
      targetNodeId: id,
      timestamp: HLC().issueLocalEventPacked(),
      // THINK: happens on the actual insert
      clientId: "toPopulate",
      content: EventContent(
        "wow",
        "toPopulate",
        EventTypes.edit,
        type,
        nodeContent,
      ),
    );
  }

  Event issueRawDeleteNodeEvent() {
    return Event(
      id: generateUuidV7String(),
      type: EventTypes.delete,
      targetNodeId: id,
      timestamp: HLC().issueLocalEventPacked(),
      // THINK: happens on the actual insert
      clientId: "toPopulate",
      content: null,
    );
  }
}
