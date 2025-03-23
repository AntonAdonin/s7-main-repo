import 'package:json_annotation/json_annotation.dart';
import 'package:collection/collection.dart';

enum Operator {
  @JsonValue(null)
  swaggerGeneratedUnknown(null),

  @JsonValue('=')
  undefined('='),
  @JsonValue('!=')
  $undefined('!='),
  @JsonValue('~')
  $$undefined('~'),
  @JsonValue('<')
  $$$undefined('<'),
  @JsonValue('>')
  $$$$undefined('>'),
  @JsonValue('<=')
  $$$$$undefined('<='),
  @JsonValue('>=')
  $$$$$$undefined('>=');

  final String? value;

  const Operator(this.value);
}
