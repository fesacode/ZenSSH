import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:encrypt/encrypt.dart'; // Added encryption package

class Connection {
  final String host;
  final String username;
  final int port;

  Connection(this.host, this.username, this.port);
  Map<String, dynamic> toJson() => {'host': host, 'user': username, 'port': port};
}

class ConnectionManager {
  final key = Key.fromLength(32); // In production, store this securely
  final iv = IV.fromLength(16);

  Future<void> saveConnection(Connection conn) async {
    final encrypter = Encrypter(AES(key));
    final encrypted = encrypter.encrypt(jsonEncode(conn.toJson()), iv: iv);
    
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('connections') ?? [];
    list.add(encrypted.base64);
    await prefs.setStringList('connections', list);
  }
}
