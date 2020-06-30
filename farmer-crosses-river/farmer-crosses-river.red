Red [Title: "Farmer Crosses River"]

init: does [
  game: make object! [turn: 0]

  boat: make object! [shore: 'south name: 'boat load: 0]

  possession: make object! [location: 'south-shore]

  wolf: make possession [name: 'wolf]

  goat: make possession [name: 'goat]

  cabbage: make possession [name: 'cabbage]
]

help: does [
  print {
Welcome to Farmer Crosses River!

The object of this game is for the farmer to safely bring his possessions, a wolf, a goat and a cabbage, across the river using his boat, from the south shore to the north shore.

Only one other possession fits in his boat with him at the same time. However, be aware that if the farmer takes his boat to the other shore and leaves the goat and the cabbage behind unguarded, the goat will eat the cabbage. And if he leaves the wolf and the goat behind unguarded, the wolf will eat the goat. Then you will have lost the game.

This game understands only four commands:

>> move wolf

>> move goat

>> move cabbage

>> row boat

If you move one of his possessions and it is on the shore, then it will move to the boat. And if it is in the boat then it will move to the shore. But only if the possession is on the same shore as the boat.

The farmer is always on the shore where his boat is. If you row the boat, it will move him to the other shore, carrying 0 or 1 of his possessions along.

If you need you see these instructions again, type:

>> help
  }
  show-game
]

restart: does [
  confirm: ask "Would you like to restart the game? Type yes or no. "
  either confirm = "yes" [init help] [either confirm = "no" [print "You can stop the game if you type quit."] [print "I don't understand."]]
]

show-game: does [
  if wolf/location = 'north-shore [prin "  WOLF "]
  if goat/location = 'north-shore [prin "  GOAT "]
  if cabbage/location = 'north-shore [prin "  CABBAGE "]
  prin newline
  print "========================="
  if boat/shore = 'north [
    prin "         BOAT("
    if wolf/location = 'boat [prin "WOLF"]
    if goat/location = 'boat [prin "GOAT"]
    if cabbage/location = 'boat [prin "CABBAGE"]
    print ")"
  ]
  prin newline
  if boat/shore = 'south [
    prin "         BOAT("
    if wolf/location = 'boat [prin "WOLF"]
    if goat/location = 'boat [prin "GOAT"]
    if cabbage/location = 'boat [prin "CABBAGE"]
    print ")"
  ]
  print "========================="
  if wolf/location = 'south-shore [prin "  WOLF "]
  if goat/location = 'south-shore [prin "  GOAT "]
  if cabbage/location = 'south-shore [prin "  CABBAGE "]
  prin newline
]

move: function [item] [
  either in item 'location [
    either (item/location = 'boat) and (boat/shore = 'north) [item/location: 'north-shore boat/load: boat/load - 1
      game/turn: game/turn + 1] [
      either (item/location = 'boat) and (boat/shore = 'south) [item/location: 'south-shore boat/load: boat/load - 1
        game/turn: game/turn + 1] [
        either boat/load < 1 [
          either (item/location = 'north-shore) and (boat/shore = 'north) [item/location: 'boat boat/load: boat/load + 1
            game/turn: game/turn + 1] [
            if (item/location = 'south-shore) and (boat/shore = 'south) [item/location: 'boat boat/load: boat/load + 1
              game/turn: game/turn + 1]
          ]
        ] [prin newline print "The boat is already full."] 
      ]
    ]
    show-game
    check-state
  ] [prin newline prin "You can't move a " prin item/name prin ": you have to row it." prin newline]
]

row: function [obj] [
  either in obj 'shore [
    either obj/shore = 'north [obj/shore: 'south game/turn: game/turn + 1] [
      if obj/shore = 'south [obj/shore: 'north game/turn: game/turn + 1]
    ]
    show-game
    check-state
  ] [prin newline prin "You can't row a " prin obj/name prin ": you have to move it." prin newline]
]

check-state: does [
  either (wolf/location = 'north-shore) and (goat/location = 'north-shore) and (cabbage/location = 'north-shore) [
    print "Congratulations! You have safely moved the farmer's wolf, goat and cabbage across the river."
    prin "It has taken you " prin game/turn prin " turns." prin newline
    if game/turn = 17 [print "Congratulations again! That is the minimum number of turns it takes to solve this game." prin newline]
    restart
  ] [
    either ((boat/shore = 'south) and (goat/location = 'north-shore) and (cabbage/location = 'north-shore)) or
           ((boat/shore = 'north) and (goat/location = 'south-shore) and (cabbage/location = 'south-shore)) [
      prin newline
      print "O no, the goat and the cabbage have been left alone by the farmer, and now the goat has eaten the cabbage!"
      cabbage/location: 'dead
      show-game
      restart
    ] [either ((boat/shore = 'south) and (wolf/location = 'north-shore) and (goat/location = 'north-shore)) or
             ((boat/shore = 'north) and (wolf/location = 'south-shore) and (goat/location = 'south-shore)) [
        prin newline
        print "O no, the wolf and the goat have been left alone by the famer, and now the wolf has eaten the goat!"
        goat/location: 'dead
        show-game
        restart
      ] []
    ]
  ]
]

init
help

