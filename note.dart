class Note {
  final int id;
  final String title;
  final String desc;
  final DateTime createdAt;

  Note(
    this.id,
    this.title,
    this.desc,
    this.createdAt,
  );

  Map<String,dynamic> toMap(){
    return {
      "id" : id,
      "title":title,
      "desc":desc,
      "createdAt":createdAt.toIso8601String(),
    };
  }

  factory Note.fromMap(Map<String, dynamic> data){
    return Note(
      data["id"],
      data["title"], 
      data["desc"], 
      DateTime.parse(data["createdAt"]),
    );
  }
}