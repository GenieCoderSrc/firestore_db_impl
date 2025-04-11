import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFireStoreIteratorService {
  // Returns a FieldValue to decrement a numeric field in Firestore by 1.
  FieldValue get decrementFieldValue;

  // Returns a FieldValue to increment a numeric field in Firestore by 1.
  FieldValue get incrementFieldValue;
}
