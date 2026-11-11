class Teacher {
  final String Id;
  final int Age;
  final String Name;
  final String Email;

  Teacher({
   required this.Id,
    required this.Name,
   required this.Email,
   required this.Age,
});
  factory Teacher.fromJson(Map<String,dynamic>json){
    return Teacher(
        Id: (json ['id'] ?? '').toString(),
        Age: json['age'] ?? 0,
        Name: (json ['name'] ?? '').toString(),
        Email: (json ['email'] ?? '').toString(),
    );
  }

  Map<String,dynamic>toJson(){
    return {
      'Id': Id,
      'Age': Age,
      'Name': Name,
      'Email': Email,
    };
  }
}