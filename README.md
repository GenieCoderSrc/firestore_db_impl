# firestore_db_impl

`firestore_db_impl` is a Flutter package that provides an implementation layer over Firebase Cloud Firestore for easier and more consistent CRUD operations, querying, and error handling. It aims to reduce boilerplate and standardize interactions with Firestore, allowing developers to focus more on business logic.

## Features

- Simplified Firestore CRUD operations
- Stream and Future-based data retrieval
- Structured exception handling
- Query parameter abstraction with enums
- Firestore timestamp and counter utilities
- Extensible and modular architecture

## Getting Started

### Installation
Add the following to your `pubspec.yaml`:
```yaml
resolution: workspace

dependencies:
  firestore_db_impl: <latest_version>
```

### Import
```dart
import 'package:firestore_db_impl/firestore_db_impl.dart';
```

## Usage

### Save a Document
```dart
final service = FireStoreDbCrudServiceImpl();
String? docId = await service.saveDocument(
  data: {'name': 'John Doe'},
  collectionPath: 'users',
);
```

### Update a Document
```dart
await service.updateDocument(
  collectionPath: 'users',
  id: docId,
  data: {'name': 'Jane Doe'},
);
```

### Query Documents
```dart
final queryParams = [
  QueryParameter(type: QueryType.where, field: 'role', value: 'admin'),
];
List<Map<String, dynamic>?>? results = await service.getAllDocuments(
  collectionPath: 'users',
  queryParameters: queryParams,
);
```

### Stream Documents
```dart
Stream<List<Map<String, dynamic>?>?> userStream = service.getStreamAllDocuments(
  collectionPath: 'users',
);
```

### Get a Document by ID
```dart
Map<String, dynamic>? user = await service.getDocumentById(
  collectionPath: 'users',
  id: docId,
);
```

## Extensions
- `QueryExtension`: Apply `QueryParameter` to Firestore queries
- `DocumentSnapshotExtension`: Convert Firestore snapshots to maps or models
- `QuerySnapshotExtension`: Convert query results to a list or map

## Error Handling
This package provides a robust error-handling system through custom exceptions:
- `NoInternetConnectionException`
- `UnauthorizedException`
- `BadResponseFormatException`
- `FireStoreException`, and more

## Utility Services
- `FireStoreIteratorServiceImpl`: Increment/Decrement field values
- `FireStoreTimerServiceImpl`: Server timestamp handling

## Dependencies
- `cloud_firestore`
- `flutter`

## License
MIT License

