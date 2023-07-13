import 'package:employee_bloc/models/employee.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../bloc/employee_bloc.dart';
import '../../../database/employee_operation.dart';
import '../components/EmployeeNameTextFieldWidget.dart';
import '../components/FormDatePickerWidget.dart';
import '../components/SelectRoleWidget.dart';
import '../components/ToDatePickerWidget.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final fromDateTextEditingController = TextEditingController();
  final toDateTextEditingController = TextEditingController();

  final DateRangePickerController formDateRangePickerController =
      DateRangePickerController();
  final DateTime today = DateTime.now();

  final EmployeeOperations _employeeOperations = EmployeeOperations.instance;
  // final EmployeeBloc todoBloc = EmployeeBloc();

  @override
  void initState() {
    super.initState();

    formDateRangePickerController.selectedDate = today;
  }

  @override
  void dispose() {
    _nameController.dispose();

    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data

      try {
        var employee = Employee(
            name: _nameController.text,
            role: _roleController.text,
            fromDate: fromDateTextEditingController.text,
            toDate: toDateTextEditingController.text,
            active: true);
        _employeeOperations.addEmployee(employee);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("New employee added"),
          ),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Something went wrong"),
          ),
        );
      }
      // Here, you can perform actions like saving the employee details to a database
      // or sending them to an API

      // Reset the form
      _formKey.currentState!.reset();
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  EmployeeNameTextFieldWidget(nameController: _nameController),
                  const SizedBox(
                    height: 20,
                  ),
                  SelectRoleWidget(roleController: _roleController),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormDatePickerWidget(
                          fromDateTextEditingController:
                              fromDateTextEditingController,
                          formDateRangePickerController:
                              formDateRangePickerController,
                          today: today,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Expanded(
                        child: ToDatePickerWidget(
                          toDateTextEditingController:
                              toDateTextEditingController,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 221, 238, 248),
                                elevation: 0),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              'Cancel',
                              style: TextStyle(color: ThemeData().primaryColor),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(elevation: 0),
                            onPressed: () {
                              _submitForm();
                            },
                            child: const Text(
                              'Save',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
