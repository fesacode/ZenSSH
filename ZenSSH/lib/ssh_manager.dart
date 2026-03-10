import 'package:dart_ssh2/dart_ssh2.dart';

class SSHManager {
  SSHClient? _client;

  Future<void> connect(String host, int port, String username, String password) async {
    final socket = await SSHSocket.connect(host, port);
    _client = SSHClient(socket, username: username, onPasswordRequest: () => password);
  }

  Future<String> execute(String command) async {
    if (_client == null) throw Exception("Not connected");
    final result = await _client!.run(command);
    return String.fromCharCodes(result);
  }
}
