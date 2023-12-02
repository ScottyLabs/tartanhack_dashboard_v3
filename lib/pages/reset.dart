import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tartanhacks_dashboard_v3/api/login_service.dart';
import 'package:tartanhacks_dashboard_v3/components/backgrounds/LoginBackground.dart';
import 'package:tartanhacks_dashboard_v3/components/loading/LoadingOverlay.dart';
import '../components/ErrorDialog.dart';
import '../models/user.dart';

class Reset extends StatefulWidget {
  @override
  _ResetState createState() => _ResetState();
}

class _ResetState extends State<Reset> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void reset(String email) async {
    OverlayEntry loading = LoadingOverlay(context);
    Overlay.of(context)?.insert(loading);
  }

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final screenHeight = mqData.size.height;

    return LoginBackground(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                  AutoSizeText("let's reset",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 80,
                      )),


                Column(children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 40, 40, 10),
                    child: TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          filled: true,
                          fillColor: Colors.black,
                        ),
                        style: Theme.of(context).textTheme.bodyText2,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.next),
                  ),

                ])
              ],
            ),
            Column(children: [
              ElevatedButton(
                  onPressed: () {
                    reset(_emailController.text);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ))),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Text(
                      "Recover Password",
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text("Already have an account? Try logging in",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary))),
            ]),
          ],
        ),
      ),
    );
  }
}
