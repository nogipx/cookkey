import 'package:cookkey/bloc/base_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sdk/sdk.dart';

import 'filter_action.dart';

class FilterBloc extends BaseBloc<FilterEvent, FilterState> {
  final TagRepo tagRepo;

  static FilterOption get emptyFilter => FilterOption(text: "", tags: {});

  final FilterOption _filterOption = FilterBloc.emptyFilter;
  FilterOption get filterOption => _filterOption;

  FilterBloc({
    @required this.tagRepo,
  }) : super(FilterInitial(FilterBloc.emptyFilter));

  @override
  FilterState mapError(ApiError error, FilterEvent event) {
    return FilterUpdateFailure(filterOption);
  }

  @override
  void mapEvents() {
    mapEvent<FilterSelectionToggled>(_mapToggleFilter);
    mapEvent<FilterSelectionCleared>(_mapClearFilter);
  }

  bool isTagSelected(RecipeTag tag) => _filterOption.tags.contains(tag);
  void toggleTag(RecipeTag tag) => add(FilterSelectionToggled(tag));
  Stream<FilterState> _mapToggleFilter(FilterSelectionToggled event) async* {
    if (isTagSelected(event.selectedTag)) {
      _filterOption.tags.remove(event.selectedTag);
    } else {
      _filterOption.tags.add(event.selectedTag);
    }
    yield FilterUpdateSuccess(_filterOption);
  }

  void clearSelection() => add(FilterSelectionCleared());
  Stream<FilterState> _mapClearFilter() async* {
    _filterOption.tags.clear();
    yield FilterUpdateSuccess(_filterOption);
  }
}
