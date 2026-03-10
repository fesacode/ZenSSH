import 'package:flutter/material.dart';
import 'terminal_view.dart';

void main() {
  runApp(const ZenSSHApp());
}

class ZenSSHApp extends StatelessWidget {
  const ZenSSHApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZenSSH',
      theme: ThemeData.dark(),
      home: const TerminalScreen(),
    );
  }
}
