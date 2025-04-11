import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IFireStoreTimerService {
  // Returns a server timestamp that can be used to store the current server time in Firestore.
  FieldValue get serverTimestamp;

  // Converts a Firestore Timestamp to a DateTime object.
  DateTime? getDateTimeFromServerTimeStamp(Timestamp serverTimestamp);
}
