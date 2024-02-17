%A simple text-based version of a grid game such as battleship or mine-sweeper.
clear;
clc;

%text to introduce player to game and obtain user input to select difficulty
difficulty = input("Hello! Welcome to Textsweeper, a text-based version of Minesweeper!\n\nAvailable Difficulties:\n1. 10x10 (beginner)\n2. 20x20 (intermediate)\n3. 30x20 (expert)\nPlease specify the difficulty you would like to play on by entering its corresponding number: ");

%checks if user entered valid difficulty
if(difficulty == 1 || difficulty == 2 || difficulty == 3)
    difficultyValid = true;
else
    difficultyValid = false;
end

%while user has not entered valid difficulty, prevents game from running until they have
while (difficultyValid == false)
    difficulty = input("That is not a valid difficulty! Please enter the difficulty: ");
    if(difficulty == 1 || difficulty == 2 || difficulty == 3)
        difficultyValid = true;
    end
end

%sets size of minefield based on difficulty
if(difficulty == 1)
    numRows = 10;
    numCols = 10;
elseif(difficulty == 2)
    numRows = 20;
    numCols = 20;
else
    numRows = 20;
    numCols = 30;
end

