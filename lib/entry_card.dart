import 'package:flutter/material.dart';
import 'task.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class entryCard extends StatelessWidget {
  final CollectionReference collRef = FirebaseFirestore.instance.collection('client');

  final VoidCallback remove;
  late final Task taskFinal;

  entryCard({required this.taskFinal, required this.remove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(16, 16, 16, 0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.black, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(taskFinal.todoText.toString(),
              style: TextStyle(
                fontSize: 18.0,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 6.0,),
            Text(taskFinal.dueDate.toString(),
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.red[800],
              ),
            ),
            SizedBox(height: 4.0,),
            ElevatedButton.icon(
                onPressed: remove,
                icon: Icon(
                    Icons.delete,
                    color: Colors.grey[800],
                ),
                label: Text(
                  "Delete Task",
                  style: TextStyle(
                    color: Colors.grey[800]
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(Colors.grey[300])
                ),
            )
          ],
        ),
      ),
    );
  }
}


