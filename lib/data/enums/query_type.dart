enum QueryType {
  where,
  whereIsNotEqualTo,
  whereArrayContains, // Single value
  whereArrayContainsAny, // array value
  whereGreaterThan,
  whereGreaterThanOrEqual,
  whereLessThan,
  whereLessThanOrEqual,
  whereIn, // array value
  // No Value
  orderBy, // boolean value
  ascendingOrder, // no value
  descendingOrder, // no value
  // No Field
  limit, // int value
  startAt, // Single or Array value
  startAfter, // Single or Array value
  endAt, // Single or Array value
  endBefore, // Single or Array value
}
