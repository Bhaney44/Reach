'reach 0.1';

const stdlib = await loadStdlib();

const startingBalance = stdlib.parseCurrency(0);

// votes
participant(Voter0, participantInteractInterface, Boolean)
participant(Voter1, participantInteractInterface, Boolean)
participant(Voter2, participantInteractInterface, Boolean)

// count votes
function
    var accVote0 = await stdlib.newTestAccount(startingBalance);
    var accVote1 = await stdlib.newTestAccount(startingBalance);
    var accVote2 = await stdlib.newTestAccount(startingBalance);

    total = Voter0 + Voter1 + Voter2

    if total > 1:
        accVote2 =+ 1

function
    