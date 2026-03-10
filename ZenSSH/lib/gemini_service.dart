import 'package:http/http.dart' as http;
import 'dart:convert';

class GeminiService {
  final String apiKey;
  GeminiService(this.apiKey);

  Future<String> generateCommand(String naturalLanguage) async {
    final url = Uri.parse('https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$apiKey');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [{"parts": [{"text": "Convertir a comando Linux preciso: $naturalLanguage. Solo dame el comando, sin explicaciones."}]}]
      }),
    );
    
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates'][0]['content']['parts'][0]['text'];
    } else {
      throw Exception('Error al conectar con Gemini: ${response.statusCode}');
    }
  }
}
