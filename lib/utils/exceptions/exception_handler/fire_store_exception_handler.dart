import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_db_impl/utils/exceptions/fire_store_exceptions.dart';
import 'package:flutter/services.dart';

class FireStoreExceptionHandler {
  static FireStoreException handleException(Object e) {
    if (e is SocketException) {
      throw NoInternetConnectionException();
    } else if (e is FormatException) {
      throw BadResponseFormatException();
    } else if (e is FirebaseException) {
      switch (e.runtimeType) {
        case FirebaseAuthException:
          return UnauthorizedException();
        case CanceledException:
          throw e; // Rethrow the FirebaseException directly
        case UnknownException:
          throw e; // Rethrow the FirebaseException directly
        case InvalidArgumentException:
          throw e; // Rethrow the FirebaseException directly
        case DeadlineExceededException:
          throw e; // Rethrow the FirebaseException directly
        case NotFoundException:
          throw e; // Rethrow the FirebaseException directly
        case AlreadyExistsException:
          throw e; // Rethrow the FirebaseException directly
        case PermissionDeniedException:
          throw e; // Rethrow the FirebaseException directly
        case ResourceExhaustedException:
          throw e; // Rethrow the FirebaseException directly
        case FailedPreconditionException:
          throw e; // Rethrow the FirebaseException directly
        case AbortedException:
          throw e; // Rethrow the FirebaseException directly
        case OutOfRangeException:
          throw e; // Rethrow the FirebaseException directly
        case UnimplementedException:
          throw e; // Rethrow the FirebaseException directly
        case InternalException:
          throw e; // Rethrow the FirebaseException directly
        case UnavailableException:
          throw e; // Rethrow the FirebaseException directly
        case DataLossException:
          throw e; // Rethrow the FirebaseException directly
        case UnauthenticatedException:
          throw e; // Rethrow the FirebaseException directly
        default:
          throw FireStoreException("Firestore Error: ${e.code}");
      }
    } else if (e is PlatformException) {
      return DevicePlatformException(e.message);
    } else {
      throw FireStoreException("Unknown Error");
    }
  }
}

// class FireStoreExceptionHandler {
//   static FirestoreException handleException(Object e) {
//     if (e is SocketException) {
//       throw NoInternetConnectionException();
//     } else if (e is FormatException) {
//       throw BadResponseFormatException();
//     } else if (e is FirebaseException) {
//       if (e is FirebaseAuthException) {
//         return UnauthorizedException();
//       } else if (e is CanceledException) {
//         throw CanceledException();
//       } else if (e is UnknownException) {
//         throw UnknownException();
//       } else if (e is InvalidArgumentException) {
//         throw InvalidArgumentException();
//       } else if (e is DeadlineExceededException) {
//         throw DeadlineExceededException();
//       } else if (e is NotFoundException) {
//         throw NotFoundException();
//       } else if (e is AlreadyExistsException) {
//         throw AlreadyExistsException();
//       } else if (e is PermissionDeniedException) {
//         throw PermissionDeniedException();
//       } else if (e is ResourceExhaustedException) {
//         throw ResourceExhaustedException();
//       } else if (e is FailedPreconditionException) {
//         throw FailedPreconditionException();
//       } else if (e is AbortedException) {
//         throw AbortedException();
//       } else if (e is OutOfRangeException) {
//         throw OutOfRangeException();
//       } else if (e is UnimplementedException) {
//         throw UnimplementedException();
//       } else if (e is InternalException) {
//         throw InternalException();
//       } else if (e is UnavailableException) {
//         throw UnavailableException();
//       } else if (e is DataLossException) {
//         throw DataLossException();
//       } else if (e is UnauthenticatedException) {
//         throw UnauthenticatedException();
//       } else {
//         // Fallback for any other FirebaseException
//         throw FirestoreException("Firestore Error: ${(e).code}");
//       }
//     } else if (e is PlatformException) {
//       return DevicePlatformException(e.message);
//     } else {
//       // Fallback for any other unknown exception
//       throw FirestoreException("Unknown Error");
//     }
//   }
// }
