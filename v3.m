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

%create empty minefield 
minefield = [zeros(numRows,numCols)];

%based on difficulty, generate mine. let 0 = no mine and 1 = mine. 
%note: randomiser could hit same number twice
if(difficulty == 1)
    for i = 1:15
        minefield(randi([1 (numRows)]),randi([1 (numCols)])) = 1;
    end
elseif(difficulty == 2)
    for i = 1:70
        minefield(randi([1 (numRows)]),randi([1 (numCols)])) = 1;
    end
else
    for i = 1:200
        minefield(randi([1 (numRows)]),randi([1 (numCols)])) = 1;
    end
end

%print minefield with numbers and mines. editted size to not cause index errors. 
for i = 1:numRows
    for j = 1:numCols
        mineCount = 0;
        %if statements counts the number of mines surrounding a tile
        if(minefield(i+1,j+1) == 1)
            mineCount = mineCount +1;
        end
        if(minefield(i,j+1) == 1)
            mineCount = mineCount +1;
        end
        if(minefield(i-1,j+1) == 1)
            mineCount = mineCount +1;
        end
        if(minefield(i+1,j-1) == 1)
            mineCount = mineCount +1;
        end
        if(minefield(i+1,j) == 1)
            mineCount = mineCount +1;
        end
        if(minefield(i,j-1) == 1)
            mineCount = mineCount +1;
        end
        if(minefield(i-1,j) == 1)
            mineCount = mineCount +1;
        end
        if(minefield(i-1,j-1) == 1)
            mineCount = mineCount +1;
        end
        if(minefield(i,j) == 1)
            fprintf("x ")
        else
            fprintf("%d ", mineCount)
        end
    end
    fprintf("\n")
end
