import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/config/llm_config.dart';
import '../../core/errors/exceptions.dart';
import 'llm_client.dart';

class OpenAIClient extends LLMClient {
  OpenAIClient(this._config);

  final LLMConfig _config;

  @override
  Future<String> complete({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    final url = Uri.parse('${_config.baseUrl}/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${_config.apiKey}',
      },
      body: jsonEncode({
        'model': _config.modelName,
        'messages': [
          {'role': 'system', 'content': systemPrompt},
          {'role': 'user', 'content': userPrompt},
        ],
        'temperature': 0.9,
        'max_tokens': 512,
      }),
    );

    if (response.statusCode != 200) {
      throw LLMClientError(
        'OpenAI API error ${response.statusCode}: ${response.body}',
      );
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final choices = data['choices'] as List<dynamic>;
    if (choices.isEmpty) {
      throw const LLMClientError('OpenAI returned no choices.');
    }

    final message = choices[0]['message'] as Map<String, dynamic>;
    return message['content'] as String;
  }
}
