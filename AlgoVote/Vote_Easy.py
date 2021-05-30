#Copyright Brian Haney 2021
# Vote
def vote():
    voter0 = float(input('voter0 vote 1 for yes or 0 for no:'))
    voter1 = float(input('voter0 vote 1 for yes or 0 for no:'))
    voter2 = float(input('voter0 vote 1 for yes or 0 for no:'))
    total = voter0 + voter1 + voter2
    consensus = total/3
    if consensus > 0.50:
        print("move 5 algo to voter0")
    else:
        print("move declined")
vote()
