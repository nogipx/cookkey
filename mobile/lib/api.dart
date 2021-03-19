import 'package:cookkey/bloc/export.dart';
import 'package:cookkey/ui/export.dart';
import 'package:flutter/material.dart';
import 'package:sdk/domain.dart';
import 'package:convenient_bloc/request_cubit.dart';
import 'package:provider/provider.dart';
import 'package:sdk/repo.dart';

mixin CookkeyApi {
  RequestCubit<List<RecipeTag>, ApiError> getAllRecipeTags(
      BuildContext context, TagRepo tagRepo) {
    return RequestCubit(
      () => tagRepo.getAllTags(),
      onRequestError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(AppSnackbar.error(error.message));
      },
    );
  }

  RequestCubit<List<Recipe>, ApiError> getRecipesByFilter({
    @required BuildContext context,
  }) {
    return RequestCubit(
      () => context
          .read<RecipeRepo>()
          .filterRecipes(filterOption: context.read<FilterBloc>().filterOption),
      onRequestError: (error) {
        ScaffoldMessenger.of(context).showSnackBar(AppSnackbar.error(error.message));
      },
    );
  }
}
