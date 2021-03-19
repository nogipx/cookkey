import 'package:convenient_bloc/request_cubit.dart';
import 'package:cookkey/api.dart';
import 'package:cookkey/ui/export.dart';
import 'package:sdk/domain.dart';
import 'package:cookkey/bloc/export.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget with CookkeyApi {
  SearchPage({
    Key key,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with CookkeyApi {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  FilterBloc _filterBloc;
  RequestCubit<List<RecipeTag>, ApiError> _tagsCubit;
  RequestCubit<List<Recipe>, ApiError> _filterRecipesCubit;

  @override
  void initState() {
    _filterBloc = context.read<FilterBloc>();
    _tagsCubit = context.read<RequestCubit<List<RecipeTag>, ApiError>>();
    _filterRecipesCubit = getRecipesByFilter(context: context);
    _tagsCubit.call();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet<dynamic>(
            context: context,
            isScrollControlled: true,
            builder: (context) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TagsCollectionWidget(
                  authBloc: context.read<AuthBloc>(),
                  filterBloc: _filterBloc,
                  tagsCubit: _tagsCubit,
                ),
                ElevatedButton(
                  onPressed: () {
                    _filterRecipesCubit.call();
                    Navigator.of(context).pop();
                  },
                  child: Text("Search"),
                )
              ],
            ),
          );
        },
        child: Icon(Icons.filter_alt_rounded),
      ),
      body: RequestBuilder<List<Recipe>, ApiError>(
        cubit: _filterRecipesCubit,
        onInitial: (_, __) => SizedBox(),
        onInProgress: (context, state) {
          return Center(child: CircularProgressIndicator());
        },
        onSuccess: (context, state) {
          return ListView.builder(
            itemCount: state.result.length,
            itemBuilder: (context, index) {
              final recipe = state.result[index];
              return Card(
                child: Column(
                  children: [
                    Text(recipe.title),
                    Text(recipe.description ?? ''),
                    Text(recipe.author.name ?? "unknown author"),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
