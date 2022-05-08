import 'package:first_ui/utils/string.dart';
import 'package:flutter/material.dart';

class CodeMethod extends StatelessWidget {
  const CodeMethod(
      {Key? key,
      required this.title,
      required this.activeTitle,
      required this.onPress})
      : super(key: key);

  final String title;
  final String activeTitle;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            onPress(title);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
                border: Border.all(
                    color: activeTitle == title
                        ? const Color(0xFF00a0c8)
                        : Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  color: activeTitle == title
                      ? const Color(0xFF00a0c8)
                      : Colors.grey,
                  size: 16.0,
                  semanticLabel: 'misscall icon',
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  UtilsString.capitalizeEachWords(title),
                  style: TextStyle(
                      color: activeTitle == title
                          ? const Color(0xFF00a0c8)
                          : Colors.grey,
                      fontWeight: FontWeight.w500,
                      fontSize: 11),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
