#Copyright Algorand Autonomous 2021
#License MIT

#Stake
Stake0 = Entry(master, relief = 'groove', width = 20)
Stake1 = Entry(master, relief = 'groove', width = 20)
Stake2 = Entry(master, relief = 'groove', width = 20)

#Vote
Vote0 = Entry(master, relief = 'groove', width = 20)
Vote1 = Entry(master, relief = 'groove', width = 20)
Vote2 = Entry(master, relief = 'groove', width = 20)

#Return
Return0 = Entry(master, relief = 'groove', width = 20)
Return1 = Entry(master, relief = 'groove', width = 20)
Return2 = Entry(master, relief = 'groove', width = 20)

#write to file function
def consensus():
    #Add votes
        Vote00 = int(Vote0.get())
        Vote11 = int(Vote1.get())
        Vote22 = int(Vote2.get())
        total_up_votes = Vote00 + Vote11 + Vote22
        #Stake
        Stake00 = int(Stake0.get())
        Stake11 = int(Stake1.get())
        Stake22 = int(Stake2.get())
        Total_Stake = Stake00 + Stake11 + Stake22
        #Return
        if total_up_votes > 1:
                Return00 = Stake00/Total_Stake * 10
                Return0.insert(0, Return00)
                Return11 = Stake11/Total_Stake * 10
                Return1.insert(0, Return11)
                Return22 = Stake22/Total_Stake * 10
                Return2.insert(0, Return22)
                
        else:
            print("Zero")
            Return0.insert(0, 0)
            Return1.insert(0, 0)
            Return2.insert(0, 0)



def clear():
    Return0.delete(0, END)
    Return1.delete(0, END)
    Return2.delete(0, END)
    Stake0.delete(0, END)
    Stake1.delete(0, END)
    Stake2.delete(0, END)
    Vote0.delete(0, END)
    Vote1.delete(0, END)
    Vote2.delete(0, END)



#Button to run write
b1 = Button(master, text = 'Calculate Consensus', relief = 'groove', width = 25, command=consensus)
b2 = Button(master, text = 'New Vote', relief = 'groove', width = 25, command=clear)
