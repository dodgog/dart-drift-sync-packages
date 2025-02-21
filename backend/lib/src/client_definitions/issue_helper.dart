import 'package:backend/client_definitions.dart';
import 'package:hybrid_logical_clocks/hybrid_logical_clocks.dart';
import 'package:uuidv7/uuidv7.dart';

Event issueRawCreateEventFromNode(Node node, Client client) {
  return Event(
    // THINK: where should assignment of id happen? maybe on insertion?
    // for now it's in a helper function for insertion
    id: generateUuidV7String(),
    // THINK: generation happens here and also on the next stage
    targetNodeId: generateUuidV7String(),
    type: EventTypes.create,
    clientId: client.id,
    timestamp: HLC().issueLocalEventPacked(),
    content: EventContent(
      "wow",
      // THINK where is config values like client and user assigned
      node.userId,
      EventTypes.create,
      node.type,
      node.content,
    ),
  );
}

extension NodeEvents on Node {
  Event issueRawEditEventFromMutatedContent(NodeContent nodeContent,
   Client client, ) {
    return Event(
      id: generateUuidV7String(),
      type: EventTypes.edit,
      targetNodeId: id,
      timestamp: HLC().issueLocalEventPacked(),
      clientId: client.id,
      content: EventContent(
        "wow",
        userId,
        EventTypes.edit,
        type,
        nodeContent,
      ),
    );
  }

  Event issueRawDeleteNodeEvent(Client client) {
    return Event(
      id: generateUuidV7String(),
      type: EventTypes.delete,
      targetNodeId: id,
      timestamp: HLC().issueLocalEventPacked(),
      // THINK perhaps client id could be retrieved from hlc
      clientId: client.id,
      content: null,
    );
  }
}
