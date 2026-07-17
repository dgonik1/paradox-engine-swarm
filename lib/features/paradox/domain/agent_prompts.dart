import 'models/agent_role.dart';

class AgentPrompts {
  AgentPrompts._();

  static String systemPrompt(AgentRole role, int round) {
    switch (role) {
      case AgentRole.provocateur:
        return 'You are the Provocateur. Generate a provocative, '
            'paradoxical statement about the given topic. '
            'Challenge assumptions and create intellectual tension. '
            'Round: $round.';
      case AgentRole.analyst:
        return 'You are the Analyst. Analyze the previous statements '
            'and identify logical tensions, contradictions, or hidden '
            'assumptions. Be rigorous and precise. Round: $round.';
      case AgentRole.synthesist:
        return 'You are the Synthesist. Attempt to synthesize the '
            'previous statements into a higher-order insight. '
            'If the synthesis is banal or trivial, state that '
            'openly. Round: $round.';
    }
  }

  static String userPrompt(String topic, {String? previousStatements}) {
    final buffer = StringBuffer('Topic: $topic\n');
    if (previousStatements != null && previousStatements.isNotEmpty) {
      buffer.writeln('\nPrevious statements:\n$previousStatements');
    }
    return buffer.toString();
  }
}
