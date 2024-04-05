
class DrinkDto {
  final int id;
  final String category;
  final String name;
  final String image;
  final String price;
  final int productID;
  final int? counter;

  const DrinkDto(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.category,
      required this.productID,
      this.counter});

  factory DrinkDto.fromJson(Map<String, dynamic> json) {
    return DrinkDto(
      name: json['name'],
      image: json['imageUrl'],
      price: json['prices'][0]['value'],
      id: json['category']['id'],
      category: json['category']['slug'],
      productID: json['id'],
    );
  }

  @override
  String toString() {
    return "name: $name counter: $counter";
  }
}
