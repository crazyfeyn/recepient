class Ingredient {
  String name;
  int quantity;
  String type;
  bool isSelected;

  Ingredient(
      {required this.name,
      required this.quantity,
      required this.type,
      required this.isSelected});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'type': type,
      'isSelected': isSelected
    };
  }

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
        name: json['name'],
        quantity: json['quantity'],
        type: json['type'],
        isSelected: json['isSelected']);
  }
}
