package main

import (
	"fmt"
	"io"
	"os"
	"regexp"
	"strconv"
)

func main() {
	// Open and read the input file
	content, err := readFile("input.txt")
	if err != nil {
		panic(fmt.Errorf("failed to read file: %w", err))
	}

	// Parse and process the instructions for part one
	first_sum := processInstructionsOne(content)

	// Parse and process the instructions for part two
	sum := processInstructionsTwo(content)

	// Output the final result
	fmt.Printf("Final Sum First: %d\n", first_sum)
	fmt.Printf("Final Sum: %d\n", sum)

}

// readFile reads the entire content of the file
func readFile(filename string) ([]byte, error) {
	file, err := os.Open(filename)

	if err != nil {
		return nil, err
	}

	data, err := io.ReadAll(file)

	if err != nil {
		return nil, err
	}

	return data, nil
}

// part-one
// processInstructionsOne parses the input and calculates the final sum
func processInstructionsOne(content []byte) int {
	re := regexp.MustCompile(`(?:mul\((\d+),(\d+)\))`)
	matches := re.FindAllStringSubmatch(string(content), -1)

	totalSum := 0

	for _, match := range matches {

		if len(match[0]) > 0 {
			//Process mul(x,y) when enabled
			if match[1] != "" && match[2] != "" {
				x, err1 := strconv.Atoi(match[1])
				y, err2 := strconv.Atoi(match[2])
				if err1 != nil || err2 != nil {
					fmt.Println("Error parsing integers:", match[1], match[2])
					continue
				}
				totalSum += x * y
			}

		}
	}

	return totalSum
}

// part-two
// processInstructions parses the input and calculates the final sum
func processInstructionsTwo(content []byte) int {
	re := regexp.MustCompile(`(?:mul\((\d+),(\d+)\))|(do\(\)|don't\(\))`)
	matches := re.FindAllStringSubmatch(string(content), -1)

	enabled := true
	totalSum := 0

	for _, match := range matches {
		//Check for control commands: do() or don't()
		if len(match[0]) > 0 {
			switch match[0] {
			case "do()":
				enabled = true
			case "don't()":
				enabled = false
			default:
				//Process mul(x,y) when enabled
				if enabled && match[1] != "" && match[2] != "" {
					x, err1 := strconv.Atoi(match[1])
					y, err2 := strconv.Atoi(match[2])
					if err1 != nil || err2 != nil {
						fmt.Println("Error parsing integers:", match[1], match[2])
						continue
					}
					totalSum += x * y
				}

			}
		}
	}

	return totalSum
}
