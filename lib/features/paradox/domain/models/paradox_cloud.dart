import 'package:equatable/equatable.dart';
import 'statement.dart';
import 'paradox_round.dart';

class ParadoxCloud extends Equatable {
  const ParadoxCloud({
    required this.topic,
    required this.rounds,
    required this.finalStatements,
  });

  final String topic;
  final List<ParadoxRound> rounds;
  final List<Statement> finalStatements;

  @override
  List<Object?> get props => [topic, rounds, finalStatements];
}
