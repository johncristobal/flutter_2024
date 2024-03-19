import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:s5_yesnoapp/domain/entities/message.dart';
import 'package:s5_yesnoapp/presentation/providers/chat_provider.dart';
import 'package:s5_yesnoapp/presentation/widgtes/her_msg.dart';
import 'package:s5_yesnoapp/presentation/widgtes/msg_field.dart';
import 'package:s5_yesnoapp/presentation/widgtes/my_msg.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              "https://scontent.fmex16-1.fna.fbcdn.net/v/t1.6435-9/71495976_2227588440686413_569308738402385920_n.jpg?stp=dst-jpg_s1080x2048&_nc_cat=102&ccb=1-7&_nc_sid=5f2048&_nc_eui2=AeHx3T4uU6RSL4sj5bdqqWqjpYqT-LAs7NilipP4sCzs2LidBXhK4pOU5H2U4tSArx-xl_vjPiyZU8ym_k_XuHJl&_nc_ohc=f6odE8FusjcAX_uTTTE&_nc_ht=scontent.fmex16-1.fna&oh=00_AfBIsc9bQHfO5qPFvaitZTCGXk1XIwfbtosohl_yUCGzqw&oe=661BFD29"
            ),
          )
          ),
        title: const Text("DEMO"),
        centerTitle: false,
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final provider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: provider.controller,
                itemCount: provider.messageList.length,
                itemBuilder: (context, index) {
                  final msg = provider.messageList[index];
                  return (msg.from == From.hers)
                  ? HerMessagBuble(message: msg)
                  : MyMessagBuble(message: msg,);
                },
              ),
            ),
            MessageField(onValue: (String value) { 
              provider.sendMessage(value);
            },)
          ],
        ),
      ),
    );
  }
}