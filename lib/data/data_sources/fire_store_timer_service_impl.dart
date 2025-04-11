import 'package:cloud_firestore/cloud_firestore.dart';

import 'i_data_sources/i_fire_store_timer_service.dart';

class FireStoreTimerServiceImpl extends IFireStoreTimerService {
  @override
  DateTime? getDateTimeFromServerTimeStamp(Timestamp serverTimestamp) =>
      serverTimestamp.toDate();

  @override
  FieldValue get serverTimestamp => FieldValue.serverTimestamp();
}
