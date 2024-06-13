class Task{
  //initializing properties
  String? dueDate;
  String? todoText;
  String? data_ID;

  //the constructor, takes in and sets the values
  Task({this.dueDate, this.todoText, this.data_ID});

  static List<Task> tasklist(){
    return [
      Task(dueDate: "6/5/2024", todoText: "Homework", data_ID: '100'),
      Task(dueDate: "6/6/2024", todoText: "Gym", data_ID: '101'),

    ];
  }
}