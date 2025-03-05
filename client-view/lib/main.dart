import 'package:backend/client_definitions.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';
import 'package:backend/client_database.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'sync.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supportDir = await getApplicationSupportDirectory();
  print('Application Support Directory: ${supportDir.path}');

  final db = ClientDatabase(
    initialConfig: ClientDatabaseConfig(
      clientId: "client1", // You should generate this uniquely per device
      userId: "user1", // Get this from your auth system
      userToken: "user1token", // Get this from your auth system
    ),
    executor: driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
    ),
  );

  final syncService = DataSyncService(
    serverUrl: 'https://1078-2601-645-c683-3c60-3de5-6e85-cabb-b55e.ngrok-free.app/data',
    db: db,
  );

  runApp(MyApp(db: db, syncService: syncService));
}

class MyApp extends StatelessWidget {
  final ClientDatabase db;
  final DataSyncService syncService;

  const MyApp({super.key, required this.db, required this.syncService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Library',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), useMaterial3: true),
      home: MyHomePage(db: db, syncService: syncService),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ClientDatabase db;
  final DataSyncService syncService;

  const MyHomePage({super.key, required this.db, required this.syncService});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//TODO: instead of loadDocuments, listen to the library updates query stream from the db

class _MyHomePageState extends State<MyHomePage> {
  List<Node> nodes = [];

  @override
  void initState() {
    super.initState();
    _reduce();
    widget.syncService.addListener(_reduce);
  }

  @override
  void dispose() {
    super.dispose();
    widget.syncService.removeListener(_reduce);
  }

  Future<void> _sync() async {
    widget.syncService.sync();
  }

  Future<void> _reduce() async {
    nodes = await widget.db.clientDrift.reduceAllEventsIntoNodes();
    setState(() => {});
  }

  Future<void> _addNode(NodeContent content) async {
    final event = issueRawDocumentCreateEventFromContent(content);
    widget.db.clientDrift.insertLocalEventWithClientId(event);
    _reduce();
  }

  Future<void> _deleteNode(Node node) async {
    final event = node.issueRawDeleteNodeEvent();
    widget.db.clientDrift.insertLocalEventWithClientId(event);
    _reduce();
  }

  Future<void> _mutateNode(Node node, NodeContent newContent) async {
    final event = node.issueRawEditEventFromMutatedContent(newContent);
    widget.db.clientDrift.insertLocalEventWithClientId(event);
    _reduce();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
        actions: [IconButton(icon: const Icon(Icons.synagogue), onPressed: _sync, tooltip: 'Sync from server')],
      ),
      body: ListView.builder(
        itemCount: nodes.where((e) => e.isDeleted == 0).where((e) => e.type == NodeTypes.document).length,
        itemBuilder: (context, index) {
          final node = nodes.where((e) => e.isDeleted == 0).where((e) => e.type == NodeTypes.document).toList()[index];
          return ListTile(
            title: Text(node.content.title! + node.id),
            subtitle: Text(node.content.author!),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () async {
                _deleteNode(node);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNode(NodeContent(NodeTypes.document, "author", "title", ["list", "of", "strings"])),
        tooltip: 'Add Document',
        child: const Icon(Icons.add),
      ),
    );
  }
}
