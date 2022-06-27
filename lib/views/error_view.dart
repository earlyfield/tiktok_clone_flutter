import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          children: const [
            Text("404 Not Found"),
            Text("存在しないページにアクセスしました。"),
          ],
        ),
      ),
    );
  }
}
