import React, { useEffect } from 'react';

// reset button component
function Button() {
    // reset game component actually just reloads the page
    const resetGame = () => {
        console.log("Restarting.");
        window.location.reload();
    };

    // sets and removes eventlistener on the restart button
    useEffect(() => {
        const button = document.getElementById("restart");
        button.addEventListener("click", resetGame);

        // does not work without removing the eventlistener after click, for some reason
        return () => {
            button.removeEventListener("click", resetGame);
        };
    }, []);

    // actual button html
    return (
        <button id="restart" disabled>Restart!</button>
    );
}

export default Button;
