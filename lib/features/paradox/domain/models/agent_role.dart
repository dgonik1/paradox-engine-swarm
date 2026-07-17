import 'package:equatable/equatable.dart';

enum AgentRole {
  provocateur('Provocateur'),
  analyst('Analyst'),
  synthesist('Synthesist');

  const AgentRole(this.value);
  final String value;
}
