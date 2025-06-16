import 'dart:io';

void main() {
  // Read grid dimensions
  stdout.write("Enter number of rows: ");
  int rows = int.parse(stdin.readLineSync()!);

  stdout.write("Enter number of columns: ");
  int cols = int.parse(stdin.readLineSync()!);

  // Read grid content
  List<List<String>> grid = [];
  print("Enter grid row by row (each letter separated by space):");

  for (int i = 0; i < rows; i++) {
    stdout.write("Row ${i + 1}: ");
    List<String> row =
        stdin.readLineSync()!.trim().split(' ').map((e) => e.trim()).toList();

    if (row.length != cols) {
      print("Invalid number of columns. Expected $cols, got ${row.length}.");
      exit(1);
    }
    grid.add(row);
  }

  // Read patterns
  stdout.write("Enter center word (single character): ");
  String centerWord = stdin.readLineSync()!.trim();

  stdout.write("Enter diagonal pattern 1 (3 letters): ");
  String pattern1 = stdin.readLineSync()!.trim();

  stdout.write("Enter diagonal pattern 2 (3 letters): ");
  String pattern2 = stdin.readLineSync()!.trim();

  // Search and print result
  int result = searchWordDiag(grid, pattern1, pattern2, centerWord);
  print('\nTotal Matches Found: $result');
}

int searchWordDiag(List<List<String>> grid, String pattern1, String pattern2,
    String centerWord) {
  var wordCount = 0;
  var indexes = findAllIndexes(centerWord, grid);

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

  if (row == 0 ||
      row == grid.length - 1 ||
      col == 0 ||
      col == grid[0].length - 1) {
    return false;
  }

  String upLeft = grid[row - 1][col - 1];
  String downRight = grid[row + 1][col + 1];
  String upRight = grid[row - 1][col + 1];
  String downLeft = grid[row + 1][col - 1];

  if (upLeft == "A" || upRight == "A" || downLeft == "A" || downRight == "A") {
    return false;
  }

  bool isValidUp = ((upLeft + grid[row][col] + downRight) == pattern1) ||
      ((upLeft + grid[row][col] + downRight) == pattern2);

  bool isValidDown = ((upRight + grid[row][col] + downLeft) == pattern1) ||
      ((upRight + grid[row][col] + downLeft) == pattern2);

  if (isValidUp && isValidDown) {
    print("Match at [$row, $col]");
    return true;
  }

  return false;
}
