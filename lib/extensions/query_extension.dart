import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_db_impl/data/enums/query_type.dart';
import 'package:firestore_db_impl/data/modlels/query_parameter.dart';

extension QueryExtension on Query<Object?> {
  Query<Object?> applyQueryParameters(List<QueryParameter>? queryParameters) {
    Query<Object?> query = this;

    if (queryParameters != null) {
      for (QueryParameter param in queryParameters) {
        if (param.field == null) {
          query = applySingleHelperQueryParameter(query, param);
        } else {
          query = applySingleFieldQueryParameter(query, param);
        }
      }
    }

    return query;
  }

  Query<Object?> applySingleFieldQueryParameter(
    Query<Object?> query,
    QueryParameter param,
  ) {
    String? field = param.field;
    if (field == null) {
      return query;
    }
    switch (param.type) {
      case QueryType.where:
        return query.where(field, isEqualTo: param.value);
      case QueryType.whereIsNotEqualTo:
        return query.where(field, isNotEqualTo: param.value);
      case QueryType.whereArrayContains:
        return query.where(field, arrayContains: param.value);
      case QueryType.whereArrayContainsAny:
        return query.where(field, arrayContainsAny: param.value);
      case QueryType.whereGreaterThan:
        return query.where(field, isGreaterThan: param.value);
      case QueryType.whereGreaterThanOrEqual:
        return query.where(field, isGreaterThanOrEqualTo: param.value);
      case QueryType.whereLessThan:
        return query.where(field, isLessThan: param.value);
      case QueryType.whereLessThanOrEqual:
        return query.where(field, isLessThanOrEqualTo: param.value);
      case QueryType.whereIn:
        return query.where(field, whereIn: param.value);
      case QueryType.orderBy:
        return query.orderBy(field, descending: param.value ?? false);
      case QueryType.ascendingOrder:
        return query.orderBy(field, descending: false);
      case QueryType.descendingOrder:
        return query.orderBy(field, descending: true);
      default:
        return query;
    }
  }

  Query<Object?> applySingleHelperQueryParameter(
    Query<Object?> query,
    QueryParameter param,
  ) {
    switch (param.type) {
      case QueryType.limit:
        return query.limit(param.value);
      case QueryType.startAt:
        return query.startAt([param.value]);
      case QueryType.startAfter:
        return query.startAfter([param.value]);
      case QueryType.endAt:
        return query.endAt([param.value]);
      case QueryType.endBefore:
        return query.endBefore([param.value]);
      default:
        return query;
    }
  }
}
