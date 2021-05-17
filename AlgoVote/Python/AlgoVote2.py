
#Votes
Voter0 = int(input("Vote:"))
Voter1 = int(input("Vote:"))
Voter2 = int(input("Vote:"))

#Count
def count_votes():
    #Accounts
    voter0_account = 0
    voter1_account = 0 
    voter2_account = 0
    #Total
    total = Voter0 + Voter1 + Voter2
    #Return
    if total > 1:
        voter2_account =+ 1
        print(voter2_account)
    else:
        print(voter2_account)
count_votes()
