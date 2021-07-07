import 'package:flutter/material.dart';
import 'package:sqliteproject/taskmodel.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "sqlite demo",
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textcontroller = TextEditingController();

  List<Taskmodel> tasks = [];

  Taskmodel currenttask;

  final Todohelper helper = new Todohelper();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: EdgeInsets.all(32),
        child: new Column(
          children: [
            TextField(
              controller: textcontroller,
            ),
            FlatButton(
              onPressed: () {
                currenttask = Taskmodel(name: textcontroller.text);
                helper.insertTask(currenttask);
              },
              child: new Text("insert"),
              color: Colors.blue,
              textColor: Colors.white,
            ),
            FlatButton(
              onPressed: () async {
                List<Taskmodel> list = await helper.getAllTask();
                setState(() {
                  tasks = list;
                });
              },
              child: new Text("show all task"),
              color: Colors.red,
              textColor: Colors.white,
            ),
            Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: new Text("${tasks[index].id}"),
                        title: new Text("${tasks[index].name}"),
                      );
                    },
                    separatorBuilder: (context, index) => Divider(),
                    itemCount: tasks.length))
          ],
        ),
      ),
    );
  }
}
