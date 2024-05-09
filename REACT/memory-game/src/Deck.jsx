// importing memory game card component
import React, { useState, useEffect } from 'react';
import Card from './Card';

// sets every card to their relevant, relative path
  const cards = [
    { id: 1, name: "Bashir", image: "./src/assets/bashir.png" },
    { id: 2, name: "Bashir2", image: "./src/assets/bashir.png" },
    { id: 3, name: "Barclay", image: "./src/assets/barclay.png" },
    { id: 4, name: "Barclay2", image: "./src/assets/barclay.png" },
    { id: 5, name: "Bones", image: "./src/assets/bones.png" },
    { id: 6, name: "Bones2", image: "./src/assets/bones.png" },
    { id: 7, name: "Data", image: "./src/assets/data.png" },
    { id: 8, name: "Data2", image: "./src/assets/data.png" },
    { id: 9, name: "Garak", image: "./src/assets/garak.png" },
    { id: 10, name: "Garak2", image: "./src/assets/garak.png" },
    { id: 11, name: "Janeway", image: "./src/assets/janeway.png" },
    { id: 12, name: "Janeway2", image: "./src/assets/janeway.png" },
    { id: 13, name: "Kira", image: "./src/assets/kira.png" },
    { id: 14, name: "Kira2", image: "./src/assets/kira.png" },
    { id: 15, name: "Q", image: "./src/assets/q.png" },
    { id: 16, name: "Q2", image: "./src/assets/q.png" },
    { id: 17, name: "Riker", image: "./src/assets/riker.png" },
    { id: 18, name: "Riker2", image: "./src/assets/riker.png" },
    { id: 19, name: "Seven", image: "./src/assets/seven.png" },
    { id: 20, name: "Seven2", image: "./src/assets/seven.png" },
    { id: 21, name: "Shran", image: "./src/assets/shran.png" },
    { id: 22, name: "Shran2", image: "./src/assets/shran.png" },
    { id: 23, name: "Torres", image: "./src/assets/torres.png" },
    { id: 24, name: "Torres2", image: "./src/assets/torres.png" }
  ];
  
  // shuffle memory game card array
  const shuffleArray = (array) => {
    for (let i = array.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [array[i], array[j]] = [array[j], array[i]];
    }
    return array;
  };
  
  // deck
  const Deck = () => {
    // establish relevant states for cards; flipped, matched and shuffled
    const [flippedCards, setFlippedCards] = useState([]);
    const [matchedCards, setMatchedCards] = useState([]);
    const [shuffledCards, setShuffledCards] = useState([]);
  
    // execute shuffle
    useEffect(() => {
      setShuffledCards(shuffleArray(cards));
    }, []);

    // keep restart button disabled until all identical pairs have been found
    useEffect(() => {
        if (matchedCards.length === cards.length) {
            restart.disabled = false;
        }
    }, [matchedCards])
  
    const handleCardClick = (clickedCard) => {
        // if two cards are already flipped, or if the same card is clicked twice, or if the clicked card is already matched, do nothing
        if (
          flippedCards.length === 2 ||
          (flippedCards.length === 1 && flippedCards[0].id === clickedCard.id) ||
          matchedCards.some((card) => card.id === clickedCard.id)
        ) {
          return;
        }
      
        // flips the clicked card
        const newFlippedCards = [...flippedCards, clickedCard];
        setFlippedCards(newFlippedCards);
      
        // if the second card is clicked
        if (flippedCards.length === 1) {
          // if the cards match, mark them as matched
          if (
            (flippedCards[0].name === clickedCard.name ||
              (flippedCards[0].name === clickedCard.name.slice(0, -1) &&
                clickedCard.name.slice(-1) === "2") ||
              (flippedCards[0].name.slice(0, -1) === clickedCard.name &&
                flippedCards[0].name.slice(-1) === "2"))
          ) {
            setTimeout(() => {
              setMatchedCards([...matchedCards, flippedCards[0], clickedCard]);
              setFlippedCards([]);
            }, 500);
          } else {
            // if the cards don't match, flip them back after a short delay
            setTimeout(() => {
              setFlippedCards([]);
            }, 1000);
          }
        }
      };     
      
    // set classes for memory game card grid arrangement
    return (
      <div className="deck">
        <div className="card-grid">
          {shuffledCards.map((card) => (
            <Card
              key={card.id}
              card={card}
              onClick={handleCardClick}
              isFlipped={flippedCards.some((c) => c.id === card.id)}
              isMatched={matchedCards.some((c) => c.id === card.id)}
            />
          ))}
        </div>
      </div>
    );
  };
  
  export default Deck;