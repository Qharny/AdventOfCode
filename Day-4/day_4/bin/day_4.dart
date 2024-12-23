import 'dart:io';

import 'package:day_4/part_two.dart';

void main(List<String> arguments) async {
  final file = File('input.txt');

  try {
    // Wait for the file to be read
    String contents = await file.readAsString();
    var grid = makeGrid(contents);
    var wordCount = searchWord(grid, "XMAS");
    var wordCount2 = searchWordDiag(grid, "MAS", "SAM", "A");

    print('Word Count: $wordCount');
    print('Diagonal Word Count: $wordCount2');
  } catch (e) {
    print('Error: $e');
  }
}

List<List<int>> directionVectors = [
  [0, 1], // Right
  [0, -1], // Left
  [-1, 0], // Up
  [1, 0], // Down
  [1, -1], // Down-Left (Diagonal)
  [1, 1], // Down-Right (Diagonal)
  [-1, 1], // Up-Right (Diagonal)
  [-1, -1], // Up-Left (Diagonal)
];

List<List<String>> makeGrid(String content) {
  List<List<String>> grid = List.empty(growable: true);
  // Split contents into rows
  List<String> lines = content.split('\n');

  // Process each row into a list of columns
  for (String row in lines) {
    if (row.isEmpty) {
      continue;
    }
    List<String> columns = row.split('');
    grid.add(columns);
  }

  return grid;
}

int searchWord(List<List<String>> grid, String word) {
  var numRows = grid.length;
  var numCols = grid[0].length;
  var wordLength = word.length;
  var wordCount = 0;

  // Traverse the grid cell by cell
  for (int row = 0; row < numRows; row++) {
    for (int col = 0; col < numCols; col++) {
      // For each cell, traverse in all directions
      for (List<int> direction in directionVectors) {
        var newRow = row;
        var newCol = col;
        int charIndex;

        // Traverse in the current direction trying to find the word
        for (charIndex = 0; charIndex < wordLength; charIndex++) {
          // Check if the new row and column are within the grid
          if (newRow < 0 ||
              newCol < 0 ||
              newRow >= numRows ||
              newCol >= numCols) {
            break;
          }
          // Check if the character at the current index matches the word
          if (grid[newRow][newCol] != word[charIndex]) {
            break; // No match, so break out of the loop
          }
          // Move to the next cell in the current direction
          newRow += direction[0];
          newCol += direction[1];
        }
        // If the loop completed without breaking, then the word was found
        if (charIndex == wordLength) {
          wordCount += 1;
        }
      }
    }
  }
  return wordCount;
}

int searchWordDiag(List<List<String>> grid, String pattern1, String pattern2,
    String centerWord) {
  int wordCount = 0;

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
