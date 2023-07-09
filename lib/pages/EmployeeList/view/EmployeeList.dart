import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../bloc/employee_bloc.dart';
import '../../../database/employee_operation.dart';
import '../../../models/employee.dart';
import '../components/todo_item.dart';

class EmployeeList extends StatelessWidget {
  final String _errorText = 'Error';
  final String _loadingText = 'Loading employees...';

  // final EmployeeOperations _employeeOperations = EmployeeOperations.instance;

  final EmployeeBloc todoBloc = EmployeeBloc();

  EmployeeList({super.key});

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: StreamBuilder<List<Employee>>(
        initialData: const [],
        stream: todoBloc.employeeList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            /*Also handles whenever there's stream
      but returned returned 0 records of Todo from DB.
      If that the case show user that you have empty Todos
      */
            final List<Employee>? employees = snapshot.data;

            if (snapshot.data?.length == 0) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      height: width * .5,
                      width: width * .5,
                      image: const AssetImage('images/search_image.png'),
                      fit: BoxFit.cover,
                    ),
                    const Text(
                      'No employee record found',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              );
            } else {
              Iterable<Employee> currentEmployees =
                  employees!.where((element) => element.active == true);

              Iterable<Employee> previousEmoloyee =
                  employees!.where((element) => element.active == false);

              return Column(
                children: [
                  //* current employee
                  ListTile(
                    contentPadding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 15),
                    title: Text(
                      'Current employee',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Card(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: currentEmployees.length,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.grey,
                          thickness: .05,
                        );
                      },
                      itemBuilder: (context, index) {
                        final Employee employee =
                            currentEmployees.elementAt(index);

                        return Slidable(
                          // Specify a key if the Slidable is dismissible.
                          key: ValueKey(employee.id),
                          // The end action pane is the one at the right or the bottom side.
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  // _employeeOperations
                                  //     .delete(employee.id)
                                  //     .then((id) => {setState(() {})});
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                              ),
                            ],
                          ),

                          child: EmployeeItem(
                            employee: employee,
                          ),
                        );
                      },
                    ),
                  ),

                  //* Previous employee
                  ListTile(
                    contentPadding:
                        EdgeInsets.only(top: 0, bottom: 0, left: 15),
                    title: Text(
                      'Previous employee',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),

                  Card(
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: previousEmoloyee?.length ?? 0,
                      separatorBuilder: (context, index) {
                        return const Divider(
                          color: Colors.grey,
                          thickness: .05,
                        );
                      },
                      itemBuilder: (context, index) {
                        final Employee employee =
                            previousEmoloyee.elementAt(index);

                        return EmployeeItem(
                          employee: employee,
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_loadingText),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onPressed: () {
          // Navigator.of(context)
          //     .push(
          //       MaterialPageRoute(builder: (context) => const AddPage()),
          //     )
          //     .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
