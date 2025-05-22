# Changelog

All notable changes to this project will be documented in this file.

## 0.0.2
- Created register Fire Store Data Source Service GetIt DI.
- Update Export File.

## 0.0.1
### Added
- Initial release of `firestore_db_impl` package.
- CRUD operations abstraction over Firestore.
- Stream and Future-based data access.
- `QueryParameter` system with enum-based query types.
- Extension methods:
    - `QueryExtension`
    - `DocumentSnapshotExtension`
    - `QuerySnapshotExtension`
- Custom exception classes for structured error handling.
- Utility services:
    - `FireStoreIteratorServiceImpl` for increment/decrement operations.
    - `FireStoreTimerServiceImpl` for timestamp handling.
