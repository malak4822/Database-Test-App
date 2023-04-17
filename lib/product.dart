import 'package:equatable/equatable.dart';

class Product {
  final int id;
  final String name;
  final String thumbnailURL;

  const Product(
      {required this.id, required this.name, required this.thumbnailURL});

  @override
  List<Object?> get props => [id, name, thumbnailURL];

  static List<Product> product = [
    const Product(id: 0, name: 'essa', thumbnailURL: 'esasa'),
    const Product(id: 1, name: 'essaeee', thumbnailURL: 'esaseeea')
  ];
}
