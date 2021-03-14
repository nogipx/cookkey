import 'package:convenient_bloc/request_cubit.dart';
import 'package:cookkey/api.dart';
import 'package:cookkey/bloc/export.dart';
import 'package:cookkey/page/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sdk/domain.dart';

class SearchPage extends StatefulWidget with CookkeyApi {
  final FilterBloc filterBloc;

  SearchPage({
    Key key,
    @required this.filterBloc,
  }) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with CookkeyApi {
  final GlobalKey<ScaffoldState> _scaffold = GlobalKey();

  RequestCubit<List<Recipe>, ApiError> _filterRecipesCubit;

  @override
  void initState() {
    _filterRecipesCubit = getRecipesByFilter(context: context);
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
            builder: (context) => FilterWidget(
              filterBloc: widget.filterBloc,
              tagsCubit: getAllRecipeTags(context)..call(),
              findRecipeCubit: _filterRecipesCubit,
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
