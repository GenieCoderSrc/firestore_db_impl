import 'package:cloud_firestore/cloud_firestore.dart';

import 'i_data_sources/i_fire_store_Iterator_service.dart';

class FireStoreIteratorServiceImpl extends IFireStoreIteratorService {
  @override
  FieldValue get decrementFieldValue => FieldValue.increment(-1);

  @override
  FieldValue get incrementFieldValue => FieldValue.increment(1);
}
