// reach 0.1
'reach 0.1';

//constant player
// Fun([], Bool)
// define a participant interact interface that will be shared between the two players. 
// In this case, it provides two methods: getHand, which returns a number; and seeOutcome, which receives a number.

// Overview
// each set in the program is an interaction b/w the user and the contract
// Front end defines call backs
// Back end get things from you
// define things in the front end and move to back end

/////////////////////////////////////////////////////////
const Player =
      { getVote: Fun([], UInt),
        seeOutcome: Fun([UInt], Null) };

// publish is a push to blockchain
export const main =
  Reach.App(
    {},
    [Participant('Alice', Player), Participant('Bob', Player)],
    (A, B) => {
      A.only(() => {
        // pull getVote from .mjs
        const handA = declassify(interact.getVote()); });
      A.publish(handA);
      commit();

      // match Alice’s similar local step and joining of the application through a consensus transfer publication.
      // interact get vote
      B.only(() => {
        // pull getVote from .mjs
        const handB = declassify(interact.getVote()); });
      B.publish(handB);

      // computes the outcome of the game before committing. 
      const outcome = (handA + (4 - handB)) % 3;
      commit();

      each([A, B], () => {
        interact.seeOutcome(outcome); });
      exit(); });