////////////////////////////////////////////////////////////////////////
// Copyright Brian Haney and Archie Chaudhury 2021
// MIT License
////////////////////////////////////////////////////////////////////////
// Syntax Lib
// const - constant variable
// Participants - class
////////////////////////////////////////////////////////////////////////
// Parameters
// 3 participants
// Wager -> Stake
// getHand -> getVote
////////////////////////////////////////////////////////////////////////

// Reach
////////////////////////////////////////////////////////////////////////
'reach 0.1';

// Introduction
// Instance of the game
// isHand -> isVote
////////////////////////////////////////////////////////////////////////
const [ isVote, No, Indifferent, Yes ] = makeEnum(3);

// outcome
// Return_0 - Alice gets 0
// Return_NULL - Return_NULL
// Return_1 - Alice gets 1
////////////////////////////////////////////////////////////////////////
const [ isOutcome, Return_0, Return_NULL, Return_1 ] = makeEnum(3);

////////////////////////////////////////////////////////////////////////
// result
// hand -> vote
// const - VoteA and VoteB undefined
// Add Vote C
// The variables are defined by the arguments to the left of the arrow
////////////////////////////////////////////////////////////////////////

// Winner
////////////////////////////////////////////////////////////////////////
const winner = (VoteA, VoteB, VoteC) =>
      ((VoteA + VoteB + VoteC)/3);

// instances of results
////////////////////////////////////////////////////////////////////////
assert(winner(No, Indifferent) == Return_0);
assert(winner(Indifferent, No) == Return_1);
assert(winner(No, No) == Return_NULL);

// function to determine outcome
////////////////////////////////////////////////////////////////////////
forall(UInt, VoteA =>
  forall(UInt, VoteB =>
    assert(isOutcome(winner(VoteA, VoteB)))));

// function to determine outcome
////////////////////////////////////////////////////////////////////////
forall(UInt, (hand) =>
  assert(winner(hand, hand) == Return_NULL));

////////////////////////////////////////////////////////////////////////
// VOTERS
// variable Voter class
// replace Player with Voter
////////////////////////////////////////////////////////////////////////
const Voter =
      { ...hasRandom,
        getVote: Fun([], UInt),
        seeOutcome: Fun([UInt], Null),
        informTimeout: Fun([], Null) };

// call voter object Alice
const Alice =
      { ...Voter,
        stake: UInt };

// call voter object Cris
const Cris =
      { ...Voter,
        stake: UInt };

// call voter object Bob
// Bob accepts - Bob may also stake
// Consider adding a voting attribute
const Bob =
      { ...Voter,
        acceptstake: Fun([UInt], Null) };

// call voter object Cris
// Add third participant
const Cris =
      { ...Voter,
        acceptstake: Fun([UInt], Null) };

// Deadline
const DEADLINE = 10;

////////////////////////////////////////////////////////////////////////
// Reach App
// constant - Reach App
////////////////////////////////////////////////////////////////////////
export const main =
  Reach.App(
    {},

    ////////////////////////////////////////////////////////////////////////
    // participants
    // Add Participant - Cris
    ////////////////////////////////////////////////////////////////////////
    [Participant('Alice', Alice), Participant('Bob', Bob), Participant('Cris', Cris)],
    (A, B, C) => {
      const informTimeout = () => {
        each([A, B, C], () => {
          interact.informTimeout(); }); };

      ////////////////////////////////////////////////////////////////////////
      // Staking
      // Alice, Cris, Bob Accepts (may stake)
      ////////////////////////////////////////////////////////////////////////
      // Alice stake
      A.only(() => {
        const stake = declassify(interact.stake); });
      A.publish(stake)
        .pay(stake);
      commit();
      // Cris stake
      C.only(() => {
        const stake = declassify(interact.stake); });
      C.publish(stake)
        .pay(stake);
      commit();
      // Bob validates stake
      B.only(() => {
        interact.acceptstake(stake); });
      B.pay(stake)
        .timeout(DEADLINE, () => closeTo(A, informTimeout));

      ////////////////////////////////////////////////////////////////////////
      // Outcome
      ////////////////////////////////////////////////////////////////////////
      // outcome - return_null
      var outcome = Return_NULL;
      // balance
      invariant(balance() == 2 * stake && isOutcome(outcome) );

      ////////////////////////////////////////////////////////////////////////
      // while outcome - return_null
      ////////////////////////////////////////////////////////////////////////
      while ( outcome == Return_NULL ) {
        commit();

        A.only(() => {
          const _VoteA = interact.getVote();
          const [_commitA, _saltA] = makeCommitment(interact, _VoteA);
          const commitA = declassify(_commitA); });
        A.publish(commitA)
          .timeout(DEADLINE, () => closeTo(B, informTimeout));
        commit();

        unknowable(B, A(_VoteA, _saltA));
        B.only(() => {
          const VoteB = declassify(interact.getVote()); });
        B.publish(VoteB)
          .timeout(DEADLINE, () => closeTo(A, informTimeout));
        commit();

        A.only(() => {
          const [saltA, VoteA] = declassify([_saltA, _VoteA]); });
        A.publish(saltA, VoteA)
          .timeout(DEADLINE, () => closeTo(B, informTimeout));
        checkCommitment(commitA, saltA, VoteA);

        outcome = winner(VoteA, VoteB);
        continue; }

      // assert outcome
      assert(outcome == Return_1 || outcome == Return_0);
      transfer(2 * stake).to(outcome == Return_1 ? A : B);
      commit();

      each([A, B], () => {
        interact.seeOutcome(outcome); });
      exit(); });