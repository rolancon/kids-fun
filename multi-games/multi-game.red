Red [Title: "Multi Game"]

random/seed now/time

computer: #(total: 0)
player: #(total: 0)

rounds: ask "How many rounds? [10] "
either rounds = "" [rounds: 10] [rounds: to integer! rounds]

repeat i rounds [
        print newline
        print rejoin ["== " (rounds + 1 - i) " =="]
        print newline

        left-number: (random 9) + 1
        right-number: (random 9) + 1
        sum: left-number * right-number

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
