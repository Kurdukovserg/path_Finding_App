import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:pathfinding/constants/strings.dart';
import 'package:pathfinding/core/bloc/notifiable_bloc.dart';
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
      body: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: switch (state) {
          InitialState() => Center(
              child: CircularProgressIndicator(),
            ),
          LoadingState() => Center(
              child: Column(
                children: [
                  SizedBox.square(
                    dimension: 16,
                  ),
                  Text('${(state.percent ?? 0 * 100).toInt()}%'),
                  SizedBox.square(
                    dimension: 16,
                  ),
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      value: state.percent,
                    ),
                  ),
                ],
              ),
            ),
          ErrorState() => Center(
              child: Text(state.errorMessage),
            ),
          UpdatedState() => Padding(
              padding: MediaQuery.paddingOf(context)
                  .add(EdgeInsets.symmetric(horizontal: 16.0)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: buildCntent(state),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton(
                          onPressed: state.sendButtonEnabled
                              ? () {
                                  context
                                      .read<ProcessPageBloc>()
                                      .add(SendResults());
                                }
                              : null,
                          child: Text(
                            Strings.sendResultsButtonLabel,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        },
      ),
    );
  }

  Column buildCntent(UpdatedState state) {
    final String effectiveText = state.sendButtonEnabled
        ? Strings.calculationsFinished
        : Strings.resultsSending;

    return Column(
      children: [
        SizedBox.square(
          dimension: 32,
        ),
        Text(effectiveText),
        SizedBox.square(
          dimension: 16,
        ),
        if (state.sendButtonEnabled) ...[
          Text(Strings.fullPercentage),
          SizedBox.square(
            dimension: 16,
          ),
        ],
        SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            value: (state.sendButtonEnabled && !state.resultSent) ? 100 : null,
          ),
        ),
        SizedBox.square(
          dimension: 16,
        ),
        if (state.errorMessage?.isNotEmpty ?? false)
          Text(
            state.errorMessage!,
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  @override
  void onNotification(BuildContext context, PageNotification notification) {
    switch(notification) {
      case Computed():
        logInfo(notification.percent);
      case ResultsSent():
        logInfo('results sent');
    }
  }
}
