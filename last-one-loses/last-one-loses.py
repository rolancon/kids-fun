#-*-coding: utf-8-*-

from random import randint
from tkinter import *
from tkinter import messagebox

class GamePlay:
    def __init__(self, master):
        """GamePlay initialization constructor"""
        self.players = ['Player 1', 'Player 2', 'Player', 'Computer', 'Computer 1', 'Computer 2']
        # select the first player
        self.current_player = self.players[0]

        self.player_pairs = [(self.players[0], self.players[1]), (self.players[2], self.players[3]), (self.players[3], self.players[2]), (self.players[4], self.players[5])]
        self.current_player_pair = IntVar()
        # select the first player pair
        self.current_player_pair.set(1)

        self.status = 'Game In Progress'

        self.items = []
        self.item_count = 20 # constant in this game
        self.selected_item_count = 0

    def change_current_player(self):
        """triggered by changing a player pair"""
        player_pair = self.player_pairs[self.current_player_pair.get()-1]
        self.current_player = player_pair[0]
        self.handle_computer_turn()

    def take_turn(self):
        """commit the selected items"""
        if self.selected_item_count >= 1:
            for item in self.items:
                if item.config()['relief'][4] == FLAT:
                    item.config(text='')
            self.selected_item_count = 0
            if not self.check_for_loss():
                self.switch_to_opponent()

    def number_of_remaining_items(self):
        """how many remaining items on the board"""
        count = self.item_count
        for item in self.items:
            if item.config()['text'][4] == '':
                count -= 1
        return count

    def switch_to_opponent(self):
        """let the other player in the pair play"""
        player_pair = self.player_pairs[self.current_player_pair.get()-1]
        if player_pair[0] == self.current_player:
            self.current_player = player_pair[1]
        else:
            self.current_player = player_pair[0]
        self.handle_computer_turn()

    def handle_computer_turn(self):
        """the computer plays automatically"""
        if self.current_player.startswith('Computer'):
            self.compute_best_move()

    def compute_best_move(self):
        """computes the best move (number of items between 1 and 3)"""
        def optimal_number_of_items(count):
            # compute the optimal number of items to select using this algorithm
            optimal_number = (count - 1) % 4
            return optimal_number

        def random_number_of_items():
            random_number = randint(1,3)
            return random_number

        count = self.number_of_remaining_items()
        optimal_number = optimal_number_of_items(count)
        if optimal_number != 0:
            number_of_items = optimal_number
        else:
            number_of_items = random_number_of_items()
        self.selected_item_count = number_of_items

        for i in range(number_of_items):
            for item in self.items:
                if item.config()['relief'][4] == RAISED:
                    item.config(relief=FLAT)
                    break
        self.status = 'Computer selects %d tiles' % number_of_items
        self.take_turn()

    def check_for_loss(self):
        """determine if all items have been taken (game over)"""
        if self.number_of_remaining_items() == 0:
            self.status = 'Game Over'
            return True
        else:
            return False

class GameBoard:
    def toggle(self, num):
        """pressed button's relief is reversed"""
        item = self.game_play.items[num]
        if  item.config()['text'][4] != '':
            if item.config()['relief'][4] == FLAT:
                item.config(relief=RAISED)
                self.game_play.selected_item_count -=1
            elif self.game_play.selected_item_count < 3:
                item.config(relief=FLAT)
                self.game_play.selected_item_count +=1

    def menus(self, master):
        """add the Game menus"""
        def exit():
            master.destroy()

        def callback():
            messagebox.showinfo(message='Last One Loses\nRoland C. Reumerman')

        # create a menu
        menu = Menu(master)

        filemenu = Menu(menu)
        menu.add_cascade(label='File', menu=filemenu)
        filemenu.add_command(label='Exit', command=exit)

        helpmenu = Menu(menu)
        menu.add_cascade(label='Help', menu=helpmenu)
        helpmenu.add_command(label='About...', command=callback)

        return menu

    def buttons(self, master):
        """add the Game buttons"""
        def refresh_current_player_and_status():
            self.current_player.set(self.game_play.current_player)
            self.status.set(self.game_play.status)
            if self.status.get() == 'Game Over':
                player_pair = self.game_play.player_pairs[self.game_play.current_player_pair.get()-1]
                winner = player_pair[0]
                messagebox.showinfo(message='Congratulations %s!\nYou are the Winner.' % winner)

        def change_current_player():
            self.game_play.change_current_player()
            refresh_current_player_and_status()

        # the player / computer radio buttons
        Radiobutton(master, text='Player 1 vs Player 2', command=lambda:change_current_player(), variable=self.game_play.current_player_pair, value=1, anchor=W)\
            .grid(row=0, column=0, columnspan=3)
        Radiobutton(master, text='Player vs Computer', command=lambda:change_current_player(), variable=self.game_play.current_player_pair, value=2, anchor=E)\
            .grid(row=0, column=3, columnspan=3)
        Radiobutton(master, text='Computer vs Player', command=lambda:change_current_player(), variable=self.game_play.current_player_pair, value=3, anchor=W)\
            .grid(row=1, column=0, columnspan=3)
        Radiobutton(master, text='Computer 1 vs Computer 2', command=lambda:change_current_player(), variable=self.game_play.current_player_pair, value=4, anchor=E)\
            .grid(row=1, column=3, columnspan=3)

        # generate the 20 objects in a 5x4 grid
        count = 0
        for row in range(4):
            for column in range(5):
                self.game_play.items.append(Button(master, text='@', width=3, command=lambda num=count:self.toggle(num)))
                self.game_play.items[count].grid(row=row+2, column=column)
                count += 1

        def take_turn():
            self.game_play.take_turn()
            refresh_current_player_and_status()

        # the Game action buttons + fillers
        Button(master, text='', relief=FLAT, width=10).grid(row=2, column=6, columnspan=2)
        Button(master, text='Take Turn', width=10, command=lambda:take_turn()).grid(row=3, column=6,columnspan=2)
        Button(master, text='', relief=FLAT, width=10).grid(row=4, column=6, columnspan=2)
        Button(master,text='Restart Game', width=10, command=lambda:reset_game(master)).grid(row=5, column=6,columnspan=2)

    def __init__(self, master, game_play):
        """GameBoard initialization constructor"""
        self.game_play = game_play
        self.current_player = StringVar()
        self.current_player.set(self.game_play.current_player)
        self.status = StringVar()
        self.status.set(self.game_play.status)

        master.title('Game')
        master.geometry()

        menu = self.menus(master)
        master.config(menu=menu)

        self.buttons(master)

        Label(master, text='Current Player: ', anchor=W).grid(row=6, column=0)
        Label(master, textvariable=self.current_player, anchor=W).grid(row=6, column=1)
        Label(master, text='Status: ', anchor=E).grid(row=6, column=4)
        Label(master, textvariable=self.status, anchor=E).grid(row=6, column=5)

def reset_game(root):
    """clear the Game play and board"""
    game_play = GamePlay(root) # game play instantiated
    game_board = GameBoard(root, game_play) # game board instantiated

if __name__ == '__main__':
    root = Tk()
    reset_game(root)
    root.mainloop()
