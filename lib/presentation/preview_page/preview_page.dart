import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pathfinding/constants/colors.dart';
import 'package:pathfinding/constants/strings.dart';
import 'package:pathfinding/core/bloc/page.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/dtos/field_dot.dart';
import 'package:pathfinding/dtos/result.dart';
import 'package:pathfinding/presentation/components/app_bar.dart';
import 'package:pathfinding/presentation/preview_page/bloc/preview_page_bloc.dart';

@RoutePage()
class PreviewPage extends StatefulWidget {
  static const pathIdParamName = 'id';

  const PreviewPage({
    super.key,
    @PathParam(pathIdParamName) required this.pathId,
  });

  final String pathId;

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends PageState<PreviewPage, PreviewPageBloc,
    PageEvent, PageBlocState, PageNotification> {
  @override
  PageEvent? get initialEvent => Init(id: widget.pathId);

  @override
  Widget buildPage(BuildContext context, PageBlocState state) {
    return Scaffold(
      appBar: PFAppBar(title: Strings.detailsScreenTitle),
      body: switch (state) {
        LoadingState() => Center(
            child: CircularProgressIndicator(),
          ),
        ErrorState() => Center(
            child: Text(state.errorMessage),
          ),
        UpdatedState() => _buildUpdatedState(context, state),
      },
    );
  }

  @override
  void onNotification(BuildContext context, PageNotification notification) {
    // TODO: implement onNotification
  }

  Widget _buildUpdatedState(BuildContext context, UpdatedState state) {
    List<Widget> tiles = [];
    for (int i = 0; i < state.field.field.length; i++) {
      for (int j = 0; j < state.field.field.first.length; j++) {
        final node = state.field.field[i][j];
        tiles.add(
          ListTile(
            title: Center(
              child: Text(
                '(${node.x}, ${node.y})',
              ),
            ),
            tileColor: _resolveTileColor(node, state.field, state.result),

          ),
        );
      }
    }

    return Column(
      children: [
        GridView.count(
          crossAxisCount: state.field.field.length,
          shrinkWrap: true,
          children: tiles,
        ),
        Text(state.result.resultingPath),
      ],
    );
  }

  Color? _resolveTileColor(FieldDot node, PathfinderField field, PathFinderResult result, ) {
    if(node.disabled) {
      return PFColors.blockedNodeColor;
    } else if(node.y == field.start.y && node.x == field.start.x) {
      return PFColors.startingNodeColor;
    }
    else if(node.y == field.end.y && node.x == field.end.x) {
      return PFColors.finalNodeColor;
    }
    else if(result.pathNodes!.any((dot)=>(dot.y == node.y)&&(dot.x == node.x))){
      return PFColors.pathNodeColor;
    }
  }
}
