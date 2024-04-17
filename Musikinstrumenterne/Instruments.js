class Instrument {
    constructor(name) {
        this.name = name;
    }

    play(sound) {
        console.log("You've pressed play. ");
        let soundBite = new Audio('soundfiles/')
        soundBite.play();
    }
}

class Stringed extends Instrument {
    constructor(numberOfStrings) {
        this.numberOfStrings = numberOfStrings;
    }

    strings(numberOfStrings) {
        return this.numberOfStrings;
    }
}

class Harp extends Stringed {
    constructor(height) {
        this.height = height;
    }

    properties(height) {
        return this.height;
    }
}

class Guitar extends Stringed {
    constructor(material) {
        this.material = material;
    }

    properties(material) {
        return this.material;
    }
}

class Saxophone extends Instrument {
    constructor(material) {
        this.material = material;
    }

    properties(material) {
        return this.material;
    }
}

class Flute extends Instrument {
    constructor(holes, material) {
        this.holes = holes;
        this.material = material;
    }

    properties(holes, material) {
        return this.holes, this.material;
    }
}