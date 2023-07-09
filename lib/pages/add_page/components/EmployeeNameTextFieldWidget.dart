import 'package:flutter/material.dart';

class EmployeeNameTextFieldWidget extends StatelessWidget {
  const EmployeeNameTextFieldWidget({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _nameController,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please enter a name';
        }
        return null;
      },
      decoration: InputDecoration(
        // label: Text('Employee name'),
        hintText: 'Employee name',
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.all(15),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.circular(5),
        // ),
        prefixIcon: Icon(
          Icons.person_outline,
          color: Theme.of(context).primaryColor,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.grey, width: .3),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: Colors.grey, width: .3),
        ),
      ),
    );
  }
}
