import 'package:flutter/material.dart';

class SelectRoleWidget extends StatelessWidget {
  const SelectRoleWidget({
    super.key,
    required TextEditingController roleController,
  }) : _roleController = roleController;

  final TextEditingController _roleController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _roleController,
      onTap: () {
        ShowBottomSheet(context);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Please Select a Role';
        }
        return null;
      },
      readOnly: true,
      decoration: InputDecoration(
        hintText: 'Select Role',
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.all(15),
        prefixIcon: Icon(
          Icons.badge,
          color: Theme.of(context).primaryColor,
        ),
        suffixIcon: Icon(
          Icons.arrow_drop_down,
          color: Theme.of(context).primaryColor,
          size: 35,
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

  Future<dynamic> ShowBottomSheet(BuildContext context) {
    List<String> roles = [
      'Product Designer',
      'Flutter Developer',
      'QA Tester',
      'Product Owner'
    ];

    return showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      )),
      context: context,
      builder: (BuildContext context) {
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: roles.length,
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              thickness: .3,
            );
          },
          itemBuilder: (context, index) {
            String role = roles[index];
            return ListTile(
              onTap: () {
                _roleController.text = role;
                Navigator.pop(context);
              },
              title: Center(
                child: Text(role),
              ),
            );
          },
        );
      },
    );
  }
}
