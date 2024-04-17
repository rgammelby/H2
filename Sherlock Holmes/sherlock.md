`var balance =10500; `
`var cameraOn = true;`

`function steal(balance, amount){`
    `cameraOn = false;`
    `if(amount < balance){`
        `balance = balance - amount;`
    `}`
    `return amount;`
    `cameraOn= true;`
`}`

`var amount = steal(balance, 1250);`
`alert("Du er kriminel og du har lige stjålet " +amount +" og det må man ikke!!!!")`

# Forklaring

Watson forstår ikke, hvad der er galt med koden hér. Jeg forklarer:

Når man ser bort fra, at koden ikke er pænt skrevet, og ikke følger best practices ift. whitespace og semikolon, for eksempel, så vil koden egentlig køre. Den vil dog ikke leve op til intentionen.

I toppen af koden erklæres to variable; `balance` og `cameraOn`. Dette er fint.

# 'steal'-funktionen

Herefter defineres der en funktion; `steal` som tager de variable `balance` og `amount` som parametre.
Der er dog nogle problemer, med denne funktion. 

Pointen med funktionen er, at 'hæve' x antal penge (amount) fra totalet (balance), og sende den opdaterede balance tilbage.
I stedet returnerer funktionen `amount`, og ikke den opdaterede `balance` variabel.

Dvs. at `amount` variablen, som får sin værdi fra `steal` funktionen, altid vil have den anden værdi, funktionen kaldes med (hér 1250).

Udover det findes der endnu et problem med `balance`-variablen, som findes både som global og lokal variabel. Dvs. at variablen findes både udenfor og indenfor funktionens scope. I dette tilfælde er det altså kun den lokale `balance`-variabel som bliver ændret, som ved hvert metodekald vil få den globale `balance`-variabels værdi (hér 10500).

`cameraOn` variablen ville heller ikke blive sat til `true` igen, da `cameraOn = true;` ligger efter et `return`, og er utilgængeligt.
