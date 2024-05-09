import React from 'react';

// sets card component with relevant properties
const Card = ({ card, onClick, isFlipped, isMatched }) => {
  // gets name and image from list in deck component
  const { name, image } = card;

  // sets card class based on its current state
  const cardClass = `card ${isFlipped || isMatched ? "flipped" : ""}`;

  // actual card html element
  // card face and card back for each card
  return (
    <div className={cardClass} onClick={() => onClick(card)}>
      <div className="card-inner">
        <div className="card-front">
            <img src="./src/assets/enterprise.png"></img>
        </div>
        <div className="card-back">
          <img src={image} alt={name} />
        </div>
      </div>
    </div>
  );
};

export default Card;
