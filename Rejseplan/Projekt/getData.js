document.addEventListener("DOMContentLoaded", () => {
    
    const originField = document.getElementById('origin');
    const destinationField = document.getElementById('destination');
    const suggestionsContainer = document.getElementById('suggestions');

    let origin;
    let destination;

    originField.addEventListener('input', async () => {
        const query = originField.value;

        if (query.length < 3) {
            suggestionsContainer.innerHTML = '';
            return;
        }

        const suggestions = await getData(query);

        displaySuggestions(suggestions.LocationList.StopLocation, originField);
    });

    destinationField.addEventListener('input', async () => {
        const query = destinationField.value;

        if (query.length < 3) {
            suggestionsContainer.innerHTML = '';
            return;
        }

        const suggestions = await getData(query);

        displaySuggestions(suggestions.LocationList.StopLocation, destinationField);
    });

    function displaySuggestions(suggestions, field) {
        suggestionsContainer.innerHTML = '';

        console.log("Suggestions: ", suggestions)

        suggestions.forEach(suggestion => {
            const suggestionDiv = document.createElement('div');
            suggestionDiv.classList.add('suggestion');
            suggestionDiv.textContent = suggestion.name;
            suggestionDiv.addEventListener('click', () => {
                field.value = suggestion.name;
                if (field === originField) {
                    origin = suggestion;
                } else if (field === destinationField) {
                    destination = suggestion;
                }
                suggestionsContainer.innerHTML = '';
            });
            suggestionsContainer.appendChild(suggestionDiv);
        });
    }

    if (/* origin and destination are not empty */) {
        
    }
});



async function getData(location) {
    let baseUrl = "http://xmlopen.rejseplanen.dk/bin/rest.exe/";
    let argument = "location?input=";

    let apiUrl = baseUrl.concat(argument, location, '&format=json');

    let response = await fetch(apiUrl);
    let data = await response.json();

    /*
    fetch(apiUrl)
    .then (response => {
        return response.json();
    })
    .then (data => {
        //console.log(data);

        if (typeof data.LocationList.StopLocation !== 'undefined') {
            console.log(data.LocationList.StopLocation);
        } else if (typeof data.LocationList.CoordLocation !== 'undefined') {
            console.log(data.LocationList.CoordLocation);
        }
    });*/

    console.log(data);
    return (data);    
}

async function getJourney() {
}