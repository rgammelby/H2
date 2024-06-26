document.addEventListener("DOMContentLoaded", () => {

    // necessary field declaration
    const originField = document.getElementById('origin');  // from
    const destinationField = document.getElementById('destination');  // to
    const suggestionsContainer = document.getElementById('suggestions');  // stop suggestions
    const dateField = document.getElementById('date');  // date field
    dateField.valueAsDate = new Date();  // sets date field = current date
    setTime();  // set time of time field = current time

    var icons = {
        "TB":["fa-bus"],
        "BUS":["fa-bus"],
        "WALK":["fa-blind"],
        "REG":["fa-train"],
        "LYN":["fa-train"]
    };

    // origin/destination variable declaration; out of scope to support getJourney function.
    // contain JSON objects of the chosen origin and destination
    let origin;
    let destination;

    // when the name of a stop is typed in (>3 characters) gets a list of stop objects
    originField.addEventListener('input', async () => {
        const query = originField.value;

        if (query.length < 3) {
            suggestionsContainer.innerHTML = '';
            return;
        }

        const suggestions = await getData(query);

        // displays suggestions based on return fom getData()
        displaySuggestions(suggestions.LocationList.StopLocation, originField);
    });

    // -//- but for destination rather than origin
    destinationField.addEventListener('input', async () => {
        const query = destinationField.value;

        if (query.length < 3) {
            suggestionsContainer.innerHTML = '';
            return;
        }

        const suggestions = await getData(query);

        displaySuggestions(suggestions.LocationList.StopLocation, destinationField);
    });

    // is called with the returned list of objects from getData() as well as the field it applies to (origin/destination)
    function displaySuggestions(suggestions, field) {
        suggestionsContainer.innerHTML = '';

        // sets suggestionContainer div visible
        suggestionsContainer.style.display = 'block';

        // iterates through each object in returned list
        suggestions.forEach(suggestion => {
            // creates a div class="suggestion" for each suggestion with the name of the stop
            const suggestionDiv = document.createElement('div');
            suggestionDiv.classList.add('suggestion');
            suggestionDiv.textContent = suggestion.name;

            // when a stop is selected, set the relevant input field (origin/destination) to the name of the stop
            suggestionDiv.addEventListener('click', () => {
                console.log(suggestion.name);
                field.value = suggestion.name;
                if (field === originField) {
                    console.log("Origin: ", suggestion);

                    // sets origin variable = the chosen stop object
                    origin = suggestion;
                } else if (field === destinationField) {
                    console.log("Destination: ", suggestion);

                    // sets destination variable = the chosen stop object
                    destination = suggestion;
                }

                // empty and hide suggestionsContainer div after use 
                suggestionsContainer.innerHTML = '';
                suggestionsContainer.style.display = 'none';
            });

            // appends suggestionDivs to suggestionContainer div
            suggestionsContainer.appendChild(suggestionDiv);
        });
    }

    // define journey element
    let journey = document.getElementById("journey");


    // retrieves journey (3 trips) based on origin and destination, displays them
    journey.addEventListener('click', async () => {
        try {
            const data = await getJourney(origin, destination);
            displayTrips(data);
        } catch (error) {
            console.error("Error fetching journey:", error);
        }
    });

    // displays journey data as retrieved from getJourney
    function displayTrips(tripArray) {

        const tripContainer = document.getElementById('tripwrapper');
        tripContainer.innerHTML = '';

        tripArray.forEach((trip, tripIndex) => {
            console.log(`Trip ${tripIndex + 1}:`, trip);

            const originName = trip.Leg[0].Origin.name;
            const destinationName = trip.Leg[trip.Leg.length - 1].Destination.name; // Last leg for destination
            const arrivalTime = trip.Leg[trip.Leg.length - 1].Destination.time; // Arrival time of last leg

            // Create a div for each trip
            const tripDiv = document.createElement('div');
            tripDiv.classList.add('trip-item');
            tripDiv.innerHTML = `
                <h3>${originName} -> ${destinationName}, Ankomst: ${arrivalTime}</h3>
                <button class="toggle-legs-btn" data-trip-index="${tripIndex}">Vis rejsen</button>
                <div class="legs-container" style="display: none;"></div>
            `;
            tripContainer.appendChild(tripDiv);

            const toggleLegsBtn = tripDiv.querySelector('.toggle-legs-btn');
            toggleLegsBtn.addEventListener('click', () => {
                const legsContainer = tripDiv.querySelector('.legs-container');
                if (legsContainer.style.display === 'none') {
                    legsContainer.style.display = 'block';
                    toggleLegsBtn.textContent = 'Skjul rejsen';
                    displayLegs(legsContainer, trip.Leg); // Display legs for this trip
                } else {
                    legsContainer.style.display = 'none';
                    toggleLegsBtn.textContent = 'Vis rejsen';
                }
            });
        });
    }


    function displayLegs(container, legs) {
        container.innerHTML = ''
        legs.forEach((leg, legIndex) => {
            // Create a div for each leg
            const legDiv = document.createElement('div');
            legDiv.classList.add('leg-item');
            legDiv.innerHTML = `
                <p><strong>${legIndex + 1}. forbindelse: </strong></p>
                <p> ${leg.name}</p><i class="fa ${icons[leg.type]}"></i>
                <p>Fra: ${leg.Origin.name} til: ${leg.Destination.name}</p>
                <p></p>
                <p>Afgang: ${leg.Origin.time}</p>
                <p>Ankomst: ${leg.Destination.time}</p>
            `;
            container.appendChild(legDiv);
        });
    }
});



async function getData(location) {
    let baseUrl = "http://xmlopen.rejseplanen.dk/bin/rest.exe/";
    let argument = "location?input=";

    let apiUrl = baseUrl.concat(argument, location, '&format=json');

    let response = await fetch(apiUrl);
    let data = await response.json();

    console.log(data);
    return (data);
}

// retrieves a full journey object (3 trips) based on selected origin and destination stops
async function getJourney(origin, destination) {
    console.log("Origin in journey: ", origin);
    console.log("Destination in journey: ", destination);

    let baseUrl = "http://xmlopen.rejseplanen.dk/bin/rest.exe/";

    let journeyUrl = baseUrl.concat(
        "trip?originId=", origin.id,
        "&destCoordX=", destination.x,
        "&destCoordY=", destination.y,
        "&destCoordName=", destination.name.replace(/[()\\\/]/g, ""),
        "&date=", formatDate(document.getElementById('date').value),
        "&time=", document.getElementById('time').value,
        "&format=json"
    ).replace(/\s/g, '');

    console.log("JourneyUrl: ", journeyUrl);

    let response = await fetch(journeyUrl);
    let data = await response.json();

    if (typeof data.TripList.Trip !== 'undefined') {
        let tripArray = data.TripList.Trip;
        console.log("Returning trip data: ", tripArray);
        return tripArray;
    }

    console.log("Returning journey data: ", data);
    return (data);
}

function setTime() {
    const timeField = document.getElementById('time');

    const now = new Date();
    const hours = now.getHours().toString().padStart(2, '0');
    const minutes = now.getMinutes().toString().padStart(2, '0');

    const currentTime = `${hours}:${minutes}`;

    timeField.value = currentTime;
}

function formatDate(date) {
    let parts = date.split('-');
    let day = parts[2];
    let month = parts[1];
    let year = parts[0].substring(2); // Extract last two digits of the year

    let formattedDate = day + '.' + month + '.' + year;
    console.log(formattedDate)
    return formattedDate;
}