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
}
