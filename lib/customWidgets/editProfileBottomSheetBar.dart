import 'package:flutter/material.dart';

class EditProfileBottomSheetBar extends StatefulWidget{
  final Function(String) onTextSubmitted;

  const EditProfileBottomSheetBar({super.key, required this.onTextSubmitted});

  @override
  State<StatefulWidget> createState() => _EditProfileBottomSheetBar();

}

class _EditProfileBottomSheetBar extends State<EditProfileBottomSheetBar>{

  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.all(16.0),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text('Custom BottomSheet Bar'),
          TextField(
            controller: _textController,
            decoration: const InputDecoration(
              hintText: 'Enter your text',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              widget.onTextSubmitted(_textController.text);
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );

  }
}