class Cat {
  final String name;
  final String age;
  final String bmi;
  final String image;

  Cat({
    required this.name,
    required this.age,
    required this.bmi,
    required this.image,
  });

  // Konversi Cat ke Map
  Map<String, String> toMap() {
    return {
      'name': name,
      'age': age,
      'bmi': bmi,
      'image': image,
    };
  }

  // Konversi Map ke Cat
  factory Cat.fromMap(Map<String, dynamic> map) {
    return Cat(
      name: map['name'],
      age: map['age'],
      bmi: map['bmi'],
      image: map['image'],
    );
  }
}