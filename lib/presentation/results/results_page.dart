import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pathfinding/constants/strings.dart';
import 'package:pathfinding/core/bloc/page.dart';
import 'package:pathfinding/core/routing/router.dart';
import 'package:pathfinding/presentation/components/app_bar.dart';

import 'bloc/results_page_bloc.dart';

@RoutePage()
class ResultsPage extends StatefulWidget {
  const ResultsPage({
    super.key,
  });

  @override
  State<ResultsPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends PageState<ResultsPage, ResultsPageBloc,
    PageEvent, PageBlocState, PageNotification> {
  @override
  PageEvent? get initialEvent => Init();

  @override
  Widget buildPage(BuildContext context, PageBlocState state) {
    return Scaffold(
      appBar: PFAppBar(title: Strings.resultListTitle),
      body: switch (state) {
        LoadingState() => Center(
            child: CircularProgressIndicator(),
          ),
        ErrorState() => Center(
            child: Text(state.errorMessage),
          ),
        UpdatedState() => ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (context, i) => Column(
                  children: [
                    ListTile(
                      enabled: true,
                      enableFeedback: true,
                      title: Text(state.results[i].resultingPath),
                      onTap: (){
                        context.navigateTo(PreviewRoute(pathId: state.results[i].id));
                      },
                    ),
                    Divider(),
                  ],
                )),
      },
    );
  }

  @override
  void onNotification(BuildContext context, PageNotification notification) {
    // TODO: implement onNotification
  }
}
