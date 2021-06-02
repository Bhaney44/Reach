// reach 0.1
'reach 0.1';

// voting
export const main = Reach.App(()=> {
    const Alice = Participant ('Alice', {
        vote: Fun([], Bool)
    });
    const Bob = Participant('Bob', {});
    deploy();

Alice.only(() => {
    interact.getVote();
})

/// write program here
// assign user input for vote
const vote 0 = 0;
const vote 1 = 0;
const vote 2 = 1;

if (vote0 + vote2 + vote 3 < 1) {
    exit();
}

