import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:s21_push/presentation/blocs/notifications/notifications_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: context.select((NotificationsBloc bloc) => Text("${bloc.state.status}", style: theme.bodyMedium,)),
        actions: [
          IconButton(onPressed: () async {
            context.read<NotificationsBloc>().requestPermission();  
          }, icon: Icon(Icons.settings))
        ],
      ),
      body: const _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final notifications = context.watch<NotificationsBloc>().state.notifications;

    return ListView.builder(
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return ListTile(
          title: Text(notification.title),
          subtitle: Text(notification.body),
          leading: Image.network(notification.imageUrl ?? "https://upload.wikimedia.org/wikipedia/commons/a/a3/Image-not-found.png"),
          onTap: (){
            context.push("/details/${notification.messageId}");
          },
        );
      },
    );
  }
}