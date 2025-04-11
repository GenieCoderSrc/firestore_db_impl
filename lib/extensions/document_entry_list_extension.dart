extension DocumentEntryListExtension on Iterable<MapEntry<String, dynamic>> {
  List<T> mapToModel<T>(
      T Function(Map<String, dynamic>) fromJson, String idField) {
    return map((entry) {
      final Map<String, dynamic> data =
          Map<String, dynamic>.from(entry.value as Map<dynamic, dynamic>);
      data[idField] = entry.key.toString();
      return fromJson(data);
    }).toList();
  }
}
