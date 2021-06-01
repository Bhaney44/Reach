// reach 0.1
'reach 0.1';

//constant player
// Fun([], Bool)
// define a participant interact interface that will be shared between the two players. 
// In this case, it provides two methods: getHand, which returns a number; and seeOutcome, which receives a number.
/////////////////////////////////////////////////////////
const Player =
      { getVote: Fun([], UInt),
        seeOutcome: Fun([UInt], Null) };

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
      B.only(() => {
        // pull getVote from .mjs
        const handB = declassify(interact.getVote()); });
      B.publish(handB);

      // computes the outcome of the game before committing. 

      //try
      // const total = handA + handB;
      // const outcome = total / 2
      // /////////////////////////////
      const outcome = (handA + (4 - handB)) % 3;
      commit();

      // An each local step statement can be written as each(PART_TUPLE () => BLOCK), 
      // where PART_TUPLE is a tuple of participants and BLOCK is a block. 
      // It is an abbreviation of many local step statements that could have been written with only.
      // interact.seeOutcome(outcome) invokes the seeOutcome method

      each([A, B], () => {
        interact.seeOutcome(outcome); });
      exit(); });