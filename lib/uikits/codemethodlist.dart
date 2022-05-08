import 'package:first_ui/uikits/codemethod.dart';
import 'package:flutter/material.dart';

class CodeMethodList extends StatelessWidget {
  const CodeMethodList(
      {Key? key,
      required this.entries,
      required this.activeTitle,
      required this.onPress})
      : super(key: key);

  final List<dynamic> entries;
  final String activeTitle;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 40,
        child: ListView.separated(
          separatorBuilder: ((context, index) => const SizedBox(
                width: 8,
              )),
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: entries.length,
          itemBuilder: ((context, index) {
            final item = entries[index];
            return CodeMethod(
                title: item,
                activeTitle: activeTitle,
                onPress: (title) {
                  onPress(title);
                });
          }),
        ));
  }
}
