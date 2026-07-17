import '../domain/models/agent_role.dart';
import '../domain/models/paradox_cloud.dart';
import '../domain/models/paradox_round.dart';
import '../domain/models/statement.dart';
import '../domain/agent_prompts.dart';
import '../infrastructure/llm_client.dart';
import 'blackboard.dart';
import 'banality_detector.dart';

class ParadoxOrchestrator {
  ParadoxOrchestrator({
    required this.llmClient,
    required this.blackboard,
    required this.banalityDetector,
    this.maxRounds = 1,
  });

  final LLMClient llmClient;
  final Blackboard blackboard;
  final BanalityDetector banalityDetector;
  final int maxRounds;

  Future<ParadoxCloud> run(String topic) async {
    blackboard.clear();
    final rounds = <ParadoxRound>[];

    for (var round = 1; round <= maxRounds; round++) {
      final statements = <Statement>[];
      final roles = AgentRole.values;

      for (final role in roles) {
        final previousText = blackboard.formatPrevious();
        final systemMsg = AgentPrompts.systemPrompt(role, round);
        final userMsg = AgentPrompts.userPrompt(
          topic,
          previousStatements: previousText,
        );

        final response = await llmClient.complete(
          systemPrompt: systemMsg,
          userPrompt: userMsg,
        );

        final statement = Statement(
          role: role,
          content: response,
          round: round,
        );
        statements.add(statement);
        blackboard.add(statement);
      }

      final synthStatement = statements.firstWhere(
        (s) => s.role == AgentRole.synthesist,
        orElse: () => statements.last,
      );
      final banalityDetected = banalityDetector.isBanal(synthStatement.content);

      rounds.add(ParadoxRound(
        statements: statements,
        banalityDetected: banalityDetected,
      ));

      if (banalityDetected) {
        break;
      }
    }

    final finalStatements = blackboard.statements
        .where((s) => s.round == rounds.length)
        .toList();

    return ParadoxCloud(
      topic: topic,
      rounds: rounds,
      finalStatements: finalStatements,
    );
  }
}
