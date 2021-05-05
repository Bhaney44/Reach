'reach 0.1';

export const main =
    Reach.App(
    // Compilation options
    {},
    // Participants
    [Participant('Alice', {}), 
    Participant('Bob',{}),
    ],

    // body
    (A,B)=> {
        exit();
    }
)