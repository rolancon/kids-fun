# Multi Games

This is a very simple multiplication game. I created it to help my son and my daughter practice the tables of multiplication in a game setting. When we do multiplication, we say _A_ **multi** _B_ instead _A_ **times** _B_. The same when we do division, then we say _A_ **divi** _B_ instead of _A_ **divided by** _B_.

The objective of the game is very simple: during a number of rounds of multi(plication)s try to give as many correct answers as possible. The number of rounds is asked for before the game starts (10 by default). For every correct answer the result is added to the player's total; for every incorrect answer the result is added to the computer's total. The correct answer and the current totals are shown after each round. If the `Enter` key has been pressed and no answer is given it is interpreted as `0`. At the end of the game a winner is declared: the one who has the highest total.

You can start this game by firing up the [*Red*](https://www.red-lang.org) interpreter with the following script:

`> red multi-game.red`

You can also play a variation of the game where the game will ask you for a multiplication table between 1 and 10, and then ask you all 10 multiplications in that number's table in random order. If the number is empty, smaller than 1 or bigger than 10, it will randomly pick a multiplication table for you.
You can start this game by firing up the [*Red*](https://www.red-lang.org) interpreter with the other script:

`> red multi-table-game.red`
