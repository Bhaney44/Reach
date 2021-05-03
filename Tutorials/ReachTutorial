// Reach is mostly javascript
// Reach describes applications
// Reach produces middleware and smart contract

'rach 0.1';

export const main =
    Reach.App(
        {},
        [Participant("Alice", {}),
        Participant("Bob", {}),
        ],

        (A,B)=> {
            exit();
        }
    )

index.rsh
import { loadStdlib } from '@reach-sh/stdlib';
import * as backend from './build/index.main.mjs';

// write function
(async () => {
    const stdlib = await loadStdlib();
    const startingBalance = stdlib.parseCurrency(10);

    const accAlice = await stdlib.newTestAccount(StartingBalance);
    const accBob = await stdlib.newTestAccount(StartingBalance);

    const ctcAlice = accAlice.deploy(backend);
    const ctcBob.attach(backend, ctcAlice.getInfo());

    await Promise.all([
        backend.Alice(
            ctcAlice,
            {}
        ),
        backend.Bob(
            ctcBob,
            {}
        ),
    ])

})();