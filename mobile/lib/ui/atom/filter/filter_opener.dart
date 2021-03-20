import 'package:cookkey/ui/page/search/tags_collection.dart';
import 'package:cookkey/ui/import.dart';

class BottomFilterOpener extends StatelessWidget {
  final Widget child;
  final FilterBloc filterBloc;
  final RequestCubit<List<RecipeTag>, ApiError> tagsCubit;
  final RequestCubit<List<Recipe>, ApiError> filterRecipesCubit;

  const BottomFilterOpener({
    Key key,
    this.child,
    this.tagsCubit,
    this.filterRecipesCubit,
    this.filterBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet<dynamic>(
          context: context,
          isScrollControlled: true,
          builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TagsCollectionWidget(
                userPermission: context.read<AuthBloc>().userPermission,
                filterBloc: context.read<FilterBloc>(),
                tagsCubit: tagsCubit,
              ),
              ElevatedButton(
                onPressed: () {
                  filterRecipesCubit.call();
                  Navigator.of(context).pop();
                },
                child: Text("Search"),
              )
            ],
          ),
        );
      },
      child: child,
    );
  }
}
