class ProductModel {
  int? id;
  String? name;
  String? prize;

  ProductModel({
    this.id,
    required this.name,
    required this.prize
  });

  factory ProductModel.fromjson(Map<String,dynamic>json){
    return ProductModel(
        id: json['id'] ?? 0,
        name: json['name'] ?? '',
        prize: json['prize'] ?? ''
      );
  }
  Map<String, dynamic>tojson() => {
    'id' : id,
    'name' : name,
    'prize' : prize,
  };
}