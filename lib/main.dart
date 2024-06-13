import 'package:flutter/material.dart';
import 'package:posthog_flutter/posthog_flutter.dart';
import 'entry_card.dart';
import 'task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';
import 'package:pattern_formatter/pattern_formatter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyCKSyX78L03k76Rfj0R8_r0c3582bK-7Ts",
        appId: 'com.example.todolist2',
        messagingSenderId: '543506119299',
        projectId: 'todolist-2cbd4')
  );
  runApp(MaterialApp(
    home: ToDoList(),
  ));
}

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});


  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  CollectionReference collRef = FirebaseFirestore.instance.collection('client');


  final taskController = TextEditingController();
  final dateController = TextEditingController();

  var newTask;
  var newDate;
  var taskList = Task.tasklist();
  String? newID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Color(0xFF528774),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/greenlock.png", height: 60)
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Add Task",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Lucida Sans Unicode"
                  ),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  controller: taskController,
                  onChanged: (Task){
                    setState((){
                      newTask = Task;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Add Task", hintStyle: TextStyle(
                      fontFamily: "Lucida Sans Unicode"
                  ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.circular(9.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.circular(9.0)
                      )
                  ),
                ),
                SizedBox(height: 10.0,),
                TextField(
                  controller: dateController,
                  onChanged: (Date){
                    setState((){
                      newDate = Date;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Add Date", hintStyle: TextStyle(
                      fontFamily: "Lucida Sans Unicode"
                  ),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.circular(9.0)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                          borderRadius: BorderRadius.circular(9.0)
                      )
                  ),
                  inputFormatters: [DateInputFormatter()],
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: ()async {
                        await Posthog().capture(eventName: 'add_task_button_clicked',);
                        newID = randomString(5);
                        collRef.doc(newID).set({'task': taskController.text, 'date': dateController.text,});
                        setState(() {
                          taskList.add(Task(dueDate: newDate, todoText: newTask, data_ID: newID));
                        });
                      },
                      child: Text("Add Task"),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.blue,
                        side: BorderSide(width: 2.0, color: Colors.blue)
                      ),
                  ),
                ]),
                Divider(
                  height: 20,
                ),
                Text("Current Tasks",
                  style: TextStyle(
                      fontSize: 25,
                      fontFamily: "Lucida Sans Unicode"
                  ),
                ),
                for(Task tasklist in taskList)
                  entryCard(taskFinal: tasklist, remove: (){
                    collRef.doc(tasklist.data_ID).delete().then(
                            (doc) => print('Document Deleted'),
                            onError: (e) => print("Error updating document")
                    );
                    setState(() {
                      taskList.remove(tasklist);
                    });
                  },)
              ],
            ),
          ),
        )
    );
  }
}
