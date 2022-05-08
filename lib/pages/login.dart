import 'dart:async';
import 'dart:convert';

import 'package:first_ui/services/users.dart';
import 'package:first_ui/uikits/codemethodlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _controller = TextEditingController();
  late String activeTitle;
  bool isLoading = false;

  void changeActiveTitle(String title) {
    setState(() {
      activeTitle = title;
    });
  }

  void handleLogin() async {
    String loginFieldValue = _controller.value.text.trim();
    if (loginFieldValue != "") {
      setState(() {
        isLoading = true;
      });
      print(_controller.value.text);
      var url = Uri.parse('');
      var response = await http.post(url,
          body: jsonEncode(
              {'phone': loginFieldValue, 'otp_method': activeTitle}));
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      print(response.body);

      setState(() {
        isLoading = false;
      });
      // if (response.body == 'success') {
      //   Navigator.of(context).pushNamed('/');
      // }
    }
  }

  late Future<AvailableOtpMethod> futureAvailableOtpMethod;

  @override
  void initState() {
    super.initState();
    futureAvailableOtpMethod = fetchAvailableOtpMethod();
    futureAvailableOtpMethod.then((value) {
      setState(() {
        activeTitle = value.method[0];
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    });
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
              child: FutureBuilder<AvailableOtpMethod>(
                  future: futureAvailableOtpMethod,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return CodeMethodList(
                          entries: snapshot.data!.method,
                          activeTitle: activeTitle,
                          onPress: (title) => changeActiveTitle(title));
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  }),
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: () {
                  handleLogin();
                },
                child: isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
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
