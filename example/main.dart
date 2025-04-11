import 'package:flutter/material.dart';
import 'package:firestore_db_impl/firestore_db_impl.dart';

void main() {
  runApp(const FirestoreExampleApp());
}

class FirestoreExampleApp extends StatelessWidget {
  const FirestoreExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore DB Impl Example',
      home: const FirestoreHomePage(),
    );
  }
}

class FirestoreHomePage extends StatefulWidget {
  const FirestoreHomePage({super.key});

  @override
  State<FirestoreHomePage> createState() => _FirestoreHomePageState();
}

class _FirestoreHomePageState extends State<FirestoreHomePage> {
  final FireStoreDbCrudServiceImpl _service = FireStoreDbCrudServiceImpl();
  final String _collectionPath = 'users';
  String? _docId;
  List<Map<String, dynamic>?> _users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    final results = await _service.getAllDocuments(collectionPath: _collectionPath);
    setState(() {
      _users = results ?? [];
    });
  }

  Future<void> _addUser() async {
    final id = await _service.saveDocument(
      collectionPath: _collectionPath,
      data: {'name': 'New User', 'role': 'admin'},
    );
    setState(() {
      _docId = id;
    });
    await _loadUsers();
  }

  Future<void> _updateUser() async {
    if (_docId == null) return;
    await _service.updateDocument(
      collectionPath: _collectionPath,
      id: _docId!,
      data: {'name': 'Updated User'},
    );
    await _loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Example')),
      body: ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          return ListTile(
            title: Text(user?['name'] ?? 'No Name'),
            subtitle: Text(user?['role'] ?? 'No Role'),
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: 'add',
            onPressed: _addUser,
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: 'update',
            onPressed: _updateUser,
            child: const Icon(Icons.update),
          ),
        ],
      ),
    );
  }
}
