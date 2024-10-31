import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pathfinding/core/bloc/page.dart';
import 'bloc/results_page_bloc.dart';

@RoutePage()
class ResultsPage extends StatefulWidget {
  static const pathIdParamName = 'id';

  const ResultsPage({
    super.key,
    @PathParam(pathIdParamName) required this.pathId,
  });

  final String pathId;

  @override
  State<ResultsPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends PageState<ResultsPage, ResultsPageBloc,
    PageEvent, PageBlocState, PageNotification> {
  @override
  Widget buildPage(BuildContext context, PageBlocState state) {
    // TODO: implement buildPage
    throw UnimplementedError();
  }

  @override
  void onNotification(BuildContext context, PageNotification notification) {
    // TODO: implement onNotification
  }
}
