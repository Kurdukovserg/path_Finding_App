import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pathfinding/constants/strings.dart';
import 'package:pathfinding/core/bloc/view.dart';
import 'package:pathfinding/core/routing/router.dart';
import 'package:pathfinding/presentation/components/app_bar.dart';
import 'package:pathfinding/presentation/home/bloc/home_page_bloc.dart';
import 'package:pathfinding/services/validation.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  FormState get _form => _formKey.currentState!;
  final TextEditingController _apiFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PFAppBar(
        title: Strings.homeScreenName,
      ),
      body: Padding(
        padding: MediaQuery.paddingOf(context)
            .add(EdgeInsets.symmetric(horizontal: 16.0)),
        child:
            BaseView<HomePageBloc, PageEvent, PageBlocState, PageNotification>(
          onNotification:
              (BuildContext context, PageNotification notification) {
            switch (notification) {
              case FieldsFetchedNotification():
                context.pushRoute(ProcessRoute());
            }
          },
          builder: (BuildContext context, PageBlocState state) {
            return switch (state) {
              LoadingState() => Center(
                  child: Column(
                    children: [
                      Text(Strings.dataReceiving),
                      SizedBox.square(dimension: 16,),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              ErrorState() => Center(
                  child: Text(state.errorMessage),
                ),
              UpdatedState() => Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(Strings.homeScreenText),
                          SizedBox(
                            height: 16,
                            width: 16,
                          ),
                          TextFormField(
                            controller: _apiFieldController,
                            validator: (value) => Validate.uriValidation(value),
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.compare_arrows),
                              isCollapsed: true,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: FilledButton(
                            onPressed: () {
                              if (_form.validate()) {
                                context.read<HomePageBloc>().add(
                                    SaveUri(baseUri: _apiFieldController.text));
                              }
                            },
                            child: Text(
                              Strings.startButtonLabel,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                )
            };
          },
        ),
      ),
    );
  }
}
