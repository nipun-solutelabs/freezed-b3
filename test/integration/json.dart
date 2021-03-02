import 'package:freezed_annotation/freezed_annotation.dart';

part 'json.freezed.dart';
part 'json.g.dart';

// regression test for https://github.com/rrousselGit/freezed/issues/280

@freezed
abstract class Regression280 with _$Regression280 {
  const factory Regression280(String label) = _Regression280;

  factory Regression280.fromJson(Map<String, dynamic> val) {
    return Regression280(val['foo'] as String);
  }
}

@freezed
abstract class Regression280n2 with _$Regression280n2 {
  const factory Regression280n2(String label) = _Regression280n2;

  factory Regression280n2.fromJson(String val) {
    return Regression280n2(val);
  }
}

@Freezed(unionKey: 'ty"\'pe')
abstract class FancyCustomKey with _$FancyCustomKey {
  const factory FancyCustomKey.first(int a) = _FancyCustomKeyFirst;
  const factory FancyCustomKey.second(int a) = _FancyCustomKeySecond;

  factory FancyCustomKey.fromJson(Map<String, dynamic> json) =>
      _$FancyCustomKeyFromJson(json);
}

@Freezed(unionKey: r'$type')
abstract class RawCustomKey with _$RawCustomKey {
  const factory RawCustomKey.first(int a) = _RawCustomKeyFirst;
  const factory RawCustomKey.second(int a) = _RawCustomKeySecond;

  factory RawCustomKey.fromJson(Map<String, dynamic> json) =>
      _$RawCustomKeyFromJson(json);
}

@Freezed(unionKey: 'type')
abstract class CustomKey with _$CustomKey {
  const factory CustomKey.first(int a) = _CustomKeyFirst;
  const factory CustomKey.second(int a) = _CustomKeySecond;

  factory CustomKey.fromJson(Map<String, dynamic> json) =>
      _$CustomKeyFromJson(json);
}

@freezed
abstract class Single with _$Single {
  const factory Single(int a) = _Single;

  factory Single.fromJson(Map<String, dynamic> json) => _$SingleFromJson(json);
}

@freezed
abstract class Json with _$Json {
  const factory Json() = JsonDefault;
  const factory Json.first(String a) = First;
  const factory Json.second(int b) = Second;

  factory Json.fromJson(Map<String, dynamic> json) => _$JsonFromJson(json);
}

@freezed
abstract class NoJson with _$NoJson {
  const factory NoJson() = NoDefault;
  const factory NoJson.first(String a) = NoFirst;
  const factory NoJson.second(int b) = NoSecond;
}

@freezed
abstract class Decorator with _$Decorator {
  factory Decorator(@JsonKey(name: 'what') String a) = _Decorator;

  factory Decorator.fromJson(Map<String, dynamic> json) =>
      _$DecoratorFromJson(json);
}

@freezed
abstract class Generic<T> with _$Generic<T> {
  factory Generic(@DataConverter() T a) = _Generic<T>;

  factory Generic.fromJson(Map<String, dynamic> json) =>
      _$GenericFromJson<T>(json);
}

class DataConverter<T> implements JsonConverter<T, Object> {
  const DataConverter();

  @override
  T fromJson(Object json) {
    return json as T;
  }

  @override
  Object toJson(T object) {
    return object;
  }
}

@freezed
abstract class DefaultValue with _$DefaultValue {
  factory DefaultValue([@Default(42) int value]) = _DefaultValue;

  factory DefaultValue.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueFromJson(json);
}

@freezed
abstract class DefaultValueJsonKey with _$DefaultValueJsonKey {
  factory DefaultValueJsonKey(
          [@Default(42) @JsonKey(defaultValue: 21) int value]) =
      _DefaultValueJsonKey;

  factory DefaultValueJsonKey.fromJson(Map<String, dynamic> json) =>
      _$DefaultValueJsonKeyFromJson(json);
}

@freezed
abstract class ClassDecorator with _$ClassDecorator {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ClassDecorator(String complexName) = ClassDecoratorDefault;

  factory ClassDecorator.fromJson(Map<String, dynamic> json) =>
      _$ClassDecoratorFromJson(json);
}

@freezed
abstract class DurationValue with _$DurationValue {
  const factory DurationValue(Duration complexName) = DurationValueDefault;

  factory DurationValue.fromJson(Map<String, dynamic> json) =>
      _$DurationValueFromJson(json);
}