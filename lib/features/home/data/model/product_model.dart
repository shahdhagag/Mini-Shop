class ProductModel {
  List<Products>? products;
  int? total;
  int? skip;
  int? limit;

  ProductModel({this.products, this.total, this.skip, this.limit});

  ProductModel.fromJson(dynamic json) {
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(Products.fromJson(v));
      });
    }
    total = json['total'];
    skip = json['skip'];
    limit = json['limit'];
  }
}

class Products {
  int? id;
  String? title;
  String? description;
  double? price;
  String? thumbnail; //el soura ely hst5dmha
  List<String>? images; //not this
  int? stock;
  String? category;
  double? rating;
  double? discountPercentage;
  String? brand;

  Products({
    this.id,
    this.title,
    this.description,
    this.price,
    this.thumbnail,
    this.images,
    this.category,
    this.rating,
    this.discountPercentage,
    this.brand,
    this.stock,
  });

  Products.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];

    /// convert int/double to double
    price = (json['price'] as num?)?.toDouble();
    thumbnail = json['thumbnail'];
    images = json['images'] != null ? json['images'].cast<String>() : [];

    category = json['category'];
    rating = (json['rating'] as num?)?.toDouble();
    discountPercentage = (json['discountPercentage'] as num?)?.toDouble();
    brand = json['brand'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['description'] = description;
    map['price'] = price;
    map['thumbnail'] = thumbnail;
    map['images'] = images;
    map['category'] = category;
    map['rating'] = rating;
    map['discountPercentage'] = discountPercentage;
    map['brand'] = brand;
    map['stock'] = stock;
    return map;
  }
}
