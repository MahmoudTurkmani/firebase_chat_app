import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String username;
  final String userImage;
  final bool isMe;

  MessageBubble(
    this.message,
    this.isMe,
    this.username,
    this.userImage,
  );

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isMe
                    ? Theme.of(context).primaryColor
                    : Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: isMe ? Radius.circular(10) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : Radius.circular(10),
                ),
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 18,
              ),
              padding: const EdgeInsets.all(10),
              constraints: BoxConstraints(
                maxWidth: 200,
              ),
              child: Column(
                crossAxisAlignment:
                    isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentTextTheme.headline6.color,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    message,
                    textAlign: isMe ? TextAlign.end : TextAlign.start,
                    softWrap: true,
                    style: TextStyle(
                      color: Theme.of(context).accentTextTheme.headline6.color,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: -10,
              child: CircleAvatar(
                backgroundImage: NetworkImage(userImage),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
