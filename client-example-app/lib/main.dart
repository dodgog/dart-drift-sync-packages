import 'dart:async';
import 'dart:convert';

import 'package:backend/client_xd.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final supportDir = await getApplicationSupportDirectory();
  print('Application Support Directory: ${supportDir.path}');

  // Create database instance
  final db = ClientDatabase.createInterface(
    initialConfig: ClientDatabaseConfig(
      clientId: "client1", // You should generate this uniquely per device
      userId: "user1", // Get this from your auth system
      userToken: "user1token", // Get this from your auth system
    ),
    executor: driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    ),
  );

  // Define server URL
  const serverUrl =
      'https://5c13-2600-1700-1420-6960-adf7-3198-8477-3cdb.ngrok-free.app/data';
      // 'https://1078-2601-645-c683-3c60-3de5-6e85-cabb-b55e.ngrok-free.app/data';

  // Create JSON communicator function
  Future<Map<String, dynamic>> sendJsonAndGetResponse(
    Map<String, dynamic> data,
  ) async {
    print("Sending request to server: ${jsonEncode(data)}");
    final response = await http.post(
      Uri.parse(serverUrl),
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

  await db.initialize(sendJsonAndGetResponse: sendJsonAndGetResponse);

  runApp(MyApp(db: db));
}

class MyApp extends StatelessWidget {
  final ClientDatabaseInterface db;

  const MyApp({super.key, required this.db});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Document Library',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: MyHomePage(db: db),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final ClientDatabaseInterface db;

  const MyHomePage({super.key, required this.db});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ActionableObject<DocumentNodeObj>> documents = [];
  bool isLoading = true;
  StreamSubscription<void>? _nodesSubscription;
  late NodeHelper nodeHelper;

  @override
  void initState() {
    super.initState();
    nodeHelper = widget.db.getNodeHelper();
    _loadDocuments();
    _setupNodeWatcher();
    // Get node helper from database
  }

  Future<void> _setupNodeWatcher() async {
    try {
      final nodeHelper = widget.db.getNodeHelper();
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

  // Load documents from the database
  Future<void> _loadDocuments() async {
    if (!mounted) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Get all documents
      documents = await nodeHelper.getAllDocuments();

      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error loading documents: $e');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Sync with server
  Future<void> _sync() async {
    try {
      await widget.db.sync();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Sync failed: ${e.toString()}')));
      }
    }
  }

  // Add a new document
  Future<void> _addDocument() async {
    try {
      final nodeHelper = widget.db.getNodeHelper();
      await nodeHelper.create(author: "New Author", title: "New Document");
      await _loadDocuments();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add document: ${e.toString()}')),
      );
    }
  }

  // Delete a document
  Future<void> _deleteDocument(
    ActionableObject<DocumentNodeObj> document,
  ) async {
    try {
      await document.delete();
      await _loadDocuments();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete document: ${e.toString()}')),
      );
    }
  }

  // Edit document title and author
  Future<void> _editDocument(ActionableObject<DocumentNodeObj> document) async {
    final TextEditingController titleController = TextEditingController(
      text: document.nodeObj.title,
    );
    final TextEditingController authorController = TextEditingController(
      text: document.nodeObj.author,
    );

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
                    await document.edit(
                      title: titleController.text,
                      author: authorController.text,
                    );
                    await _loadDocuments();
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Failed to update document: ${e.toString()}',
                        ),
                      ),
                    );
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
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : documents.isEmpty
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
