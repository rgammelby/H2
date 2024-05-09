// importing usestate, button & deck components, app styling
import { useState } from 'react'
import Button from './Button.jsx'
import Deck from './Deck.jsx';
import './App.css'

function App() {
  const [count, setCount] = useState(0)

  // returns title, memory game card deck & restart button components
  return (
    <div className="App">
      <h1>Vendespil</h1>
      <Deck />
      <Button />
    </div>
  )
}

export default App
