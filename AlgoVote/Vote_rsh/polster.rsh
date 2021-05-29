// Copyright Brian Haney 2021
// MIT License
// reach
'reach 0.1';
'use strict';

//Constants

const [ _, ALICE_WINS, BOB_WINS, TIMEOUT ] = makeEnum(3);

const Common = {
  showOutcome: Fun([UInt, UInt, UInt], Null),
};

// main
export const main =
  Reach.App(() => {

    // Options - ETH OR ALGO
    setOptions({ connectors: [ETH, ALGO ]});

    // Pollster
    // Constant
    // Participant
    // parameters - object: ticketpice, deadline, alice address, bob address
    const Pollster =
      Participant('Pollster', { ...Common,
        getParams: Fun([], Object({
          ticketPrice: UInt,
          deadline: UInt,
          aliceAddr: Address,
          bobAddr: Address }))
      });

    // Voter
    // getVot, voterWas
    // shouldVote

    const Voter =
      ParticipantClass('Voter',
      { ...Common,
        getVote: Fun([], Bool),
        voterWas: Fun([Address], Null),
        shouldVote: Fun([], Bool),
      });

    deploy();

    // Outcome
    const showOutcome = (which, forA, forB) => () => {
      each([Pollster, Voter], () =>
        interact.showOutcome(which, forA, forB)); };

    // Pollster 
    // ticketprice, deadline, alice Address, bob address

    Pollster.only(() => {
      const { ticketPrice, deadline, aliceAddr, bobAddr } =
        declassify(interact.getParams());
    });

    // Pollster
    // Publishticketprice, deadline, alice Address, bob address
    
    Pollster.publish(ticketPrice, deadline, aliceAddr, bobAddr);
    const [ timeRemaining, keepGoing ] = makeDeadline(deadline);

    // Constant
    const [ forA, forB ] =
      parallelReduce([ 0, 0])
      .invariant(balance() == (forA + forB) * ticketPrice)
      .while( keepGoing() )
      .case(Voter, (() => ({
          msg: declassify(interact.getVote()),
          when: declassify(interact.shouldVote()),
        })),
        ((_) => ticketPrice),
        ((forAlice) => {
          const voter = this;
          Voter.only(() => interact.voterWas(voter));
          const [ nA, nB ] = forAlice ? [ 1, 0 ] : [ 0, 1 ];
          return [ forA + nA, forB + nB ]; }))
      .timeout(timeRemaining(), () => {
        Anybody.publish();
        showOutcome(TIMEOUT, forA, forB)();
        return [ forA, forB ]; });

    // Outcome
    const outcome = forA >= forB ? ALICE_WINS : BOB_WINS;
    // Winner
    const winner = outcome == ALICE_WINS ? aliceAddr : bobAddr;
    transfer(balance()).to(winner);
    commit();

    // Show outcome
    showOutcome(outcome, forA, forB)();

  });