# Description: This is the part 2 file for the Day-1 challenge

left = []
right = []

# Read the input file and store the values in two lists
with open("input.txt", "r") as f:
    for line in f:
        data = line.split("  ")
        left.append(int(data[0]))
        right.append(int(data[1]))

my_dict = {3: 4, 5: 6, 7: 8}
result = {}

for location_id in left:
    for i in right:
        if location_id == i:
            result[location_id] = result.get(location_id, 0) + 1
        else:
            continue

similarity_score = 0
for key, value in result.items():
    similarity_score += key * value

print(similarity_score)