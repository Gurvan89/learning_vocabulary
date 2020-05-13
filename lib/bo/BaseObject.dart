abstract class BaseObject {
  int id;
  DateTime createdAt;
  DateTime updatedAt;

  BaseObject({this.id, this.createdAt, this.updatedAt}) {
    createdAt = DateTime.now();
    updatedAt = DateTime.now();
  }

  @override
  String toString() {
    return "id: $id, createdAt = $createdAt, updatedAt : $updatedAt ";
  }

  String get lastUpdatedAtToString =>
     "Last updated : ${this.updatedAt.day}-${this.updatedAt.month.toString().padLeft(2,'0')}-${this.updatedAt.year} ${this.updatedAt.hour}:${this.updatedAt.minute.toString().padLeft(2,'0')}";

}
