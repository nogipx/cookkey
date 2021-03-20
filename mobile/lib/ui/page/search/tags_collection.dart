import 'package:cookkey/bloc/export.dart';
import 'package:cookkey/ui/export.dart';
import 'package:cookkey/ui/widget/layout/two_column_layout.dart';
import 'package:flutter/material.dart';
import 'package:convenient_bloc/request_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdk/sdk.dart';
import 'package:dartx/dartx.dart';

class TagsCollectionWidget extends StatelessWidget {
  final FilterBloc filterBloc;
  final UserPermission userPermission;
  final RequestCubit<List<RecipeTag>, ApiError> tagsCubit;

  const TagsCollectionWidget({
    Key key,
    @required this.userPermission,
    @required this.filterBloc,
    @required this.tagsCubit,
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
            final tagsByCategory =
                state.result.groupBy((tag) => tag.category).entries.toList();
            final canEdit = userPermission.canAccess(UserPermission.admin());
            return BlocBuilder<FilterBloc, FilterState>(
              builder: (context, state) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: tagsByCategory.length,
                  itemBuilder: (context, index) {
                    final category = tagsByCategory[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TagsCategoryAtom(
                          canEdit: canEdit,
                          category: category.key,
                        ),
                        ColumnsLayout<RecipeTag>(
                          columns: 3,
                          items: category.value,
                          itemBuilder: (tag) => TagEditMiddleware(
                            hasEditPermission: canEdit,
                            child: TagChipAtom(
                              tag: tag,
                              onPressed: (_) => filterBloc.toggleTag(tag),
                              onDeleted: filterBloc.isTagSelected(tag)
                                  ? filterBloc.toggleTag
                                  : null,
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
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
}
