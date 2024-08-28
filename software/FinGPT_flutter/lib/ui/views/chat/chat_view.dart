import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'chat_viewmodel.dart';

class ChatView extends StackedView<ChatViewModel> {
  const ChatView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ChatViewModel model,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("FinGPT Chat"),
        actions: [
          if (model.isBusy)
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 2,
              ),
            )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: model.messages.length,
              itemBuilder: (context, index) {
                final message = model.messages[index];
                final isUserMessage = message.sender == MessageSender.user;
                return ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  leading:
                      isUserMessage ? null : CircleAvatar(child: Text('S')),
                  trailing:
                      isUserMessage ? CircleAvatar(child: Text('U')) : null,
                  title: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue : Colors.green,
                      borderRadius: BorderRadius.only(
                        topLeft: isUserMessage
                            ? Radius.circular(20.0)
                            : Radius.circular(0),
                        topRight: isUserMessage
                            ? Radius.circular(0)
                            : Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: model.controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => model.sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  ChatViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ChatViewModel();

  @override
  void onViewModelReady(ChatViewModel viewModel) {
    viewModel.onModelReady();
    super.onViewModelReady(viewModel);
  }
}
