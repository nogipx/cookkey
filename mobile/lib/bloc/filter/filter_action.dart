import 'package:sdk/domain.dart';

abstract class FilterEvent {}

class FilterSelectionToggled extends FilterEvent {
  final RecipeTag selectedTag;
  FilterSelectionToggled(this.selectedTag);
}

class FilterSelectionCleared extends FilterEvent {}

//

abstract class FilterState {
  final FilterOption filterOption;

  FilterState(this.filterOption);
}

class FilterUpdateSuccess extends FilterState {
  FilterUpdateSuccess(FilterOption option) : super(option);
}

class FilterInitial extends FilterState {
  FilterInitial(FilterOption option) : super(option);
}

class FilterUpdateFailure extends FilterState {
  FilterUpdateFailure(FilterOption option) : super(option);
}
