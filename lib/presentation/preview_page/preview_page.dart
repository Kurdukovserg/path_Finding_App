import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pathfinding/core/bloc/page.dart';
import 'package:pathfinding/presentation/preview_page/bloc/preview_page_bloc.dart';

@RoutePage()
class PreviewPage extends StatefulWidget {
  const PreviewPage({super.key});

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends PageState<PreviewPage, PreviewPageBloc,
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
