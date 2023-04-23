import 'package:bloc/bloc.dart';
import 'package:databaseapp/bloc/products_event.dart';
import 'package:databaseapp/bloc/products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ShowSnackBar>((event, emit) async {
      emit(ProductsLoading());
      await Future.delayed(const Duration(seconds: 3));
      emit(ProductsSuccess());
    });
  }
}
