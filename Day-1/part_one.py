# Description: This is the main file for the Day-1 challenge


left = []
right = []
sum_array = []

# Read the input file and store the values in two lists
with open("input.txt", "r") as f:
    for line in f:
        data = line.split("  ")
        left.append(int(data[0]))
        right.append(int(data[1]))

left_sorted = sorted(left)
right_sorted = sorted(right)

for i in range(len(left_sorted)):
    sum_array.append(abs(left_sorted[i] - right_sorted[i]))

# add all the elements in the sum list
total = 0
for i in sum_array:
    total += i

print(total)
