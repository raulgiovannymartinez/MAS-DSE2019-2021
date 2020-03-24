
# define dice for Alice and Bob
a_dice = [1,2,3,4,5,6]
b_dice = [1,2,3,4,5,6]

# find all possible combinations of rolls (Alice roll, Bob roll)
rolls_comb = [(x,y) for x in a_dice for y in b_dice]

# define starting number of balls for each
a_balls = 6
b_balls = 10

# calculate the number of balls given in each outcome
outcomes = []
for i in rolls_comb:
    a_outcome = a_balls - i[0] + i[1]
    b_outcome = b_balls - i[1] + i[0]
    outcomes.append((a_outcome, b_outcome))
    
# a. Alice has more balls than Bob
part_a = 100 * sum([i[0] > i[1] for i in outcomes]) / len(outcomes)
    
# b. Both have number of balls
part_b = 100 * sum([i[0] == i[1] for i in outcomes]) / len(outcomes)
    
# c. Alice has less balls than Bob
part_c = 100 * sum([i[0] < i[1] for i in outcomes]) / len(outcomes)


