// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Employee {
  final int? id;
  late final String name;
  late final String role;
  late final String fromDate;
  late final String toDate;
  late final bool? active;
  Employee({
    this.id,
    required this.name,
    required this.role,
    required this.fromDate,
    required this.toDate,
    this.active,
  });

  Employee copyWith({
    int? id,
    String? name,
    String? role,
    String? fromDate,
    String? toDate,
    bool? active,
  }) {
    return Employee(
      id: id ?? this.id,
      name: name ?? this.name,
      role: role ?? this.role,
      fromDate: fromDate ?? this.fromDate,
      toDate: toDate ?? this.toDate,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'role': role,
      'fromDate': fromDate,
      'toDate': toDate,
      'active': active,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Employee(id: $id, name: $name, role: $role, fromDate: $fromDate, toDate: $toDate, active: $active)';
  }

  @override
  bool operator ==(covariant Employee other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.role == role &&
        other.fromDate == fromDate &&
        other.toDate == toDate &&
        other.active == active;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        role.hashCode ^
        fromDate.hashCode ^
        toDate.hashCode ^
        active.hashCode;
  }
}
