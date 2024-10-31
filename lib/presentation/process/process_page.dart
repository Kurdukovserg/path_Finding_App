import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pathfinding/constants/strings.dart';
import 'package:pathfinding/core/bloc/page.dart';
import 'package:pathfinding/presentation/components/app_bar.dart';
import 'package:pathfinding/presentation/process/block/process_page_bloc.dart';

@RoutePage()
class ProcessPage extends StatefulWidget {
  const ProcessPage({super.key});

  @override
  State<ProcessPage> createState() => _ProcessPageState();
}

class _ProcessPageState extends PageState<ProcessPage, ProcessPageBloc,
    PageEvent, PageBlocState, PageNotification> {
  @override
  PageEvent? get initialEvent => Init();

  @override
  Widget buildPage(BuildContext context, PageBlocState state) {
    return Scaffold(
      appBar: PFAppBar(title: Strings.computationScreenName),
      body: switch (state) {
        InitialState() => Center(
            child: CircularProgressIndicator(),
          ),
        LoadingState() => Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: CircularProgressIndicator(

              ),
            ),
          ),
        ErrorState() => Center(
            child: Text(state.errorMessage),
          ),
        UpdatedState() => Column(
            children: [
              Text(Strings.calculationsFinished),
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  value: 100,
                ),
              ),
            ],
          ),
      },
    );
  }

  @override
  void onNotification(BuildContext context, PageNotification notification) {
    // TODO: implement onNotification
  }
}
