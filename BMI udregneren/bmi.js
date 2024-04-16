function bmiCalc() {
    let height, weight, bmi, bmiDisplay;

    height = document.getElementById("height").value / 100;
    weight = document.getElementById("weight").value;
    bmiDisplay = document.getElementById("bmiDisplay");

    if (height === "" || weight === "") {
        alert("Please fill out your height and weight!");
        return;
    } else {
        bmi = Math.round(weight/(height * 2));
        bmiDisplay.textContent = "Your BMI: " + bmi;

        result(bmi);
    }
};

function result(bmi) {
    let tr = document.getElementById("resultRow");
    let result = document.getElementById("result");

console.log("BMI = " + bmi);

    result.textContent = "";
    result.style.backgroundColor = "none";

    let textResult;

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

    tr.style.display = "block";
    result.textContent = textResult;
};