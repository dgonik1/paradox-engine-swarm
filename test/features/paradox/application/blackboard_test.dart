import 'package:flutter_test/flutter_test.dart';
import 'package:paradox_engine_swarm/features/paradox/domain/models/agent_role.dart';
import 'package:paradox_engine_swarm/features/paradox/domain/models/statement.dart';
import 'package:paradox_engine_swarm/features/paradox/application/blackboard.dart';

void main() {
  group('Blackboard', () {
    late Blackboard blackboard;

    setUp(() {
      blackboard = Blackboard();
    });

    test('starts empty', () {
      expect(blackboard.statements, isEmpty);
    });

    test('add stores statement', () {
      blackboard.add(Statement(
        role: AgentRole.provocateur,
        content: 'hello',
        round: 1,
      ));
      expect(blackboard.statements.length, 1);
    });

    test('formatPrevious excludes current round', () {
      blackboard.add(Statement(
        role: AgentRole.provocateur,
        content: 'round1',
        round: 1,
      ));
      blackboard.add(Statement(
        role: AgentRole.analyst,
        content: 'round2',
        round: 2,
      ));
      final result = blackboard.formatPrevious(upToRound: 2);
      expect(result, contains('round1'));
      expect(result, isNot(contains('round2')));
    });

    test('clear removes all statements', () {
      blackboard.add(Statement(
        role: AgentRole.provocateur,
        content: 'x',
        round: 1,
      ));
      blackboard.clear();
      expect(blackboard.statements, isEmpty);
    });
  });
}
