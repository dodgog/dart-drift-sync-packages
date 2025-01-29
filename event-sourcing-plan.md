@all
Events
	id text not null # uuid 
	clientId text not null reference client->id
	serverTimeStamp text
	clientTimeStamp text not null
	content text (maybe? json to begin with, but is intended to be flattened)

@server
Users
	id text
	name text
	token text

@server
Clients
	id text
	userId text reference user->id
	lastSyncTime text


@client
Config
	isClient bool
	lastSyncTime text
	clientId # unique for device
	userToken
	
# not used for now, but could be used in the future
# on server and with a distributed protocol on client too
AuthentificatedUsers
	user_id text reference user->id
	token text

=== first-level db api

@all
function
List<Node> getNodes(List<User> users){
	reduce events into nodes
	initially support create, delete, then eventually add edit field or sth

    entry should be 1:1 mappable to a json object

    apply events in order to construct an object representing the state of the
    graph
    applying create creates an entry
    applying delete deletes an entry if it already exists
    applying update updates an entry if an entry exists

	# eventually reconstructs partially from available snapshots
    we are lucky in our case a snapshot is just a state of all the nodes of a
    system at a given time, so essentially the output of this function,
    List<Node>.
}
perhaps a thing called: getdocumentnodes to speed things up

@client
function
appendLocalEvent(EventContent content, String clientId) {
	append to the Events table
	only set clientTimeStamp
}

@client
function
List<Event> getEventsNotStamped(String clientId) {
	list events which happened since lastSyncTime for client
}

@client
function
replaceEventsAccordingToServerResponse
	(localEvents List<Event>, serverEvents List<Event>, serverTimeStamp) {

	set lastSyncTime to serverTimeStamp
	
}

@server
should be limited to one write to the event db per user
function
(List<Event>, lastServerSyncTime) incorporateEvents 
    (List<Event>, lastClientSyncTime){
	incorporate events which happened on the client
	since last sync at lastClientSyncTime into the server's event list
    in most cases, just append if the last time the user wrote to server was
    earlier than lastClientSyncTime, but could also deny or only partially
    write.

	limited to one write per user

	update Clients->lastSyncedTime

	return the events which were incorporated
	and the time at which the operation completed

	since this is a sync/multiplayer system, then the responce would also
	contain relevant events made by another client or user
}

CQRS says: don't write where you read.
so writing to an abstract "node" should not be linked to immediately reading
from it.
therefore, since writing to an abstract node is expected to trigger an event and
only then make it to a read, there is no need to have "writing to the abstract
node" as an intermediate state.

TODO:
- hybrid clock
- concurrent writes
- sharing
- crdt data structures

=== second-level api

read:
    get documents

write:
    add document

    edit document metadata

    delete document




