// Custom Firestore Exception classes
class FireStoreException implements Exception {
  String message;
  FireStoreException(this.message);
}

//Exception classes
class UnauthorizedException implements FireStoreException {
  @override
  String message = "Unauthorized";
}

class SomethingWentWrongException implements FireStoreException {
  @override
  String message = "Something Went Wrong";
}

class NoInternetConnectionException implements FireStoreException {
  @override
  String message = "No Internet Connection available";
}

class BadResponseFormatException implements FireStoreException {
  @override
  String message = "Bad Response Format";
}

class CanceledException implements FireStoreException {
  @override
  String message = "Operation was canceled.";
}

class UnknownException implements FireStoreException {
  @override
  String message = "Unknown error occurred.";
}

class InvalidArgumentException implements FireStoreException {
  @override
  String message = "Invalid argument provided.";
}

class DeadlineExceededException implements FireStoreException {
  @override
  String message = "Operation timed out.";
}

class NotFoundException implements FireStoreException {
  @override
  String message = "Requested document/resource not found.";
}

class AlreadyExistsException implements FireStoreException {
  @override
  String message = "Document/resource already exists.";
}

class PermissionDeniedException implements FireStoreException {
  @override
  String message = "Permission denied to access data.";
}

class ResourceExhaustedException implements FireStoreException {
  @override
  String message = "Resource has been exhausted.";
}

class FailedPreconditionException implements FireStoreException {
  @override
  String message = "Failed precondition for the operation.";
}

class AbortedException implements FireStoreException {
  @override
  String message = "The operation was aborted.";
}

class OutOfRangeException implements FireStoreException {
  @override
  String message = "Provided value is out of range.";
}

class UnimplementedException implements FireStoreException {
  @override
  String message = "The operation is not implemented or supported.";
}

class InternalException implements FireStoreException {
  @override
  String message = "Internal error occurred.";
}

class UnavailableException implements FireStoreException {
  @override
  String message = "The service is currently unavailable.";
}

class DataLossException implements FireStoreException {
  @override
  String message = "Data loss or corruption occurred.";
}

class UnauthenticatedException implements FireStoreException {
  @override
  String message = "Request does not have valid authentication credentials.";
}

class DevicePlatformException implements FireStoreException {
  @override
  String message = "An unknown platform error occurred.";

  DevicePlatformException([String? customMessage]) {
    if (customMessage != null && customMessage.isNotEmpty) {
      message = customMessage;
    }
  }

  @override
  String toString() {
    return 'PlatformException: $message';
  }
}
