import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_app/domain/entities/message.dart';
import 'package:yes_no_app/presentation/providers/chat_provider.dart';
import 'package:yes_no_app/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_app/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                'https://scontent.fgdl9-1.fna.fbcdn.net/v/t39.30808-6/339907436_546410350894900_226863220457519669_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeGGu8T06B6HcJBLq0mZinWkulWu_jp1N9m6Va7-OnU32a1AZ3SIKhBY29lIya5u3-mYbKsiER4yH9YxWkTXzxAY&_nc_ohc=qybWkoRcmc8AX8-jK5y&_nc_ht=scontent.fgdl9-1.fna&oh=00_AfCALDdNUSUwJE9wsxTdyFy0CsumoAg44d6Pv9q0J6mU6g&oe=647292DF'),
          ),
        ),
        title: const Text('Mi amor <3'),
      ),
      body: const _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chatProvider.chatScrollController,
                itemCount: chatProvider.messagesList.length,
                itemBuilder: (context, index) {
                  final message = chatProvider.messagesList[index];
                  return (message.fromWho == FromWho.me)
                      ? MyMessageBubble(message: message)
                      : HerMessageBubble(message: message);
                },
              ),
            ),

            /// CAJA DE TEXTO DE MENSAJES
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            )
          ],
        ),
      ),
    );
  }
}
