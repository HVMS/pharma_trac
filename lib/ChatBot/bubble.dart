import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  final String message;
  final bool isUser;

  const Bubble({super.key, required this.message, required this.isUser});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment:
        isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              color: isUser
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).primaryColor,
              borderRadius: isUser
                  ? const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              )
                  : const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Text(
              message,
              overflow: TextOverflow.ellipsis,
              maxLines: null,
              softWrap: true,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
