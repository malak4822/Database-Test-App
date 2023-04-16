import 'package:bloc/bloc.dart';
import 'package:databaseapp/card.dart';
import 'package:databaseapp/product.dart';

import 'package:equatable/equatable.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc(super.initialState);

  @override
  ProductsState get initialState => ProductsInitial();

  @override
  Stream<ProductsState> mapEventToState(
    ProductsEvent event,
  ) async* {
    if (event is ProductInitial) {
      yield ProductLoading();
    }
  }
}
