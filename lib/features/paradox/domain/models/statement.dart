import 'package:equatable/equatable.dart';
import 'agent_role.dart';

class Statement extends Equatable {
  const Statement({
    required this.role,
    required this.content,
    required this.round,
  });

  final AgentRole role;
  final String content;
  final int round;

  @override
  List<Object?> get props => [role, content, round];
}
