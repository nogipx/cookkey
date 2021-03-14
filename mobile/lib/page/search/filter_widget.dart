import 'package:cookkey/bloc/auth_bloc.dart';
import 'package:cookkey/bloc/filter/export.dart';
import 'package:flutter/material.dart';
import 'package:convenient_bloc/request_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdk/sdk.dart';

class FilterWidget extends StatelessWidget {
  final FilterBloc filterBloc;
  final RequestCubit<List<RecipeTag>, ApiError> tagsCubit;
  final RequestCubit<List<Recipe>, ApiError> findRecipeCubit;

  const FilterWidget({
    Key key,
    @required this.filterBloc,
    @required this.tagsCubit,
    @required this.findRecipeCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RequestBuilder<List<RecipeTag>, ApiError>(
        cubit: tagsCubit,
        onInitial: (context, state) {
          return Text("Data not fetched yet");
        },
        onSuccess: (context, state) {
          return Column(
            children: [
              _buildTags(context, state),
              ElevatedButton(
                onPressed: () {
                  findRecipeCubit.call();
                  Navigator.of(context).pop();
                },
                child: Text("Search"),
              )
            ],
          );
        },
        onInProgress: (context, state) {
          return Center(child: CircularProgressIndicator());
        },
        onFailure: (context, state) {
          return Text("NO DATA, ${state.error.message}");
        },
      ),
    );
  }

  Widget _buildTags(BuildContext context, RequestSuccess<List<RecipeTag>> state) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        return Wrap(
          children: state.result.map((tag) {
            final isSelected = filterState.filterOption.tags.contains(tag);
            return InkWell(
              onTap: () {
                filterBloc.toggleTag(tag);
              },
              child: Chip(
                onDeleted: isSelected ? () => filterBloc.toggleTag(tag) : null,
                label: Text(tag.translationKey),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
