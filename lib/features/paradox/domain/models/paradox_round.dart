import 'package:equatable/equatable.dart';
import 'statement.dart';

class ParadoxRound extends Equatable {
  const ParadoxRound({
    required this.statements,
    required this.banalityDetected,
  });

  final List<Statement> statements;
  final bool banalityDetected;

  @override
  List<Object?> get props => [statements, banalityDetected];
}
