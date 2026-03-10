import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Connection {
  final String host;
  final String username;
  final int port;

  Connection(this.host, this.username, this.port);
  Map<String, dynamic> toJson() => {'host': host, 'user': username, 'port': port};
}

class ConnectionManager {
  Future<void> saveConnection(Connection conn) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('connections') ?? [];
    list.add(jsonEncode(conn.toJson()));
    await prefs.setStringList('connections', list);
  }
}
