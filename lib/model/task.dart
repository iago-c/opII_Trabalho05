class Task {
  String id;
  String name;
  bool done;

  Task(this.name, this.done, {this.id});

  Map<String, dynamic> toMap() => {
        "name": name,
        "done": done,
      };

  Task.fromJson(Map<String, dynamic> json, String idFirebase)
      : name = json["name"],
        done = json["done"],
        id = idFirebase;

  @override
  String toString() {
    return "Task: $name \n Done: $done";
  }
}
