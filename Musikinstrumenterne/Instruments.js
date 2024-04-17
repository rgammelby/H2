class Instrument {
    constructor(name) {
        this.name = name;
    }

    // the play method plays a sound file from the soundfiles folder
    // it plays the file associated with the chosen instrument, example: soundfiles/guitar.mp3
    play(instrument) {
        console.log(`Playing ${instrument} sound. `);
        let soundBite = new Audio('soundfiles/' + instrument + ".mp3");
        soundBite.play();
    }
}


class Stringed extends Instrument {
    constructor(name, numberOfStrings) {
        super(name);
        this.numberOfStrings = numberOfStrings;
    }
}

class Harp extends Stringed {
    constructor(name, numberOfStrings, height) {
        super(name, numberOfStrings);
        this.height = height;
    }
}

class Guitar extends Stringed {
    constructor(name, numberOfStrings, material) {
        super(name, numberOfStrings);
        this.material = material;
    }
}

class Saxophone extends Instrument {
    constructor(name, material) {
        super(name);
        this.material = material;
    }
}

class Flute extends Instrument {
    constructor(name, holes, material) {
        super(name);
        this.holes = holes;
        this.material = material;
    }
}

function printInstrumentProperties() {
    // instantiate instruments
    let instruments = [
        harp = new Harp('harp', 47, 140),
        guitar = new Guitar('guitar', 6, "wood"),
        sax = new Saxophone('saxophone', 'brass'),
        flute = new Flute('flute', 8, 'tin')
    ];

    // grabs paragraph element to contain instrument printouts
    let props = document.getElementById("properties");

    // resets
    props.textContent = "";

    // iterates through the array of instruments
    instruments.forEach(Instrument => {

        // prints name for all instruments (only shared attribute)
        props.innerHTML += ` <br> Instrument: ${Instrument.name} <br>`;

        // prints number of strings for any stringed instruments
        if (Instrument instanceof Stringed) {
            props.innerHTML += `Strings: ${Instrument.numberOfStrings} <br>`;
        }

        // prints height of harp (unique property)
        if (Instrument instanceof Harp) {
            props.innerHTML += `Height: ${Instrument.height} cm <br>`;
        }

        // prints material of guitar, saxophone and flute (this attribute is shared only by these 3 instruments)
        if (Instrument instanceof Guitar || Instrument instanceof Saxophone || Instrument instanceof Flute) {
            props.innerHTML += `Material: ${Instrument.material} <br>`;
        }

        // prints number of holes in the flue (unique property)
        if (Instrument instanceof Flute) {
            props.innerHTML += `Holes: ${Instrument.holes} <br>`;
        }
    });
}