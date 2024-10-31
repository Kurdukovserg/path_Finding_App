import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pathfinding/presentation/home/home_page.dart';
import 'package:pathfinding/presentation/preview_page/preview_page.dart';
import 'package:pathfinding/presentation/process/process_page.dart';
import 'package:pathfinding/presentation/results/results_page.dart';

part 'router.gr.dart';

@singleton
@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter();

  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        path: '/',
        page: HomeRoute.page,
        initial: true,
      ),
      AutoRoute(
        path: '/process',
        page: ProcessRoute.page,
      ),
      AutoRoute(
        path: '/results',
        page: PreviewRoute.page,
      ),
      AutoRoute(
        path: '/details/:${ResultsPage.pathIdParamName}',
        page: ResultsRoute.page,
      ),
    ];
  }
}