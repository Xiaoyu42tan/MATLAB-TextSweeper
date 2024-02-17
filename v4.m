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
    numRows = 12;
    numCols = 12;
elseif(difficulty == 2)
    numRows = 22;
    numCols = 22;
else
    numRows = 22;
    numCols = 32;
end

%create empty minefield 
minefield = [zeros(numRows,numCols)];

%based on difficulty, generate mine. let 9 = mine. 
%note: randomiser could hit same number twice
if(difficulty == 1)
    for i = 1:15
        minefield(randi([2 (numRows-1)]),randi([2 (numCols-1)])) = 9;
    end
elseif(difficulty == 2)
    for i = 1:70
        minefield(randi([2 (numRows-1)]),randi([2 (numCols-1)])) = 9;
    end
else
    for i = 1:200
        minefield(randi([2 (numRows-1)]),randi([2 (numCols-1)])) = 9;
    end
end

%minefield with numbers and mines. 
%minecount is number of mines within 1 tile radius 
for i = 2:numRows-1
    for j = 2:numCols-1
        mineCount = 0;
        if(minefield(i+1,j+1) == 9)
            mineCount = mineCount +1;
        end
        if(minefield(i,j+1) == 9)
            mineCount = mineCount +1;
        end
        if(minefield(i-1,j+1) == 9)
            mineCount = mineCount +1;
        end
        if(minefield(i+1,j-1) == 9)
            mineCount = mineCount +1;
        end
        if(minefield(i+1,j) == 9)
            mineCount = mineCount +1;
        end
        if(minefield(i,j-1) == 9)
            mineCount = mineCount +1;
        end
        if(minefield(i-1,j) == 9)
            mineCount = mineCount +1;
        end
        if(minefield(i-1,j-1) == 9)
            mineCount = mineCount +1;
        end
        if(minefield(i,j) ~= 9)
            minefield(i,j) = mineCount;
        end
    end
end

%print blank minefield
for i = 2:numRows-1
    for j = 2:numCols-1
        fprintf("0 ")
    end
    fprintf("\n")
end

%game needs to continue until the game has ended. 
gameEnded = false;
while (gameEnded == false)
    %getting user input on coordinates
    coordinateX = input("Type the x-value of the coordinate you wish to uncover: ")+1;
    coordinateY = input("Type the y-value of the coordinate you wish to uncover: ")+1;
    %for all uncovered coordinates not adjacent to mine, assign -1
    %for all uncovered coordinates adjacent to mine, assign -(minecount+1)
    if(minefield(coordinateY,coordinateX) == 0)
        minefield(coordinateY,coordinateX) = -1;
    elseif(minefield(coordinateY,coordinateX) > 0)
        minefield(coordinateY,coordinateX) = -1 - minefield(coordinateY,coordinateX);
    end

    %print new state of minefield
    for i = 2:numRows-1
        for j = 2:numCols-1
            if(minefield(i,j) == -1)
                fprintf("  ")
            elseif(minefield(i,j) < -1)
                fprintf("%d ", (-minefield(i,j) - 1))
            else
                fprintf("0 ")
            end
        end
        fprintf("\n")
    end

    %check if user has hit mine
    if(minefield(coordinateY,coordinateX) == -10)
        gameEnded = true;
        endCondition = 0;
    end
end

%Game over message
if(endCondition == 0)
    fprintf("You've hit a mine! GAME OVER\n")
end
