part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class ProductInitial extends ProductsEvent {}

class ProductLoading extends ProductsState {}

class ProductLoaded extends ProductsEvent {
  final Product product;
  const ProductLoaded(this.product);

  @override
  List<Object> get props => [product];
}
