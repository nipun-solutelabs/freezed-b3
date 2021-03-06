import 'package:example/diagnosticable.dart' as diagnosticable;
import 'package:example/non_diagnosticable.dart' as non_diagnosticable;
import 'package:example/time_slot.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('use Diagnosticable instead of toString if possible', () {
    var value = diagnosticable.Example<int>(42, '21');

    expect(value, isA<DiagnosticableTree>());
    expect(value.toString(), 'Example<int>(a: 42, b: 21, theAnswer: 42)');

    value = diagnosticable.Example.named(42);
    expect(value, isA<DiagnosticableTree>());
    expect(value.toString(), 'Example<int>.named(c: 42, theAnswer: 42)');
  });
  test('debugFillProperties', () {
    final properties = DiagnosticPropertiesBuilder();
    var value = diagnosticable.Example<int>(42, '21');

    // ignore: invalid_use_of_protected_member
    (value as Diagnosticable).debugFillProperties(properties);

    expect(properties.properties.length, 4);
    expect(
      properties.properties.first,
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'type')
          .having((d) => d.value, 'value', 'Example<int>'),
    );
    expect(
      properties.properties[1],
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'a')
          .having((d) => d.value, 'value', 42),
    );
    expect(
      properties.properties[2],
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'b')
          .having((d) => d.value, 'value', '21'),
    );
    expect(
      properties.properties[3],
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'theAnswer')
          .having((d) => d.value, 'value', 42),
    );
  });
  test('noop if Diagnosticable not available', () {
    var value = non_diagnosticable.Example<int>(42, '21');

    expect(value, isNot(isA<DiagnosticableTree>()));
    expect(value.toString(), 'Example<int>(a: 42, b: 21)');

    value = non_diagnosticable.Example.named(42);
    expect(value, isNot(isA<DiagnosticableTree>()));
    expect(value.toString(), 'Example<int>.named(c: 42)');
  });
  test('timeslot is not Diagnosticable', () {
    final timeslot = TimeSlot(
      start: const TimeOfDay(hour: 10, minute: 30),
      end: const TimeOfDay(hour: 12, minute: 45),
    );

    expect(timeslot, isNot(isA<DiagnosticableTree>()));
  });
}
