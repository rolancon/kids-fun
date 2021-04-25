#!/usr/local/bin/io

num := Random value(1,100) round
guesses := 10
prev_diff := nil

"Guess a number between 1 and 100. You have at most 10 turns to the guess the number correctly." println
while(guesses>0,
  guess := File standardInput readLine("Guess: ")
  guess = guess asNumber

  if (guess==num,
    "Correct!" println
    break
  )

  diff := num - guess
  if (prev_diff != nil,
    if((diff) abs >= (prev_diff) abs,
      "Colder" println,
      "Hotter" println
    )
  )

  guesses = guesses - 1
  prev_diff = diff
)

if(guesses==0,
  "Game over!" println
)
