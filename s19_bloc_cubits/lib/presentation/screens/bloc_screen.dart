import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s19_bloc_cubits/presentation/blocs/counter_bloc/counter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: BlocCounterView(),
    );
  }
}

class BlocCounterView extends StatelessWidget {
  const BlocCounterView({
    super.key,
  });

  void increasedCounterBy(BuildContext context, [int value = 1]) {
    context.read<CounterBloc>().add( CounterIncreased(value: value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BloC"),
        actions: [
          IconButton(onPressed: () {
            context.read<CounterBloc>().add( CounterReset());
          }, icon: const Icon(Icons.refresh))
        ],
      ),
      body: Center(
        child: context
            .select((CounterBloc bloc) => Text("Value: ${bloc.state.counter}")),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "1", child: const Text("+1"), onPressed: () {
                increasedCounterBy(context, 1);
              }),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
              heroTag: "2", child: const Text("+2"), onPressed: () { increasedCounterBy(context, 2); }),
          const SizedBox(
            height: 15,
          ),
          FloatingActionButton(
              heroTag: "3", child: const Text("+3"), onPressed: () { increasedCounterBy(context, 3); }),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
