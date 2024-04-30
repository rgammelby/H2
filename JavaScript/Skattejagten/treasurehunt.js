// maximum amount of clicks +1
const clickCutoff = 6;

// pixel radius the player's click must be within in order to find the treasure
const treasureThreshold = 25;

// grabs the div element containing treasure chest image
const img = document.getElementById("treasure");

// grabs paragraph element containing directions for player
const callout = document.getElementById("help");

// grabs the canvas element containing the confetti animation
const canvas = document.getElementById("canvas");

// grabs map element
const map = document.getElementById("map");

// read map width and height
const mapWidth = map.offsetWidth;
const mapHeight = map.offsetHeight;

// set percentage to isolate map size
const widthPercentage = 40;
const heightPercentage = 25;

// set further percentages for isolating usable area of the map
const areaXPercentage = 32;
const areaYPercentage = 40;

// attempts to isolate playable area as a percentage of the total area on the monitor
// as the playable area is much smaller than the site / monitor as a whole
const areaWidth = (widthPercentage / 100) * mapWidth;
const areaHeight = (heightPercentage / 100) * mapHeight;
const areaX = (areaXPercentage / 100) * mapWidth;
const areaY = (areaYPercentage / 100) * mapHeight;
/* 
console.log(`New map height: ${areaY}, new map width: ${areaX}`); */

// sets initial click amount
let clickAmount = 0;

// sets variable for player click position
let cursorX;
let cursorY;

// sets variable for treasure position
let treasureX;
let treasureY;


// initialize treasure
document.addEventListener("DOMContentLoaded", function () {
    buryTreasure();
});

// log mouse coordinates when player clicks
document.addEventListener("click", treasureCheck);

function playConfetti() {
    canvas.hidden = false;
    callConfetti();
}

// checks whether the player has found the treasure
function treasureCheck() {
    // logs click coordinates to see whether they match the threshold of the treasure coordinates
    logMouseCoordinates();

    // if the player hasn't clicked too many times (5 by default)
    if (clickAmount < clickCutoff) {

        // if x and y values of the click is within the set threshold of the x and y values of the treasure
        if (Math.abs(cursorX - treasureX) <= treasureThreshold && Math.abs(cursorY - treasureY) <= treasureThreshold) {
            // let player know they've won
            callout.textContent = "Du har fundet skatten! \nNulstiller om 15 sekunder. ";

            // unveil the treasure chest
            discoverTreasure();

            // plays confetti
            playConfetti();

            // restarts the game after 15 seconds
            restart();
        }
        else {
            // if the player has not managed to click the treasure and still has clicks left, they're given instructions
            helpCallout();
        }

    // if the player has run out of clicks
    } else {
        // let the player know they've lost
        callout.textContent = "Desværre - du har tabt. \nNulstiller om 15 sekunder. ";

        // show them where the treasure was
        discoverTreasure();

        // restart the game after 15 seconds
        restart();
    }
}

// log mouse coordinates function
function logMouseCoordinates() {

    // increments the click counter
    clickAmount++;

    // sets variables for click coordinates
    cursorX = event.clientX;
    cursorY = event.clientY;/* 
    console.log(`X: ${cursorX}, Y: ${cursorY}`); */
}

// prepares and hides the treasure
function buryTreasure() {

    // hides canvas for confetti animation
    canvas.hidden = true;

    // hides treasure chest
    img.classList.remove('visible');

    // sets coordinates of treasure chest
    treasureX = areaX + Math.floor(Math.random() * areaWidth);
    treasureY = areaY + Math.floor(Math.random()* areaHeight);
    
    // ensures the treasure chest is centred on the chosen coordinates
    img.style.top = treasureY + "px";
    img.style.left = treasureX + "px";/* 
    console.log(`Treasure Coordinates: X: ${x}, Y: ${y}`);

    console.log(`minX: ${areaX}, minY: ${areaY}, maxX: ${areaX + areaWidth}, maxY: ${areaY + areaHeight}`); */
}

// restarts the game
function restart() {
    // reset the game / reload the page after 15 sec
    setTimeout(function () {
        location.reload();
    }, 15000);
}

// makes the treasure visible 
function discoverTreasure() {
    img.classList.add('visible');
    img.classList.remove('hidden');
}

// tells the player which direction the treasure is in
function helpCallout() {
    if (!(Math.abs(cursorX - treasureX) <= treasureThreshold) && cursorX > treasureX) {
        callout.textContent = "Længere til venstre... ";
    }
    else if (!(Math.abs(cursorX - treasureX) <= treasureThreshold) && cursorX < treasureX) {
        callout.textContent = "Længere til højre... ";
    }
    else if (Math.abs(cursorX - treasureX) <= treasureThreshold && cursorY > treasureY) {
        callout.textContent = "Længere op... ";
    }
    else if (Math.abs(cursorX - treasureX) <= treasureThreshold && cursorY < treasureY) {
        callout.textContent = "Længere ned... ";
    }
}