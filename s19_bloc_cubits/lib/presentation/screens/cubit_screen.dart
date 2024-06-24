import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s19_bloc_cubits/presentation/blocs/counter_cubit/counter_cubit.dart';

class CubitCounterScreen extends StatelessWidget {
  const CubitCounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit(),
      child: const _CubirCounterView(),
    );
  }
}

class _CubirCounterView extends StatelessWidget {
  const _CubirCounterView();

  void increaseCounter(BuildContext context, [int value = 1]) {
    context.read<CounterCubit>().increaseBy(value);
  }

  @override
  Widget build(BuildContext context) {

    final counterCubit = context.watch<CounterCubit>().state;

    return Scaffold(
      appBar: AppBar(
        title: Text("Cubit counter: ${counterCubit.transactionCount}"),
        actions: [
          IconButton(onPressed: () {
            context.read<CounterCubit>().reset();
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return Text("Value: ${state.counter}");
          },
        ),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "1", 
              child: const Text("+1"),
              onPressed: () {
                increaseCounter(context, 1);
              }
            ),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
              heroTag: "2", 
              child: const Text("+2"), 
              onPressed: () {
                context.read<CounterCubit>().increaseBy(2);
              }),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
              heroTag: "3", 
              child: const Text("+3"), 
              onPressed: () {
                context.read<CounterCubit>().increaseBy(3);
              }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
