import 'package:meta/meta.dart';

@immutable
abstract class ProductsEvent {}

class ShowSnackBar extends ProductsEvent {}

class ChangeValue extends ProductsEvent {}
