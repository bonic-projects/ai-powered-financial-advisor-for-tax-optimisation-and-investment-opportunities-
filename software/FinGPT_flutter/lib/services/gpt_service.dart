import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import '../app/app.logger.dart';

class GptService {
  final log = getLogger('GptService');

  late OpenAI openAI; // Define the OpenAI instance as late
  void initializeOpenAI() {
    const token = "";

    try {
      openAI = OpenAI.instance.build(
        token: token,
        baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 10)),
        enableLog: true,
      );
    } catch (e) {
      log.e("Error: $e");
    }
  }

  ChatCompleteText _requestChat(List<Map<String, dynamic>> messages) {
    return ChatCompleteText(
        messages: messages, maxToken: 200, model: GptTurbo0631Model());
  }

  Future<String?> getChatResponse(List<Map<String, dynamic>> messages) async {
    final request = _requestChat(messages);
    try {
      log.i(messages);
      log.i("Question: ${messages.last['content']} ${messages.last['role']}");
      ChatCTResponse? response =
          await openAI.onChatCompletion(request: request);
      if (response != null) {
        log.i(response.choices[0].message?.content.length);
        return response.choices[0].message?.content;
      }
    } catch (e) {
      log.e("Error: $e");
      return null;
    }
    return null;
  }
}
