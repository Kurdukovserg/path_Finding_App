import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/dtos/path_node.dart';
import 'package:pathfinding/dtos/result.dart';

abstract class PathFindingAlgorithm {
  PathFindingAlgorithm._();

  Future<PathFinderResult> compute(PathfinderField field);
}

PathFinderResult constructPath(PathNode? endNode) {
  if (endNode == null) {
    throw Exception("End node not found in path");
  }

  final List<PathNode> nodes = [];

  var currentNode = endNode;

  while (currentNode.nodeBefore!= null) {
    nodes.insert(0, currentNode);
    currentNode = currentNode.nodeBefore!;
  }

  // Insert the start node's coordinates
  nodes.insert(0, currentNode);


  return PathFinderResult(nodes);
}