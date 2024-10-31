import 'package:pathfinding/dtos/path_node.dart';

class PathFinderResult {
  final List<PathNode>? pathNodes;
  final String id;

  String get resultingPath {
    if(pathNodes == null) {
      return 'failure';
    }
    else {
      return pathNodes!.map((el) => '(${el.x},${el.y})').join('->');
    }
  }
  PathFinderResult(this.id, this.pathNodes);

}
