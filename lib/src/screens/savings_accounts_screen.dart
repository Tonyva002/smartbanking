import 'package:flutter/material.dart';

class SavingAccountsScreen extends StatelessWidget {
  const SavingAccountsScreen({super.key});

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

      body: Center(child: Text("Saving Accounts")),
    );
  }
}
