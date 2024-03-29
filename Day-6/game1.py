"""
THE GAME: Rock, Paper and Scissor
Mechanics: A total of ten rounds will takeplace where the scores will be accumulated. 
The winner will be announced right after the 10th round
"""

from random import randint
from time import sleep # the sleep function is used to pause the execution in a given time

options = ['r', 'p', 's'] 
options_dict =  {'r':'rock', 'p':'paper', 's':'scissor'} #curly braces if dictionary
#creating a class
class Player:

    def __init__(self, name): #score is not included because you already know what it is, unlike the player name
        self.name =name
        self.score =0 #the starting score is zero
    
    # def throw_hand(self, option): #creating a new function for rock, paper, scissor option
    #     if option.lower()[0] not in ['r', 'p', 's']:
    #         print('''You entered an incorrect option. Please choose [R]ock, [P]aper, [S]cissor. ''')
    #     else:
    #         print('You chose ' + option)
    #         return

#function for the decision
#win, lose, or win
def decision(player_hand, bot_hand): 
    if player_hand == bot_hand:
        return 'tie'
    #defining winning scenarios
    #beware of the indention
    elif (player_hand == 'r' and bot_hand == 's') or \
        (player_hand == 'p' and bot_hand == 'r') or \
        (player_hand == 's' and bot_hand == 'p'):
        return '1 point for you'
    else:
        return 'Ngi, talo! Bawi next round'

#actual game
if __name__ == '__main__':
    print('Welcome to the best game ever made!')
    sleep(2) # pause for 2 seconds
    player_name = input('Enter your name: ')
    print('Welcome ' + player_name)
    #sleep()

    # game itself
    good = Player(player_name)
    bad = Player('Master BOT')

    for i in range(5):
        player_hand = input('Please choose [R]ock, [P]aper, [S]cissor: ')
        bot_hand = options[randint(0,2)] # 0,1,2 yung pipiliin in random, based ito sa index ng r,s,p

        #print('Player selected: ' + options_dict[good_hand])

        # making the desicion whoever wins
        
        player_hand = options_dict[player_hand.lower()[0]]
        bot_hand = options_dict[bot_hand.lower()[0]]
        status = decision(player_hand, bot_hand)

        print('You have selected: ' + player_hand)
        sleep(2)
        print('Master BOT selected: '+ (options_dict)[bot_hand])

        if status == 'You win':
            good.score +=1
        elif status == 'Ngi, talo!':
            bad +=1
    
    if good.score > bad.score:
        print('CONGRATULATION! You won the tournament, you defeated the master BOT')
    if good.score < bad.score:
        print('TOO BAD! You lost the tournament:>')
    else:
        print('No one won the tournament.')

    print('The game has ended')

# # total of ten rounds
# for i in range(10):
#     print(randint(1,3))
 
#  # continue tomorrow
