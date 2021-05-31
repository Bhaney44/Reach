// import
import { loadStdlib } from '@reach-sh/stdlib';
import * as backend from './build/index.main.mjs';

// async
(async () => {
  const stdlib = await loadStdlib();
  const startingBalance = stdlib.parseCurrency(10);

  const accAlice = await stdlib.newTestAccount(startingBalance);
  const accBob = await stdlib.newTestAccount(startingBalance);

  const ctcAlice = accAlice.deploy(backend);
  const ctcBob = accBob.attach(backend, ctcAlice.getInfo());

  // define arrays to hold the meaning of the hands and outcomes.
  const HAND = ['Yes', 'Yes', 'No'];
  const OUTCOME = ['Bob gets 5.00 Algo', 'Bob gets 5.00 Algo', 'Bob gets 0.00 Algo'];

  // defines a constructor for the Player implementation.
  const Player = (Who) => ({
    // get vote method
    getVote: () => {
      const hand = Math.floor(Math.random() * 3);
      console.log(`${Who} voted ${HAND[hand]}`);
      return hand;
    },
    // See outcome method
    seeOutcome: (outcome) => {
      console.log(`${Who} saw outcome ${OUTCOME[outcome]}`);
    },
  });

  //  instantiate the implementation once for Alice and once for Bob.
  await Promise.all([
    backend.Alice(
      ctcAlice,
      Player('Alice'),
    ),
    backend.Bob(
      ctcBob,
      Player('Bob'),
    ),
  ]);
})();