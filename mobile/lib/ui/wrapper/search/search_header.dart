import 'package:cookkey/bloc/filter/filter_bloc.dart';
import 'package:cookkey/color.dart';
import 'package:cookkey/ui/atom/export.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';

class SearchHeader extends StatelessWidget {
  final FilterBloc filterBloc;

  const SearchHeader({
    Key key,
    @required this.filterBloc,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: Border(
        bottom: BorderSide(color: CookkeyColor.substrate),
      ),
      color: CookkeyColor.background,
      child: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              color: Colors.grey,
            ).padding(all: 8, right: 16),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
            BottomFilterOpener(
              child: IconButton(
                icon: Icon(
                  Icons.filter_alt,
                  color: CookkeyColor.primary,
                ),
                onPressed: null,
              ),
            )
          ],
        ),
      ),
    );
  }
}
