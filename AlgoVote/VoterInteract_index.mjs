/// Imports
import { loadStdlib } from '@reach-sh/stdlib';
import * as backend from './build/index.main.mjs';
import { ask, yesno, done } from '@reach-sh/stdlib/ask.mjs';


//function
(async () => {
  const stdlib = await loadStdlib();

  /// Vote Yes/No
  //variable
  const isAlice = await ask(
    `Vote yes or no`,
    yesno
  );
  
  /// voter 1
  //variable
  const who = isAlice ? 'Voter 0' : 'Voter 1';
  console.log(`Starting Vote ${who}`);

  // let account equal null
  let acc = null;

  /// confirmation / question two
  const createAcc = await ask(
    `Confirm yes or no`,
    yesno
  );
  
  /// create new account
  if (createAcc) {
    acc = await stdlib.newTestAccount(stdlib.parseCurrency(1000));
  } else {
    const secret = await ask(
      `What is your account secret?`,
      (x => x)
    );
    acc = await stdlib.newAccountFromSecret(secret);
  }

  let ctc = null;
  const deployCtc = await ask(
    `Execute`,
    yesno
  );

  // if statement
  if (deployCtc) {
    ctc = acc.deploy(backend);
    const info = await ctc.getInfo();
    console.log(`The contract is deployed as = ${JSON.stringify(info)}`);
  } else {
    const info = await ask(
      `Please paste the contract information:`,
      JSON.parse
    );
    ctc = acc.attach(backend, info);
  }

  // variables
  const fmt = (x) => stdlib.formatCurrency(x, 4);
  const getBalance = async () => fmt(await stdlib.balanceOf(acc));

  // New Bal
  const before = await getBalance();
  console.log(`Your balance is ${before}`);

  // constant
  const interact = { ...stdlib.hasRandom };

  // inform
  interact.informTimeout = () => {
    console.log(`There was a timeout.`);
    process.exit(1);
  };

  ///Place your bet
  if (isAlice) {
    const amt = await ask(
      `How much do you want to wager?`,
      stdlib.parseCurrency
    );
    interact.wager = amt;
  } else {
    interact.acceptWager = async (amt) => {
      const accepted = await ask(
        `Do you accept the wager of ${fmt(amt)}?`,
        yesno
      );
      if (accepted) {
        return;
      } else {
        process.exit(0);
      }
    };
  }

  /// Rock paper scissors
  const HAND = ['Up', 'Push', 'Down'];
  const HANDS = {
    'Up': 0, 'R': 0, 'r': 0,
    'Push': 1, 'P': 1, 'p': 1,
    'Down': 2, 'S': 2, 's': 2,
  };

  /// get hand
  interact.getHand = async () => {
    const hand = await ask(`What hand will you play?`, (x) => {
      /// variable
      const hand = HANDS[x];
      /// if
      if ( hand == null ) {
        throw Error(`Not a valid hand ${hand}`);
      }
      return hand;
    });
    console.log(`You played ${HAND[hand]}`);
    return hand;
  };

  /// Outcome
  const OUTCOME = ['Bob wins', 'Draw', 'Alice wins'];
  interact.seeOutcome = async (outcome) => {
    console.log(`The outcome is: ${OUTCOME[outcome]}`);
  };

  // constant
  const part = isAlice ? backend.Alice : backend.Bob;
  await part(ctc, interact);

  /// after bal
  const after = await getBalance();
  console.log(`Your balance is now ${after}`);

  done();
})();