import 'package:app/res/color.dart';
import 'package:flutter/material.dart';

class SendMessageWidget extends StatefulWidget {
  const SendMessageWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<SendMessageWidget> createState() => _SendMessageWidgetState();
}

class _SendMessageWidgetState extends State<SendMessageWidget> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20) +
          EdgeInsets.only(bottom: 14),
      // todo : manage platform-level padding
      child: Row(
        children: [
          Flexible(
            child: TextField(
              onChanged: (val) {
                setState(() {});
              },
              cursorColor: Colors.grey,
              controller: messageController,
              decoration: InputDecoration(
                  hintText: 'Write message here...',
                  hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  border: _outlineInputBorder,
                  isDense: true,
                  disabledBorder: _outlineInputBorder,
                  enabledBorder: _outlineInputBorder,
                  focusedBorder: _outlineInputBorder),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (messageController.text.length < 0) return;
              messageController.clear();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: messageController.text.length > 0
                      ? PRIMARY_COLOR
                      : PRIMARY_COLOR.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10)),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

OutlineInputBorder _outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.grey, width: 1.0),
);
