import 'package:flutter/material.dart';
import 'package:s5_yesnoapp/config/helpers/fetch.dart';
import 'package:s5_yesnoapp/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {

  final ScrollController controller = ScrollController();
  final GetYesNoAnswer answer = GetYesNoAnswer();

  List<Message> messageList = [
    Message(text: "Hola...", from: From.mine),
    Message(text: "Ya regreasste...?", from: From.mine),
  ];

  Future<void> sendMessage( String text ) async {
     final msg = Message(text: text, from: From.mine);
     messageList.add(msg);

    if(text.endsWith("?")) herReply();

     notifyListeners();
     moveBottom();
  }

  Future<void> herReply() async {
    final msg = await answer.getAnswer();
    messageList.add(msg);
    notifyListeners();
    moveBottom();
  }

  Future<void> moveBottom() async {
    await Future.delayed(Duration(milliseconds: 100));
    controller.animateTo(
      controller.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut
    );
  }
}