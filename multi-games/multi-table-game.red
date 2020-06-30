Red [Title: "Multi Table Game"]

random/seed now/time

computer: #(total: 0)
player: #(total: 0)

table: ask "Which table of multiplication (1 to 10)? "
either table = "" [table: random 10] [table: to integer! table if (table < 1) or (table > 10) [table: random 10]]

numbers: [1 2 3 4 5 6 7 8 9 10]

repeat i 10 [
        print newline
        print rejoin ["== " (11 - i) " =="]
        print newline

        left-number: random/only numbers
        right-number: table
        sum: left-number * right-number

        index: find numbers left-number
        remove index

        answer: ask rejoin [left-number " * " right-number " = "]
        if answer = "" [answer: "0"]

        print newline
        print sum
        print newline

        either (to integer! answer) = sum [player/total: player/total + sum] [
               computer/total: computer/total + sum]

        prin "Player: " print player/total
        prin "Computer: " print computer/total
]

print newline
either player/total > computer/total [print "You are the winner!"] [
        either player/total < computer/total [print "You lose!"] [
                print "It's a draw!"]
]
print newline
