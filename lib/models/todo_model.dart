class TodoModel {
  String? id;
  String? taskName;
  String? taskDescription;
  String? status;
  String? currentDate;

  TodoModel(
      {this.id,
      this.taskName,
      this.taskDescription,
      this.status,
      this.currentDate});

  TodoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskName = json['taskName'];
    taskDescription = json['taskDescription'];
    status = json['status'];
    currentDate = json['currentDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_name'] = taskName;
    data['task_description'] = taskDescription;
    data['status'] = status;
    data['current_date'] = currentDate;
    return data;
  }

  @override
  String toString() {
    return "id:$id taskname:$taskName taskDescription:$taskDescription ";
  }
}
