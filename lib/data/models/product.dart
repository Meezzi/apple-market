class Product {
  final String imageFile;
  final String title;
  final String description;
  final String seller;
  final int price;
  final String address;
  final int likes;
  final int chats;
  final bool isLiked;

  Product({
    required this.imageFile,
    required this.title,
    required this.description,
    required this.seller,
    required this.price,
    required this.address,
    required this.likes,
    required this.chats,
    this.isLiked = false,
  });

  factory Product.fromCsv(List<String> row) {
    return Product(
      imageFile: row[1],
      title: row[2],
      description: row[3],
      seller: row[4],
      price: int.parse(row[5]),
      address: row[6],
      likes: int.parse(row[7]),
      chats: int.parse(row[8]),
      isLiked: false,
    );
  }

  Product copyWith({
    String? imageFile,
    String? title,
    String? description,
    String? seller,
    int? price,
    String? address,
    int? likes,
    int? chats,
    bool? isLiked,
  }) {
    return Product(
      imageFile: imageFile ?? this.imageFile,
      title: title ?? this.title,
      description: description ?? this.description,
      seller: seller ?? this.seller,
      price: price ?? this.price,
      address: address ?? this.address,
      likes: likes ?? this.likes,
      chats: chats ?? this.chats,
      isLiked: isLiked ?? this.isLiked,
    );
  }
}
