'reach 0.1';

const Player =
    { getHand: Fun ([], UInt),
    seeOutcome: Fun([UInt], Null)};

export const main =
    Reach.App(
        {},
        [Participant('Alice', Player), Participant ('Bob', Player)],
        (A, B) => {
            // ...
            exit ();
        }
    )

const HAND = ['Rock', 'Paper', 'Scissors'];
const OUTCOME = ['Bob wins', 'Draw', 'Alice wins'];
const Player = (Who) => ({
    getHand: () => {
        const hand = Math.floor(Math.random()*3);
        console.log('${Who} played ${HAND[hand]}');
        return hand;
    },
    seeOutcome: (outcome) => {
        console.log('${Who} saw outcome ${Outcome[outcome]}')
    },
});

await Promise.all([
    backend.Alice
        ctcAlice,
        Player('Alice'),
    ),
    backend.Bob(
        ctcBob,
        Player('Bob'),
    ),
]);
// ...
