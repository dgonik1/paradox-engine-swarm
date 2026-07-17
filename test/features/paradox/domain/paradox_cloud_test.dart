import 'package:flutter_test/flutter_test.dart';
import 'package:paradox_engine_swarm/features/paradox/domain/models/agent_role.dart';
import 'package:paradox_engine_swarm/features/paradox/domain/models/statement.dart';
import 'package:paradox_engine_swarm/features/paradox/domain/models/paradox_round.dart';
import 'package:paradox_engine_swarm/features/paradox/domain/models/paradox_cloud.dart';

void main() {
  group('Statement', () {
    test('creates with correct fields', () {
      final s = Statement(
        role: AgentRole.provocateur,
        content: 'test',
        round: 1,
      );
      expect(s.role, AgentRole.provocateur);
      expect(s.content, 'test');
      expect(s.round, 1);
    });

    test('equality works', () {
      final a = Statement(role: AgentRole.analyst, content: 'x', round: 1);
      final b = Statement(role: AgentRole.analyst, content: 'x', round: 1);
      expect(a, equals(b));
    });
  });

  group('ParadoxCloud', () {
    test('holds topic, rounds, and final statements', () {
      final stmt = Statement(
        role: AgentRole.synthesist,
        content: 'synthesis',
        round: 1,
      );
      final round = ParadoxRound(
        statements: [stmt],
        banalityDetected: false,
      );
      final cloud = ParadoxCloud(
        topic: 'AI',
        rounds: [round],
        finalStatements: [stmt],
      );
      expect(cloud.topic, 'AI');
      expect(cloud.rounds.length, 1);
      expect(cloud.finalStatements.length, 1);
    });
  });
}
