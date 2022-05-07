import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  String activeTitle = "Misscall";

  late final List<Widget> entries = <Widget>[
    CodeMethod(
      title: "Misscall",
      activeTitle: activeTitle,
      onPress: (title) => changeActiveTitle(title),
    ),
    CodeMethod(
      title: "WhatsApp",
      activeTitle: activeTitle,
      onPress: (title) => changeActiveTitle(title),
    ),
    CodeMethod(
      title: "SMS",
      activeTitle: activeTitle,
      onPress: (title) => changeActiveTitle(title),
    )
  ];

  void changeActiveTitle(String title) {
    setState(() {
      activeTitle = title;
    });
    print(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 80, 40, 80),
                child: Column(
                  children: [
                    Image.asset(
                      "assets/dagangan.png",
                      width: 181,
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      "Belanja di manapun jadi lebih mudah dan hemat",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8, bottom: 4),
                  child: Text(
                    "Nomor HP",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                  ),
                ),
                TextField(
                  controller: _controller,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      hintText: 'Masukkan Nomor HP',
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFF00a0c8)))),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 6, left: 8),
              alignment: Alignment.topLeft,
              child: const Text("Kirim kode melalui",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: SizedBox(
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
                      return item;
                    }),
                  )),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "MASUK/DAFTAR",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color(0xFFf76b00),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    )),
              ),
            )
          ],
        ),
      )),
    );
  }
}

class CodeMethod extends StatelessWidget {
  final String title;
  final String activeTitle;
  final Function onPress;

  const CodeMethod(
      {Key? key,
      required this.title,
      required this.activeTitle,
      required this.onPress})
      : super(key: key);

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
                    color: activeTitle == title ? Colors.blue : Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: [
                Icon(
                  Icons.phone,
                  color: activeTitle == title ? Colors.blue : Colors.grey,
                  size: 16.0,
                  semanticLabel: 'misscall icon',
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: activeTitle == title ? Colors.blue : Colors.grey,
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
