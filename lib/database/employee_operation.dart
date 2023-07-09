import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/employee.dart';

class EmployeeOperations {
  static const _databaseName = "Employees.db";

  static final EmployeeOperations instance = EmployeeOperations._init();

  static Database? _database;

  EmployeeOperations._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(_databaseName);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  //Column Name
  static const String _tableName = 'employees';
  static const String _id = 'id';
  static const String _name = 'name';
  static const String _role = 'role';
  static const String _fromDate = 'fromDate';
  static const String _toDate = 'toDate';
  static const String _active = 'active';

  // SQL code to create the database table
  Future _createDB(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $_tableName (
            $_id INTEGER PRIMARY KEY,
            $_name TEXT NOT NULL,
            $_role TEXT NOT NULL,
            $_fromDate TEXT NOT NULL,
            $_toDate TEXT NOT NULL,
            $_active BOOLEAN NOT NULL
          )
          ''');
  }

  Future<int> addEmployee(Employee employee) async {
    final db = await instance.database;
    // final Database database = await createDatabase();

    Map<String, dynamic> employeeMap = _toMap(employee);

    return db.insert(_tableName, employeeMap);
  }

  Future<int> deleteEmployee(int? id) async {
    final db = await instance.database;

    // db.update(_tableName,   where: '$_id = ?')

    // get a reference to the database
    // because this is an expensive operation we use async and await

    // row to update
    Map<String, dynamic> row = {
      _active: false,
    };

    // do the update and get the number of affected rows
    int updateCount =
        await db.update(_tableName, row, where: '$_id = ?', whereArgs: [id]);

    return updateCount;

    // show the results: print all rows in the db
    // print(await db.query(DatabaseHelper.table));

    // return db.delete(
    //   _tableName,
    //   where: '$_id = ?',
    //   whereArgs: [id],
    // );
  }

  //Update Todo record
  Future<int> updateEmployee(Employee employee) async {
    final db = await instance.database;

    var result = await db.update(_tableName, employee.toMap(),
        where: "id = ?", whereArgs: [employee.id]);

    return result;
  }

  Future<List<Employee>> getAllEmployee() async {
    final db = await instance.database;

    final List<Map<String, dynamic>> allResults = await db.query(
      _tableName,
    );

    List<Employee> employees = _toList(allResults);

    return employees;
  }

  // Future<List<Employee>> getAllCurrentEmployees() async {
  //   final db = await instance.database;

  //   final List<Map<String, dynamic>> allResults = await db.query(
  //     _tableName,
  //     where: '$_active = ?',
  //     whereArgs: [true],
  //   );

  //   List<Employee> employees = _toList(allResults);

  //   return employees;
  // }

  // Future<List<Employee>> getAllPreviousEmployees() async {
  //   final db = await instance.database;

  //   final List<Map<String, dynamic>> allResults = await db.query(
  //     _tableName,
  //     where: '$_active = ?',
  //     whereArgs: [false],
  //   );

  //   List<Employee> employees = _toList(allResults);

  //   return employees;
  // }

  Map<String, dynamic> _toMap(Employee employee) {
    final Map<String, dynamic> employeeMap = {};
    employeeMap[_id] = employee.id;
    employeeMap[_name] = employee.name;
    employeeMap[_role] = employee.role;
    employeeMap[_fromDate] = employee.fromDate;
    employeeMap[_toDate] = employee.toDate;
    employeeMap[_active] = employee.active;
    return employeeMap;
  }

  List<Employee> _toList(List<Map<String, dynamic>> result) {
    final List<Employee> employees = [];

    for (Map<String, dynamic> row in result) {
      final Employee employee = Employee(
        id: row[_id],
        name: row[_name],
        role: row[_role],
        fromDate: row[_fromDate],
        toDate: row[_toDate],
        active: row[_active] == 0 ? false : true,
      );

      employees.add(employee);
    }
    return employees;
  }
}
