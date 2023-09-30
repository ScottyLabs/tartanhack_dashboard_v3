import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:tartanhacks_dashboard_v3/api/login_service.dart';
import 'package:tartanhacks_dashboard_v3/components/backgrounds/LoginBackground.dart';
import 'package:tartanhacks_dashboard_v3/components/loading/LoadingOverlay.dart';
import '../components/ErrorDialog.dart';
import '../models/user.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void login(String email, String password) async {
    OverlayEntry loading = LoadingOverlay(context);
    Overlay.of(context)?.insert(loading);
    try {
      User logindata = await LoginService.checkCredentials(email, password);
      loading.remove();
    } catch (err) {
      errorDialog(
          context, "Login Failure", "Your username or password is incorrect.");
    } finally {
      loading.remove();
    }
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
            Stack(
              children: [
                const RotationTransition(
                  turns: AlwaysStoppedAnimation(-6 / 360),
                  child: AutoSizeText("welcome",
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 100,
                      )),
                ),
                Column(children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 90, 40, 10),
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
                  Container(
                    padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password",
                        filled: true,
                        fillColor: Colors.black,
                      ),
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ])
              ],
            ),
            Column(children: [
              ElevatedButton(
                  onPressed: () {
                    login(_emailController.text, _passwordController.text);
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ))),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Text(
                      "Start Hacking",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  )),
              TextButton(
                  onPressed: () {},
                  child: Text("Forgot Password?",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary))),
            ]),
          ],
        ),
      ),
    );
  }
}
