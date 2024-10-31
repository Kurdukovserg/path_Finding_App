import 'package:injectable/injectable.dart';
import 'package:pathfinding/dtos/field.dart';
import 'package:pathfinding/dtos/path_node.dart';
import 'package:pathfinding/dtos/result.dart';

import 'algorithm.dart';

@Injectable(as: PathFindingAlgorithm)
class AStarAlgorithm implements PathFindingAlgorithm {
  AStarAlgorithm() : super();

  @override
  Future<PathFinderResult> compute(PathfinderField fieldWrapper) async {
    final rows = fieldWrapper.field.length;
    final columns = fieldWrapper.field[0].length;
    final List<Change> changes = [];
    AStarNode? startNode;
    AStarNode? endNode;

    final grid = List.generate(
      rows,
      (row) => List.generate(
        columns,
        (col) {
          final fieldNode = fieldWrapper.field[row][col];
          AStarNode aStarNode = AStarNode(col, row,
              fieldNode.disabled ? NodeState.disabled : NodeState.none);
          if (fieldNode.x == fieldWrapper.start.x &&
              fieldNode.y == fieldWrapper.start.y) {
            aStarNode = AStarNode(col, row, NodeState.start);
            startNode = aStarNode;
          } else if (fieldNode.x == fieldWrapper.end.x &&
              fieldNode.y == fieldWrapper.end.y) {
            aStarNode = AStarNode(col, row, NodeState.end);
            endNode = aStarNode;
          }
          return aStarNode;
        },
      ),
    );

    if (startNode == null || endNode == null) {
      throw Exception("Start and End nodes need to be set");
    }
    startNode!.gScore = 0;
    startNode!.calculateFScore(endNode!);

    final List<AStarNode> openSet = [startNode!];
    final List<AStarNode> closedSet = [];

    while (openSet.isNotEmpty) {
      final currentNode = openSet.reduce((a, b) => a.fScore < b.fScore ? a : b);

      if (currentNode == endNode) {
        return constructPath(currentNode);
      }

      openSet.remove(currentNode);
      closedSet.add(currentNode);
      changes.add(Change(currentNode.x, currentNode.y, NodeState.visited));

      for (final neighbor in currentNode.getNeighbors(grid, rows, columns)) {
        if (closedSet.contains(neighbor) ||
            neighbor.nodeState == NodeState.disabled) {
          continue;
        }

        final tentativeGScore = currentNode.gScore + 1;
        if (tentativeGScore < neighbor.gScore) {
          neighbor.nodeBefore = currentNode;
          neighbor.gScore = tentativeGScore;
          neighbor.calculateFScore(endNode!);
        }

        if (!openSet.contains(neighbor)) {
          openSet.add(neighbor);
          changes.add(Change(neighbor.x, neighbor.y, NodeState.visited));
        }
      }
    }

    return PathFinderResult(null);
  }
}

class AStarNode extends PathNode {
  double gScore;
  int hScore;
  double fScore;
  NodeState nodeState;

  AStarNode(super.x, super.y, this.nodeState)
      : gScore = double.infinity,
        hScore = 0,
        fScore = 0;

  void calculateFScore(AStarNode endNode) {
    hScore = calculateHScore(endNode);
    fScore = gScore + hScore;
  }

  int calculateHScore(AStarNode endNode) {
    final dx = (x - endNode.x).abs();
    final dy = (y - endNode.y).abs();
    return dx + dy;
  }

  List<AStarNode> getNeighbors(
      List<List<AStarNode>> grid, int rows, int columns) {
    final neighbors = <AStarNode>[];
    if (y > 0) neighbors.add(grid[y - 1][x]);
    if (y < rows - 1) neighbors.add(grid[y + 1][x]);
    if (y > 0 && x > 0) neighbors.add(grid[y - 1][x - 1]);
    if (y < (rows - 1) && x < (columns - 1)) neighbors.add(grid[y + 1][x + 1]);
    if (y > 0 && x < (columns - 1)) neighbors.add(grid[y - 1][x + 1]);
    if (y < (rows - 1) && x > 0) neighbors.add(grid[y + 1][x - 1]);
    if (x > 0) neighbors.add(grid[y][x - 1]);
    if (x < columns - 1) neighbors.add(grid[y][x + 1]);

    // Filter out wall nodes if necessary
    return neighbors
        .where((node) => node.nodeState != NodeState.disabled)
        .toList();
  }
// Implement other methods specific to AStarNode
}
