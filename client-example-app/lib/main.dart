import 'dart:async';
import 'dart:convert';

import 'package:backend/core_data_library.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<Map<String, dynamic>> sendJsonAndGetResponse(
  String url,
  Map<String, dynamic> data,
) async {
  print("Sending request to server: ${jsonEncode(data)}");
  final response = await http.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(data),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception(
      'Failed to communicate with server: ${response.statusCode}',
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final coreDataInterface = CoreDataInterface.create(
    initialConfig: CoreDataClientConfig(
      // unique per device
      clientId: "client1",
      // from auth
      userId: "user1",
      userToken: "user1token",
    ),
    executor: driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    ),
  );

  const serverUrl =
      'https://5c13-2600-1700-1420-6960-adf7-3198-8477-3cdb.ngrok-free.app/data';

  await coreDataInterface.initializeWebMessageChannel(
    sendJsonAndGetResponse:
        (Map<String, dynamic> json) => sendJsonAndGetResponse(serverUrl, json),
  );

  runApp(MyApp(db: coreDataInterface));
}

class MyApp extends StatelessWidget {
  final CoreDataInterface db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(coreDataInterface: db),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final CoreDataInterface coreDataInterface;

  const MyHomePage({super.key, required this.coreDataInterface});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ActionableNodeObject<DocumentNodeObj>> documents = [];
  StreamSubscription<void>? _nodesSubscription;
  late NodeHelper nodeHelper;

  @override
  void initState() {
    super.initState();
    nodeHelper = widget.coreDataInterface.getNodeHelper();
    _loadDocuments();
    _setupNodeWatcher();
  }

  Future<void> _setupNodeWatcher() async {
    try {
      final nodeHelper = widget.coreDataInterface.getNodeHelper();
      final watchStream = await nodeHelper.watch();
      _nodesSubscription = watchStream.listen((_) {
        _loadDocuments();
      });
    } catch (e) {
      print('Error setting up node watcher: $e');
    }
  }

  @override
  void dispose() {
    _nodesSubscription?.cancel();
    super.dispose();
  }

  Future<void> _loadDocuments() async {
    try {
      final newDocuments = await nodeHelper.getAllDocuments();
      // did anything change: get added to the list?
      if (!doActionableNodeListsContainSameNodeIds(newDocuments, documents)) {
        setState(() {
          documents = newDocuments;
        });
      }
      return;
    } catch (e) {
      print('Error loading documents: $e');
    }
  }

  // Command to sync with server
  Future<void> _sync() async {
    try {
      await widget.coreDataInterface.sync();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sync failed: ${e.toString()}')));
      }
    }
  }

  Future<void> _addDocument() async {
    try {
      final nodeHelper = widget.coreDataInterface.getNodeHelper();
      await nodeHelper.create(author: "New Author", title: "New Document");
      // Load documents happens automatically
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add document: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _deleteDocument(
    ActionableNodeObject<DocumentNodeObj> document,
  ) async {
    try {
      // TODO: perhaps each document could have its own animated builder so
      //  we don't rebuild the whole thing
      await document.delete();
      setState(() {});
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to delete document: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _editDocument(
    ActionableNodeObject<DocumentNodeObj> document,
  ) async {
    final TextEditingController titleController = TextEditingController(
      text: document.nodeObj.title,
    );
    final TextEditingController authorController = TextEditingController(
      text: document.nodeObj.author,
    );
    if (!mounted) return;

    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Edit Document'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: authorController,
                  decoration: const InputDecoration(labelText: 'Author'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    Navigator.pop(context);
                    // TODO: perhaps each document could have its own animated builder so
                    //  we don't rebuild the whole thing
                    await document.edit(
                      title: titleController.text,
                      author: authorController.text,
                    );
                    setState(() {});
                  } catch (e) {
                    print("Problem editing document");
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documents'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: _sync,
            tooltip: 'Sync with server',
          ),
        ],
      ),
      body:
          documents.isEmpty
              ? const Center(child: Text('No documents found'))
              : ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final doc = documents[index];
                  // Skip deleted documents
                  if (doc.nodeObj.isDeleted) {
                    return const SizedBox.shrink();
                  }

                  return ListTile(
                    title: Text(doc.nodeObj.title),
                    subtitle: Text(doc.nodeObj.author),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () => _editDocument(doc),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteDocument(doc),
                        ),
                      ],
                    ),
                    onTap: () => _editDocument(doc),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDocument,
        tooltip: 'Add Document',
        child: const Icon(Icons.add),
      ),
    );
  }
}
