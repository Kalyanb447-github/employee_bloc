import 'package:employee_bloc/pages/add_page/view/add_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../../../database/employee_operation.dart';
import '../../../models/employee.dart';
import '../components/todo_item.dart';

class EmployeeList extends StatefulWidget {
  const EmployeeList({Key? key}) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  final String _errorText = 'Error';
  final String _loadingText = 'Loading employees...';

  final EmployeeOperations _employeeOperations = EmployeeOperations.instance;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee List'),
      ),
      body: FutureBuilder<List<Employee>>(
        initialData: const [],
        future: _employeeOperations.getAllEmployee(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.waiting:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_loadingText),
                  ],
                ),
              );

            case ConnectionState.done:
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
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                );
              } else {
                Iterable<Employee> currentEmployees =
                    employees!.where((element) => element.active == true);

                Iterable<Employee> previousEmoloyee =
                    employees!.where((element) => element.active == false);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      //* current employee
                      ListTile(
                        contentPadding:
                            EdgeInsets.only(top: 0, bottom: 0, left: 15),
                        title: Text(
                          'Current employee',
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Card(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                                      _employeeOperations
                                          .deleteEmployee(employee.id)
                                          .then((id) => {setState(() {})});
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
                          style:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                      ),

                      Card(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
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
                  ),
                );
              }
          }
          return Text(_errorText);
        },
      ),
      floatingActionButton: FloatingActionButton(
        shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4)),
        onPressed: () {
          Navigator.of(context)
              .push(
                MaterialPageRoute(builder: (context) => const AddPage()),
              )
              .then((value) => setState(() {}));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
