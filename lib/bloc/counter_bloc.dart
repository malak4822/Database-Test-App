import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decrement }

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  // {
  //   on<CounterEvent>((event, emit) async {
  //     emit(CounterLoading());
  //     await Future.delayed(const Duration(seconds: 2));
  //     emit(CounterSuccess());
  //   });
  // }

  Stream<int> mapEventToState(CounterEvent event) async* {
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.decrement:
        yield state - 1;
        break;
    }
    throw (UnimplementedError);
  }
}
