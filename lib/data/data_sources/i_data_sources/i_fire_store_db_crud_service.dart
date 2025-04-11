
import 'package:firestore_db_impl/data/modlels/query_parameter.dart';

abstract class IFireStoreDbCrudService {
  Future<String?> saveDocument(
      {required Map<String, dynamic> data,
      required String collectionPath,
      String? successTxt});

  Future<bool> setDocument(
      {required Map<String, dynamic> data,
      required String collectionPath,
      required String id,
      bool merge = true,
      String? successTxt});

  Future<bool> updateDocument(
      {required Map<String, dynamic> data,
      required String collectionPath,
      required String id,
      String? successTxt});

  Future<bool> removeDocument({
    required String collectionPath,
    required String id,
    String? successTxt,
  });

  Future<Map<String, dynamic>?> getDocumentById(
      {required String collectionPath, required String id});

  Future<List<Map<String, dynamic>?>?> getAllDocuments(
      {required String collectionPath, List<QueryParameter>? queryParameters});

  Stream<List<Map<String, dynamic>?>?> getStreamAllDocuments(
      {required String collectionPath, List<QueryParameter>? queryParameters});

// Future<Map<dynamic, dynamic>?> getAllDocuments({required String path});
// Stream<Map<String, dynamic>?> getStreamAllDocuments({required String path});
}
