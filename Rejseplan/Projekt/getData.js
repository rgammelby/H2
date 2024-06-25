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

        //console.log("Suggestions: ", suggestions)

        suggestionsContainer.style.display = 'block';

        suggestions.forEach(suggestion => {
            const suggestionDiv = document.createElement('div');
            suggestionDiv.classList.add('suggestion');
            suggestionDiv.textContent = suggestion.name;
            suggestionDiv.addEventListener('click', () => {
                field.value = suggestion.name;
                if (field === originField) {
                    console.log("Origin: ", suggestion);
                    origin = suggestion;
                } else if (field === destinationField) {
                    console.log("Destination: ", suggestion);
                    destination = suggestion;
                }
                suggestionsContainer.innerHTML = '';
                suggestionsContainer.style.display = 'none';
            });
            suggestionsContainer.appendChild(suggestionDiv);
        });
    }

    let journey = document.getElementById("journey");
    let tripContainer = document.getElementById('tripwrapper');

    // journey.addEventListener('click', () => {
    //     console.log("Origin ex: ", origin);
    //     console.log("Destination ex: ", destination);
    //     displayTrip(getJourney(origin, destination));
    // })

    journey.addEventListener('click', async () => {
        console.log("Origin ex: ", origin);
        console.log("Destination ex: ", destination);
        
        try {
            const data = await getJourney(origin, destination);
            displayTrips(data);
        } catch (error) {
            console.error("Error fetching journey:", error);
            // Handle error here if needed
        }
    });

    
    // function displayTrip(tripArray) {
    //     console.log("Displaying trip data:");
    //     console.log("Received tripArray:", tripArray);
    
    //     const tripContainer = document.getElementById('tripwrapper');
    //     tripContainer.innerHTML = ''; // Clear previous content (if any)
    
    //     tripArray.forEach((trip, tripIndex) => {
    //         console.log(`Trip ${tripIndex + 1}:`, trip);
    
    //         trip.Leg.forEach((leg, legIndex) => {
    //             console.log(`Leg ${legIndex + 1} of Trip ${tripIndex + 1}:`, leg);
    
    //             // Access properties of Origin and Destination
    //             const originName = leg.Origin.name;
    //             const destinationName = leg.Destination.name;
    //             const departureTime = leg.Origin.time;
    //             const arrivalTime = leg.Destination.time;
    
    //             // Create a div for each leg
    //             const legDiv = document.createElement('div');
    //             legDiv.classList.add('leg-item'); // Optional: Add a class for styling
    
    //             // Populate the div with leg information
    //             legDiv.innerHTML = `
    //                 <h3>Leg ${legIndex + 1} of Trip ${tripIndex + 1}</h3>
    //                 <p>Origin: ${originName}</p>
    //                 <p>Destination: ${destinationName}</p>
    //                 <p>Departure Time: ${departureTime}</p>
    //                 <p>Arrival Time: ${arrivalTime}</p>
    //                 <!-- Add more details as needed -->
    //             `;
    
    //             // Append the leg div to the trip container
    //             tripContainer.appendChild(legDiv);
    //         });
    //     });
    // }
    
    function displayTrips(tripArray) {
        console.log("Displaying trip data:");
        console.log("Received tripArray:", tripArray);
    
        const tripContainer = document.getElementById('tripwrapper');
        tripContainer.innerHTML = ''; // Clear previous content (if any)
    
        tripArray.forEach((trip, tripIndex) => {
            console.log(`Trip ${tripIndex + 1}:`, trip);
    
            const originName = trip.Leg[0].Origin.name; // Assuming the first leg contains the origin info
            const destinationName = trip.Leg[trip.Leg.length - 1].Destination.name; // Last leg for destination
            const arrivalTime = trip.Leg[trip.Leg.length - 1].Destination.time; // Arrival time of last leg
    
            // Create a div for each trip
            const tripDiv = document.createElement('div');
            tripDiv.classList.add('trip-item'); // Optional: Add a class for styling
            tripDiv.innerHTML = `
                <h3>${originName} -> ${destinationName}, Arrival Time: ${arrivalTime}</h3>
                <button class="toggle-legs-btn" data-trip-index="${tripIndex}">Show Legs</button>
                <div class="legs-container" style="display: none;"></div>
            `;
    
            // Append tripDiv to tripContainer
            tripContainer.appendChild(tripDiv);
    
            // Add event listener to toggle legs visibility
            const toggleLegsBtn = tripDiv.querySelector('.toggle-legs-btn');
            toggleLegsBtn.addEventListener('click', () => {
                const legsContainer = tripDiv.querySelector('.legs-container');
                if (legsContainer.style.display === 'none') {
                    legsContainer.style.display = 'block';
                    toggleLegsBtn.textContent = 'Hide Legs';
                    displayLegs(legsContainer, trip.Leg); // Display legs for this trip
                } else {
                    legsContainer.style.display = 'none';
                    toggleLegsBtn.textContent = 'Show Legs';
                }
            });
        });
    }
    
    
    function displayLegs(container, legs) {
        container.innerHTML = ''; // Clear previous content (if any)
        legs.forEach((leg, legIndex) => {
            // Create a div for each leg
            const legDiv = document.createElement('div');
            legDiv.classList.add('leg-item'); // Optional: Add a class for styling
            legDiv.innerHTML = `
                <p><strong>Leg ${legIndex + 1}:</strong></p>
                <p>Origin: ${leg.Origin.name}</p>
                <p>Destination: ${leg.Destination.name}</p>
                <p>Departure Time: ${leg.Origin.time}</p>
                <p>Arrival Time: ${leg.Destination.time}</p>
            `;
            container.appendChild(legDiv);
        });
    }
    
    
    

    // if (/* origin and destination are not empty */ origin && destination) {
    //     console.log("Origin and destination ready. ")
    //     getJourney(origin, destination);
    // }
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

async function getJourney(origin, destination) {
    console.log("Origin in journey: ", origin);
    console.log("Destination in journey: ", destination);
    
    let baseUrl = "http://xmlopen.rejseplanen.dk/bin/rest.exe/";

    let journeyUrl = baseUrl.concat(
        "trip?originId=", origin.id, 
        "&destCoordX=", destination.x,
        "&destCoordY=", destination.y, 
        "&destCoordName=", destination.name.replace( /[()\\\/]/g, "" ), "&format=json"
    ).replace(/\s/g, '');

    // let journeyUrl = "https://xmlopen.rejseplanen.dk/bin/rest.exe/trip?originId=821200902&destCoordX=9858829&destCoordY=57114511&destCoordName=VadumKirkevejEllehammervejVadum&format=json";

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