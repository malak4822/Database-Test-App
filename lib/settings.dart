import 'package:databaseapp/bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MySettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = BlocProvider.of<CounterBloc>(context);
    return Scaffold(
      body: BlocListener<CounterBloc, int>(
          listener: (context, state) {},
          child: Center(
              child: BlocBuilder<CounterBloc, int>(builder: (context, state) {
            return Text(state.toString());
          }))),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            child: const Icon(Icons.arrow_upward),
            onPressed: () {
              counterBloc.add(CounterEvent.increment);
            },
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            child: const Icon(Icons.arrow_downward),
            onPressed: () {
              counterBloc.add(CounterEvent.decrement);
            },
          ),
        ],
      ),
    );
  }
}























    // final productsBloc = BlocProvider.of<ProductsBloc>(context);


    //           productsBloc.add(ShowSnackBar());

 // body: BlocListener<ProductsBloc, ProductsState>(
      //   listener: (context, state) {
      //     if (state is ProductsSuccess) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         const SnackBar(
      //           backgroundColor: Colors.green,
      //           content: Text('Success'),
      //         ),
      //       );
      //     }
      //   },
      //   child:
      //       BlocBuilder<ProductsBloc, ProductsState>(builder: (context, state) {
      //     if (state is ProductsInitial) {
      //       return const Center(child: Text('Press the Button'));
      //     }
      //     if (state is ProductsLoading) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     if (state is ProductsSuccess) {
      //       return const Center(child: Text('Success'));
      //     }
      //     throw {};
      //   }),
      // ),