class Device {
  final int id;
  final String description;
  final int quantity;
  final String category;
  final String name;
  final int price;
  final String imageUrl;
  bool isFavorite;

  Device({
    required this.id,
    required this.description,
    required this.quantity,
    required this.category,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['ID'],
      description: json['Description'],
      quantity: json['Quantity'],
      category: json['Category'],
      name: json['Name'],
      price: json['Price'],
      imageUrl: json['ImageURL'],
      isFavorite: json['IsFavorite'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Description': description,
      'Quantity': quantity,
      'Category': category,
      'Name': name,
      'Price': price,
      'ImageURL': imageUrl,
      'IsFavorite': isFavorite,
    };
  }
}
