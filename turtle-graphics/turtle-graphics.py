#-*-coding: utf-8-*-

import turtle as tu

t = tu.Turtle()
t.screen.bgcolor("aqua")
t.left(90)
t.speed(20)
t.color('red')
t.shape('turtle')
t.shapesize(3)
t.pensize(5)
t.pencolor("black")
t.screen.title("Turtle Graphics")

def turtle(command):
    words = command.split()
    cmd = words[0]
    if len(words) > 1:
        pos = int(words[1])
    if cmd in ['forward', 'fd']:
        t.forward(pos)
    elif cmd in ['backward', 'bk']:
        t.backward(pos)
    elif cmd in ['left', 'lt']:
        t.left(pos)
    elif cmd in ['right', 'rt']:
        t.right(pos)
    elif cmd in ['penup', 'pu']:
        t.penup()
    elif cmd in ['pendown', 'pd']:
        t.pendown()

commands = []

while True: 
    command = tu.textinput("Turtle", "Tell me what to do")
    if command:
        if command == 'load':
            file = open('turtle-graphics.game', 'r')
            for line in file:
                turtle(line)
            file.close()
        elif command == 'save':
            file = open('turtle-graphics.game', 'a')
            for command in commands:
                file.write(command + "\n")
            file.close()
            commands.clear()
        else:
            try:
                turtle(command)
                commands.append(command)
            except:
                pass
    else:
        break

t = tu.done()
