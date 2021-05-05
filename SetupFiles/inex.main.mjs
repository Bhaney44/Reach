import {loadStdlib} from '@reach-sh/stdlib';
import * as backend from './build/index.main.mjs'

(async() => {
    const stdLib = await loadStdlib();
    const startingBalance = stdlib.parseCurrency(10);

    const accAlice = await stdLib.newTestAccount(startingBalance);
    const accBob = await stdLib.newTestAccount(startingBalance);

    const ctcAlice = accAlice.deploy(backend);
    const ctcBob = accBob.attach(backend, ctcAlice.getinfo());

    await Promise.all([ 
    backend.Allice(
        ctcAlice,
        {},
    )
    backend.Bob(
        ctcBob,
        {},
    ),
]);

})();