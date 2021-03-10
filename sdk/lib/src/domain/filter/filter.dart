import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sdk/sdk.dart';

@JsonSerializable()
class FilterOption extends Equatable {
  final String text;
  final List<RecipeTag> tags;

  const FilterOption({
    this.text,
    this.tags,
  });

  String toQuery() {
    final _params = <String>[];
    if (text != null) {
      _params.add("text=$text");
    }
    if (tags != null && tags.isNotEmpty) {
      _params.add("tags=${tags.join(',')}");
    }

    return _params.join("&");
  }

  factory FilterOption.parse(String input) {
    final _map = Map.fromEntries(input.split("&").map((e) {
      final params = e.split("=");
      return MapEntry(params[0], params[1]);
    }));
    return FilterOption(
      text: _map["text"],
      tags: _map["tags"]?.split(",")?.map((e) => RecipeTag(id: e))?.toList(),
    );
  }

  bool get isEmpty => toQuery().isEmpty;

  @override
  List<Object> get props => [toQuery()];

  // factory FilterOption.fromJson(Map<String, dynamic> json) =>
  //     _$FilterOptionFromJson(json);
  // Map<String, dynamic> toJson() => _$FilterOptionToJson(this);
}
