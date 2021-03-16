import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'ingredient.g.dart';

@JsonSerializable(explicitToJson: true)
class Ingredient {
  final String id;
  final String type;
  final String title;
  final int measureValue;
  final IngredientMeasure measureType;

  Ingredient({
    @required this.id,
    @required this.type,
    @required this.title,
    this.measureValue,
    this.measureType,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) => _$IngredientFromJson(json);
  Map<String, dynamic> toJson() => _$IngredientToJson(this);
}

enum IngredientMeasure {
  Glass,
  Tablespoon,
  TeaSpoon,
  DessertSpoon,
  Milliliter,
  Kilogram,
  Gram,
  Liter,
}
