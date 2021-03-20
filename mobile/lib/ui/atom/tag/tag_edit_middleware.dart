import 'package:flutter/material.dart';

class TagEditMiddleware extends StatelessWidget {
  final bool hasEditPermission;
  final Widget child;

  const TagEditMiddleware({
    Key key,
    @required this.hasEditPermission,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () async {
        if (!hasEditPermission) {
          return;
        }
        await showDialog<void>(
          context: context,
          builder: (context) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width * 0.75,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.edit_outlined),
                        label: Text("Edit"),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
      child: child,
    );
  }
}
