class Instrument {
    constructor(name) {
        this.name = name;
    }

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

    let props = document.getElementById("properties");
    props.textContent = "";

    instruments.forEach(Instrument => {
        props.innerHTML += ` <br> Instrument: ${Instrument.name} <br>`;

        if (Instrument instanceof Stringed) {
            props.innerHTML += `Strings: ${Instrument.numberOfStrings} <br>`;
        }

        if (Instrument instanceof Harp) {
            props.innerHTML += `Height: ${Instrument.height} cm <br>`;
        }

        if (Instrument instanceof Guitar || Instrument instanceof Saxophone || Instrument instanceof Flute) {
            props.innerHTML += `Material: ${Instrument.material} <br>`;
        }

        if (Instrument instanceof Flute) {
            props.innerHTML += `Holes: ${Instrument.holes} <br>`;
        }
    });
}