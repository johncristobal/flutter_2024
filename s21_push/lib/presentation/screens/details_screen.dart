import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s21_push/domain/entities/push_message.dart';
import 'package:s21_push/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {

  final String pushId;
  const DetailsScreen({Key? key, required this.pushId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PushMessage? msg = context.read<NotificationsBloc>().getMessageById(pushId);
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: (msg != null)
      ? _DetailsView(message: msg)
      : const Center(child: Text("No push"),)
    );
  }
}

class _DetailsView extends StatelessWidget {

  final PushMessage message;

  const _DetailsView({
    super.key, required this.message,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if (message.imageUrl != null)
            Image.network( message.imageUrl! ),

          const SizedBox(height: 30,),

          Text( message.title),
          Text( message.body),

          const Divider(),
          Text( message.data.toString())
        ],
      ),
    );
  }
}