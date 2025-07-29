import 'package:firestore_db_impl/data/data_sources/fire_store_db_crud_service_impl.dart';
import 'package:firestore_db_impl/data/data_sources/i_data_sources/i_fire_store_db_crud_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:get_it_di_global_variable/get_it_di.dart';

void registerFireStoreDataSourceServiceGetItDI() {
  /// ----------------- Firebase--------------
  // Register DatabaseReference
  sl.registerSingleton<FirebaseDatabase>(FirebaseDatabase.instance);
  // final FirebaseInstance firebaseService = FirebaseInstance.getInstance;

  /// Service
  sl.registerLazySingleton<IFireStoreDbCrudService>(
    () => FireStoreDbCrudServiceImpl(),
  );
}
