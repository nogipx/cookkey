import 'package:cookkey/bloc/auth_bloc.dart';
import 'package:cookkey/bloc/filter/export.dart';
import 'package:flutter/material.dart';
import 'package:convenient_bloc/request_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdk/sdk.dart';
import 'package:dartx/dartx.dart';

import 'export.dart';

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
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(top: 16, bottom: 32),
        child: RequestBuilder<List<RecipeTag>, ApiError>(
          cubit: tagsCubit,
          onInitial: (context, state) {
            return Text("Data not fetched yet");
          },
          onSuccess: (context, state) {
            final Map<RecipeTagCategory, List<RecipeTag>> tagsByCategory =
                state.result.groupBy((tag) => tag.category);
            return Column(
              children: [
                _buildTags(context, tagsByCategory),
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
      ),
    );
  }

  Widget _buildTags(BuildContext context, Map<RecipeTagCategory, List<RecipeTag>> tags) {
    final canEdit =
        context.read<AuthBloc>()?.userPermission?.canAccess(UserPermission.admin());

    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        final tagsWithCategory = tags.entries.toList();
        return ListView.builder(
          itemCount: tagsWithCategory.length,
          primary: false,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final tags = tagsWithCategory[index];
            final _offstage = tags.value != null && tags.value.isNotEmpty;
            if (!_offstage) {
              return SizedBox();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(tags.key?.translationKey ?? "Unknown category"),
                      if (canEdit != null && canEdit)
                        IconButton(
                          iconSize: 20,
                          splashRadius: 16,
                          icon: Icon(Icons.edit_outlined),
                          onPressed: () {},
                        ),
                    ],
                  ),
                  Wrap(
                    spacing: 8,
                    children: tags.value.map((tag) {
                      final isSelected = filterState.filterOption.tags.contains(tag);
                      return TagEditMiddleware(
                        hasEditPermission: canEdit,
                        child: InputChip(
                          label: Text(tag.translationKey),
                          onDeleted: isSelected ? () => filterBloc.toggleTag(tag) : null,
                          onPressed: () => filterBloc.toggleTag(tag),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
