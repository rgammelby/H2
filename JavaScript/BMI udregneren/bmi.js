// calculates user BMI

function bmiCalc() {

    // variable declarations
    let height, weight, bmi, bmiDisplay;

    // variable assignments. grabs the input fields 'height' and 'weight',
    // as well as the paragraph tag which will contain the user's results.
    height = document.getElementById("height").value / 100;
    weight = document.getElementById("weight").value;
    bmiDisplay = document.getElementById("bmiDisplay");

    // ensures the user has input both their height & their weight before calculating
    if (height === "" || weight === "") {

        // fires an alert if the user has not supplied both height and weight
        alert("Please fill out your height and weight!");
        return;
    } else {
        // does the actual calculation and assigns the 'bmi' variable declared earlier
        bmi = Math.round(weight/(height * 2));

        // inserts the bmi value into the bmiDisplay paragraph tag
        bmiDisplay.textContent = "Your BMI: " + bmi;

        // calls the method which will go into greater detail about the user's bmi result
        // passes bmi as a variable, as this is used in the result() method
        result(bmi);
    }
};

// displays greater detail about the user's calculated bmi value
function result(bmi) {

    // grabs the elements 'resultRow', the hidden <tr> tag containing the detailed results paragraph
    let tr = document.getElementById("resultRow");
    // and the 'result' paragraph tag itself
    let result = document.getElementById("result");

    // resets the text contents and background colour of the 'result' tag for good measure
    result.textContent = "";
    result.style.backgroundColor = "none";

    // declaration of detailed text result variable
    let textResult;

    // sets an appropriate detailed message based on the user's calculated BMI
    // also sets a colour
    if (bmi < 16) {
        result.style.backgroundColor = "red";
        textResult = "You are severely underweight. Consult a physician immediately.";
    }
    else if (bmi >= 16 && bmi <= 18.5) {
        result.style.backgroundColor = "DeepSkyBlue";
        textResult = "You are underweight.";
    }
    else if (bmi > 18.5 && bmi <= 24) {
        result.style.backgroundColor = "Aquamarine";
        textResult = "Your weight is within the norm for your height.";
    }
    else if (bmi > 24 && bmi <= 30) {
        result.style.backgroundColor = "ForestGreen";
        textResult = "You are overweight.";
    }
    else if (bmi > 30 && bmi <= 35) {
        result.style.backgroundColor = "GoldenRod";
        textResult = "You are obese - first degree.";
    }
    else if (bmi > 35 && bmi <= 40) {
        result.style.backgroundColor = "OrangeRed";
        textResult = "You are obese - second degree.";
    }
    else if (bmi > 40) {
        result.style.backgroundColor = "red";
        textResult = "You are obese - third degree.";
    }

    // makes the table row tag containing this information visible
    tr.style.display = "block";

    // sets the text content of the 'result' paragraph = the appropriate message
    result.textContent = textResult;
};