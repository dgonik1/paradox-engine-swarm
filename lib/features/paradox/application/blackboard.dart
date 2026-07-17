import '../domain/models/statement.dart';

class Blackboard {
  final List<Statement> _statements = [];

  List<Statement> get statements => List.unmodifiable(_statements);

  void add(Statement statement) {
    _statements.add(statement);
  }

  void clear() {
    _statements.clear();
  }

  String formatPrevious({int? upToRound}) {
    final filtered = upToRound != null
        ? _statements.where((s) => s.round < upToRound).toList()
        : _statements;
    return filtered
        .map((s) => '[${s.role.value}] (round ${s.round}): ${s.content}')
        .join('\n');
  }
}
