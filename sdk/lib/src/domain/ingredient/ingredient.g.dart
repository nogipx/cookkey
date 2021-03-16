// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ingredient.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ingredient _$IngredientFromJson(Map<String, dynamic> json) {
  return Ingredient(
    id: json['id'] as String,
    type: json['type'] as String,
    title: json['title'] as String,
    measureValue: json['measureValue'] as int,
    measureType:
        _$enumDecodeNullable(_$IngredientMeasureEnumMap, json['measureType']),
  );
}

Map<String, dynamic> _$IngredientToJson(Ingredient instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'title': instance.title,
      'measureValue': instance.measureValue,
      'measureType': _$IngredientMeasureEnumMap[instance.measureType],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$IngredientMeasureEnumMap = {
  IngredientMeasure.Glass: 'Glass',
  IngredientMeasure.Tablespoon: 'Tablespoon',
  IngredientMeasure.TeaSpoon: 'TeaSpoon',
  IngredientMeasure.DessertSpoon: 'DessertSpoon',
  IngredientMeasure.Milliliter: 'Milliliter',
  IngredientMeasure.Kilogram: 'Kilogram',
  IngredientMeasure.Gram: 'Gram',
  IngredientMeasure.Liter: 'Liter',
};
