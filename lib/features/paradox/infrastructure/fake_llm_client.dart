import 'llm_client.dart';

class FakeLLMClient extends LLMClient {
  int _callCount = 0;

  @override
  Future<String> complete({
    required String systemPrompt,
    required String userPrompt,
  }) async {
    _callCount++;
    final topic = _extractTopic(userPrompt);

    if (systemPrompt.contains('Synthesist')) {
      if (_callCount >= 4) {
        return 'It depends on the perspective. '
            'Both sides have a point. There is no easy answer.';
      }
      return 'Synthesis of "$topic": The paradox reveals a deeper '
          'unity between opposing forces.';
    }

    if (systemPrompt.contains('Provocateur')) {
      return 'What if $topic is fundamentally an illusion '
          'created by the very framework we use to understand it?';
    }

    return 'Analysis of "$topic": The previous statement contains '
        'a hidden assumption that reality is stable and objective.';
  }

  String _extractTopic(String userPrompt) {
    final match = RegExp(r'Topic:\s*(.+)').firstMatch(userPrompt);
    return match?.group(1)?.trim() ?? 'the topic';
  }
}
