import 'package:flutter/material.dart';
import 'ssh_manager.dart';
import 'gemini_service.dart';

class TerminalScreen extends StatefulWidget {
  const TerminalScreen({super.key});

  @override
  State<TerminalScreen> createState() => _TerminalScreenState();
}

class _TerminalScreenState extends State<TerminalScreen> {
  final TextEditingController _controller = TextEditingController();
  final SSHManager _ssh = SSHManager();
  String _output = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ZenSSH Terminal')),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(child: Text(_output))),
          _buildControlBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(hintText: 'Enter command...'),
              onSubmitted: (value) async {
                // Logic to execute via SSH
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlBar() {
    return Container(
      color: Colors.grey[200],
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _keyButton('Tab'),
          _keyButton('Ctrl'),
          _keyButton('Esc'),
          _keyButton('Alt'),
        ],
      ),
    );
  }

  Widget _keyButton(String label) {
    return ElevatedButton(onPressed: () {}, child: Text(label));
  }
}
