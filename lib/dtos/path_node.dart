enum NodeState { start, end, disabled, none, visited }

abstract class PathNode {
  final int x;
  final int y;
  PathNode? nodeBefore;

  PathNode(this.x, this.y);
}


class Change {
  final int x;
  final int y;
  final NodeState newState;

  Change(this.x, this.y, this.newState);
}