int searchWordDiag(List<List<String>> grid, String pattern1, String pattern2,
    String centerWord) {
  var wordCount = 0;

  // Find all indexes of the centerWord in the grid
  var indexes = findAllIndexes(centerWord, grid);

  // For each index, check if it matches the surrounding word patterns
  for (List<int> index in indexes) {
    if (matchDiag(index, pattern1, pattern2, grid)) {
      wordCount++;
    }
  }

  return wordCount;
}

List<List<int>> findAllIndexes(String char, List<List<String>> grid) {
  List<List<int>> indexes = [];
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid[0].length; j++) {
      if (grid[i][j] == char) {
        indexes.add([i, j]);
      }
    }
  }
  return indexes;
}

bool matchDiag(List<int> gridPosition, String pattern1, String pattern2,
    List<List<String>> grid) {
  int row = gridPosition[0];
  int col = gridPosition[1];

  // Ensure we are not at the grid boundaries (we need space for diagonal checks)
  if (row == 0 ||
      row == grid.length - 1 ||
      col == 0 ||
      col == grid[0].length - 1) {
    return false;
  }

  // Get diagonal neighbors in both directions:
  String upLeft = grid[row - 1][col - 1]; // Upper-left diagonal
  String downRight = grid[row + 1][col + 1]; // Lower-right diagonal
  String upRight = grid[row - 1][col + 1]; // Upper-right diagonal
  String downLeft = grid[row + 1][col - 1]; // Lower-left diagonal

  // Check if the diagonals contain the letter "A", which should not be part of the diagonal pattern
  if (upLeft == "A" || upRight == "A" || downLeft == "A" || downRight == "A") {
    return false;
  }

  // Check diagonally for the pattern
  bool isValidUp = ((upLeft + grid[row][col] + downRight) == pattern1) ||
      ((upLeft + grid[row][col] + downRight) == pattern2);

  bool isValidDown = ((upRight + grid[row][col] + downLeft) == pattern1) ||
      ((upRight + grid[row][col] + downLeft) == pattern2);

  if (isValidUp && isValidDown) {
    print([
      [upLeft, grid[row][col], downRight],
      [upRight, grid[row][col], downLeft]
    ]);
    return true;
  }

  return false;
}
