import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

final String tablename = "todo";
final String column_id = "id";
final String column_name = "name";

class Taskmodel {
  final String name;
  final int id;
  Taskmodel({this.name, this.id});

  Map<String, dynamic> tomap() {
    return {
      column_name: name,
    };
  }
}

class Todohelper {
  Database db;

  Todohelper() {
    initdatabase();
  }

  Future<void> initdatabase() async {
    db = await openDatabase(join(await getDatabasesPath(), "databse.db"),
        onCreate: (db, version) {
      return db.execute(
          "CREATE TABLE $tablename($column_id INTEGER PRIMARY KEY AUTOINCREMENT, $column_name TEXT)");
    }, version: 1);
  }

  Future<void> insertTask(Taskmodel task) async {
    try {
      db.insert(tablename, task.tomap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    } catch (_) {
      print(_);
    }
  }

  Future<List<Taskmodel>> getAllTask() async {
    final List<Map<String, dynamic>> tasks = await db.query(tablename);

    return List.generate(
        tasks.length,
        (index) => Taskmodel(
            name: tasks[index][column_name], id: tasks[index][column_id]));
  }

  Future<List<Taskmodel>> delete(int id) async {
    await db.rawDelete('DELETE FROM $tablename WHERE $id = $column_id');
  }
}
