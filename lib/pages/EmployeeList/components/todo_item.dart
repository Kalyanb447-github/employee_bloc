import 'package:flutter/material.dart';

import '../../../models/employee.dart';

class EmployeeItem extends StatelessWidget {
  final Employee employee;

  const EmployeeItem({Key? key, required this.employee}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            employee.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            employee.role,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            children: [
              Text(
                employee.fromDate,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              if (employee.toDate.isNotEmpty)
                const Text(
                  ' - ',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              Text(
                employee.toDate,
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
