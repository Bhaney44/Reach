'reach 0.1';

const stdlib = await loadStdlib();
const startingBalance = stdlib.parseCurrency(10);
const accAlice = await stdlib.newTestAccount(startingBalance);
const accBob = await stdlib.newTestAccount(startingBalance);

const fmt = (x) => stdlib.formatCurrency(x, 4);
const getBalance = async (who) => fmt(await stdlib.balanceOf(who));
const beforeAlice = await getBalance(accAlice);
const beforeBob = await getBalance(accBob);

backend.Alice(ctcAlice, {
        Player('Alice'),
    wager: stdlib.parseCurrency(5),
}),

backend.Bob(ctcBob, {
        Player('Bob'),
    acceptWager: (amt) => {
        console.log('Bob accepts the wager of ${fmt(amt)},');
    },
}),

const afterAlice = await getBalance(accAlice);
const afterBob = await getBalance(accBob);

console.log('Alice went from ${beforeAlice} to ${afterAlice}.');
console.log('Bob went from ${beforeBob} to ${afterBob}.');

