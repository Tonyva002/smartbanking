import 'package:flutter/material.dart';

class CurrentAccountsScreen extends StatelessWidget {
  const CurrentAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smart Banking"),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Center(child: Text("Current Accounts")),
    );
  }
}
