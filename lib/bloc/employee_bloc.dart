// import 'package:employee_bloc/models/employee.dart';

// import 'dart:async';

// import '../database/employee_operation.dart';

// class EmployeeBloc {
//   //Get instance of the Repository
//   final employeeOperations = EmployeeOperations.instance;

//   //Stream controller is the 'Admin' that manages
//   //the state of our stream of data like adding
//   //new data, change the state of the stream
//   //and broadcast it to observers/subscribers
//   final _employeeController = StreamController<List<Employee>>.broadcast();

//   get employeeList => _employeeController.stream;

//   EmployeeBloc() {
//     getAllEmployee();
//   }

//   getAllEmployee() async {
//     //sink is a way of adding data reactively to the stream
//     //by registering a new event
//     _employeeController.sink.add(await employeeOperations.getAllEmployee());
//   }

//   addEmployee(Employee employee) async {
//     await employeeOperations.addEmployee(employee);
//     getAllEmployee();
//   }

//   updateEmployee(Employee employee) async {
//     await employeeOperations.updateEmployee(employee);
//     getAllEmployee();
//   }

//   deleteEmployee(int? id) async {
//     employeeOperations.deleteEmployee(id);
//     getAllEmployee();
//   }

//   dispose() {
//     _employeeController.close();
//   }
// }
