import 'package:firestore_db_impl/data/enums/query_type.dart';
import 'package:flutter/material.dart';

class QueryParameter {
  final QueryType type;
  // final Operator? operator;
  final String? field;
  final dynamic value;

  QueryParameter({
    required this.type,
    this.field,
    this.value,
  });
}

class QueryFilter {
  final String? id;
  final String? name;
  final IconData? icon;

  final List<QueryParameter>? queryParameters;

  QueryFilter({this.id, this.name, this.icon, this.queryParameters});
}
