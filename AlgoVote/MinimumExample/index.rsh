// reach 0.1
'reach 0.1';

//constant player
// Fun([], Bool)

const Player =
      { getVote: Fun([], UInt),
        seeOutcome: Fun([UInt], Null) };

export const main =
  Reach.App(
    {},
    [Participant('Alice', Player), Participant('Bob', Player)],
    (A, B) => {
      A.only(() => {
        const handA = declassify(interact.getVote()); });
      A.publish(handA);
      commit();

      B.only(() => {
        const handB = declassify(interact.getVote()); });
      B.publish(handB);

      const outcome = (handA + (4 - handB)) % 3;
      commit();

      each([A, B], () => {
        interact.seeOutcome(outcome); });
      exit(); });