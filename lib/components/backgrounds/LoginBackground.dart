import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginBackground extends StatelessWidget {
  final Widget? child;

  const LoginBackground({this.child});

  @override
  Widget build(BuildContext context) {
    final mqData = MediaQuery.of(context);
    final screenHeight = mqData.size.height;

    return Scaffold(
        body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: screenHeight),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 200.0,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.elliptical(
                                  MediaQuery.of(context).size.width, 150.0)),
                        ),
                      ),
                      child ?? const SizedBox.shrink()
                    ])
            )));
  }

}