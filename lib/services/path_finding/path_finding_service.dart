import 'package:injectable/injectable.dart';
import 'package:pathfinding/services/path_finding/algorithm.dart';
import 'package:pathfinding/services/path_finding/astar.dart';

abstract class PathFindingService{
  PathFindingAlgorithm get algorithm;
}

@Injectable(as: PathFindingService)
class PathFindingServiceImpl implements PathFindingService{
  @override
  PathFindingAlgorithm get algorithm => AStarAlgorithm();
}