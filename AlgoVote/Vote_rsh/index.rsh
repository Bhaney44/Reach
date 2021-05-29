// Copyright brian haney and archie chaudhury 2021
// MIT License

// Syntax Lib
// const - constant variable
//

// Parameters
// 3 participants

// reach
'reach 0.1';

// introduction
// instanc of the game
const [ isHand, No, Indifferent, Yes ] = makeEnum(3);
// outcome
// Return_0 - Alice gets 0
// Return_NULL - Return_NULL
// Return_1 - Alice gets 1
const [ isOutcome, Return_0, Return_NULL, Return_1 ] = makeEnum(3);

// result
const winner = (handA, handB) =>
      ((handA + (4 - handB)) % 3);

// instances of results
assert(winner(No, Indifferent) == Return_0);
assert(winner(Indifferent, No) == Return_1);
assert(winner(No, No) == Return_NULL);

// function to determine outcome
forall(UInt, handA =>
  forall(UInt, handB =>
    assert(isOutcome(winner(handA, handB)))));

// function to determine outcome
forall(UInt, (hand) =>
  assert(winner(hand, hand) == Return_NULL));

// variable Voter class
// replace Voter with Voter
const Voter =
      { ...hasRandom,
        getHand: Fun([], UInt),
        seeOutcome: Fun([UInt], Null),
        informTimeout: Fun([], Null) };

// call voter object Alice
const Alice =
      { ...Voter,
        wager: UInt };

// call voter object Bob
const Bob =
      { ...Voter,
        acceptWager: Fun([UInt], Null) };

// call voter object Cris
// Add third participant
const Cris =
      { ...Voter,
        acceptWager: Fun([UInt], Null) };


// Deadline
const DEADLINE = 10;

//  constant - Reach App
export const main =
  Reach.App(
    {},
    // participants
    [Participant('Alice', Alice), Participant('Bob', Bob)],
    (A, B) => {
      const informTimeout = () => {
        each([A, B], () => {
          interact.informTimeout(); }); };

      A.only(() => {
        const wager = declassify(interact.wager); });
      A.publish(wager)
        .pay(wager);
      commit();

      B.only(() => {
        interact.acceptWager(wager); });
      B.pay(wager)
        .timeout(DEADLINE, () => closeTo(A, informTimeout));

      var outcome = Return_NULL;
      invariant(balance() == 2 * wager && isOutcome(outcome) );
      while ( outcome == Return_NULL ) {
        commit();

        A.only(() => {
          const _handA = interact.getHand();
          const [_commitA, _saltA] = makeCommitment(interact, _handA);
          const commitA = declassify(_commitA); });
        A.publish(commitA)
          .timeout(DEADLINE, () => closeTo(B, informTimeout));
        commit();

        unknowable(B, A(_handA, _saltA));
        B.only(() => {
          const handB = declassify(interact.getHand()); });
        B.publish(handB)
          .timeout(DEADLINE, () => closeTo(A, informTimeout));
        commit();

        A.only(() => {
          const [saltA, handA] = declassify([_saltA, _handA]); });
        A.publish(saltA, handA)
          .timeout(DEADLINE, () => closeTo(B, informTimeout));
        checkCommitment(commitA, saltA, handA);

        outcome = winner(handA, handB);
        continue; }

      assert(outcome == Return_1 || outcome == Return_0);
      transfer(2 * wager).to(outcome == Return_1 ? A : B);
      commit();

      each([A, B], () => {
        interact.seeOutcome(outcome); });
      exit(); });