abstract class LLMClient {
  Future<String> complete({
    required String systemPrompt,
    required String userPrompt,
  });
}
