import 'package:dio/dio.dart';
import 'package:s5_yesnoapp/domain/entities/message.dart';
import 'package:s5_yesnoapp/infra/models/yesno.dart';

class GetYesNoAnswer {

  final _dio = Dio();

  Future<Message> getAnswer() async {
    final response = await _dio.get("https://yesno.wtf/api");
    final yesno = YesNoResponse.fromJson(response.data);
    return yesno.toMessageEntity();
  }
}