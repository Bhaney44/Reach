'reach 0.1';

const stdlib = await loadStdlib();
const startingBalance = stdlib.parseCurrency(0);

// votes
participant(Voter0, participantInteractInterface, Bool)
participant(Voter1, participantInteractInterface, Bool)
participant(Voter2, participantInteractInterface, Bool)

// count votes
function vote {
    var accVote0 = await stdlib.newTestAccount(startingBalance);
    var accVote1 = await stdlib.newTestAccount(startingBalance);
    var accVote2 = await stdlib.newTestAccount(startingBalance);

    total = Voter0 + Voter1 + Voter2

    if total > 1:
        accVote2 =+ 1
}

vote
    
