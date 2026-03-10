import 'package:flutter/material.dart';

void main() {
  runApp(const ZenSSHApp());
}

class ZenSSHApp extends StatelessWidget {
  const ZenSSHApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZenSSH',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(title: const Text('ZenSSH Terminal')),
        body: const Center(child: Text('ZenSSH Starting Soon...')),
      ),
    );
  }
}
