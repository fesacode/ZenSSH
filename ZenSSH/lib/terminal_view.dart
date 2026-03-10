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
  final GeminiService _ai = GeminiService('YOUR_GEMINI_API_KEY'); // Placeholder
  String _output = 'Connected to ZenSSH MVP...\n';

  void _executeCommand(String command) async {
    setState(() => _output += '\n\$ $command\n');
    try {
      final result = await _ssh.execute(command);
      setState(() => _output += result);
    } catch (e) {
      setState(() => _output += 'Error: $e\n');
    }
  }

  void _askAI() async {
    final aiCommand = await _ai.generateCommand(_controller.text);
    _controller.text = aiCommand;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ZenSSH MVP')),
      body: Column(
        children: [
          Expanded(child: SingleChildScrollView(child: Text(_output))),
          _buildControlBar(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(hintText: 'Enter command...'),
                    onSubmitted: _executeCommand,
                  ),
                ),
                IconButton(icon: const Icon(Icons.psychology), onPressed: _askAI),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlBar() {
    return Container(
      color: Colors.grey[900],
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _keyButton('Tab', () => _controller.text += '\t'),
          _keyButton('Ctrl', () => {}),
          _keyButton('Esc', () => {}),
          _keyButton('Ask AI', _askAI),
        ],
      ),
    );
  }

  Widget _keyButton(String label, VoidCallback onPressed) {
    return ElevatedButton(onPressed: onPressed, child: Text(label));
  }
}
