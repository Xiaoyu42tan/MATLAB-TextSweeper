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
    for i = 1:10
        minefield(randi([2 (numRows-1)]),randi([2 (numCols-1)])) = 9;
    end
elseif(difficulty == 2)
    for i = 1:50
        minefield(randi([2 (numRows-1)]),randi([2 (numCols-1)])) = 9;
    end
else
    for i = 1:100
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

%assigning borders to -2 to not interfere with firstTry mechanic
minefield(1,:) = -2;
minefield(:,1) = -2;
minefield(numRows,:) = -2;
minefield(:,numCols) = -2;

%print blank minefield
fprintf("   ")
fprintf("%d  ",1:9)
fprintf("%d ",10:numCols-2)
fprintf("\n")
for i = 2:numRows-1
    if(i<11)
        fprintf("%d  ",i-1)
    else
        fprintf("%d ",i-1)
    end
    for j = 2:numCols-1
        fprintf("*  ")
    end
    fprintf("\n")
end

%flagfield stores the coordinates that user wants to flag
flagField = [zeros(numRows,numCols)];

%adding a mechanic to make the game fairer for users on their first guess
firstTry = true;
firstTryOccured = false;

%game needs to continue until the game has ended. 
gameEnded = false;
while (gameEnded == false)

    %checking if user wants to flag
    flagCheck = string(input("Do you want to flag a coordinate? (enter 'y' for yes, enter anything else for no): ",'s'));
    if(flagCheck == 'y')
        %getting user input on flag coordinates
        flagX = input("Type the x-value of the coordinate you wish to flag: ")+1;
        xValidCheckFlag = (1<flagX) && (flagX<numCols);
        flagY = input("Type the y-value of the coordinate you wish to flag: ")+1;
        yValidCheckFlag = (1<flagY) && (flagY<numRows);
        if(xValidCheckFlag == true && yValidCheckFlag == true)
            negativeCheckFlag = (minefield(flagY,flagX) > -1);
        end
        %making sure the user inputs a coordinate that is inside the minefield
        %and is not already revealed
        while(xValidCheckFlag == false || yValidCheckFlag == false || negativeCheckFlag == false)
            fprintf("Not valid coordinate!\n")
            flagX = input("Type the x-value of the coordinate you wish to flag: ")+1;
            xValidCheckFlag = (1<flagX) && (flagX<numCols);
            flagY = input("Type the y-value of the coordinate you wish to flag: ")+1;
            yValidCheckFlag = (1<flagY) && (flagY<numRows);
            if(xValidCheckFlag == true && yValidCheckFlag == true)
                negativeCheckFlag = (minefield(flagY,flagX) > -1);
           end
        end
        flagField(flagY,flagX) = 1;
    end

    if(flagCheck ~= 'y')
        %getting user input on coordinates
        coordinateX = input("Type the x-value of the coordinate you wish to uncover: ")+1;
        xValidCheck = (1<coordinateX) && (coordinateX<numCols);
        coordinateY = input("Type the y-value of the coordinate you wish to uncover: ")+1;
        yValidCheck = (1<coordinateY) && (coordinateY<numRows);
        if(xValidCheck == true && yValidCheck == true)
            negativeCheck = (minefield(coordinateY,coordinateX) > -1);
        end
        %making sure the user inputs a coordinate that is inside the minefield
        %and has not already been inputted before
        while (xValidCheck == false || yValidCheck == false || negativeCheck == false)
            fprintf("Not valid coordinate!\n")
            coordinateX = input("Type the x-value of the coordinate you wish to uncover: ")+1;
            xValidCheck = (1<coordinateX) && (coordinateX<numCols);
            coordinateY = input("Type the y-value of the coordinate you wish to uncover: ")+1;
            yValidCheck = (1<coordinateY) && (coordinateY<numRows);
            if(xValidCheck == true && yValidCheck == true)
                negativeCheck = (minefield(coordinateY,coordinateX) > -1);
            end
        end
        
        %for all revealed coordinates, assign negative value
        if(minefield(coordinateY,coordinateX) >= 0)
            minefield(coordinateY,coordinateX) = -1-minefield(coordinateY,coordinateX);
        end
    
        %checking if first guess, or if the firstTry mechanic has not
        %happened yet
        if((firstTry == true || firstTryOccured == false) && minefield(coordinateY,coordinateX) ~= -1)
            %checking if any neighbouring tiles are blank and unrevealed,
            %if they are, reveal it
            if(minefield(coordinateY+1,coordinateX) == 0)
                minefield(coordinateY+1,coordinateX) = -1;
            elseif(minefield(coordinateY-1,coordinateX) == 0)
                minefield(coordinateY-1,coordinateX) = -1;
            elseif(minefield(coordinateY,coordinateX+1) == 0)
                minefield(coordinateY,coordinateX+1) = -1;
            elseif(minefield(coordinateY,coordinateX-1) == 0)
                minefield(coordinateY,coordinateX-1) = -1;
            elseif(minefield(coordinateY-1,coordinateX-1) == 0)
                minefield(coordinateY-1,coordinateX-1) = -1;
            elseif(minefield(coordinateY-1,coordinateX+1) == 0)
                minefield(coordinateY-1,coordinateX+1) = -1;
            elseif(minefield(coordinateY+1,coordinateX-1) == 0)
                minefield(coordinateY+1,coordinateX-1) = -1;
            elseif(minefield(coordinateY+1,coordinateX+1) == 0)
                minefield(coordinateY+1,coordinateX+1) = -1;
            end
        end
        firstTry = false;

        %while loop to reveal all blank tiles adjacent to selected tile
        updateCount = 1;
        while(updateCount > 0)
            updateCount = 0;
            for i = 2:numRows-1
                for j = 2:numCols-1
                    if(minefield(i,j) > -1 && (minefield(i+1,j) == -1 || minefield(i-1,j) == -1 || minefield(i,j+1) == -1 || minefield(i,j-1) == -1 || minefield(i+1,j+1) == -1 || minefield(i+1,j-1) == -1 || minefield(i-1,j+1) == -1 || minefield(i-1,j-1) == -1))
                        updateCount = updateCount + 1;
                        minefield(i,j) = reveal(minefield,i,j);
                        firstTryOccured = true;
                    end
                end
            end
        end
    end

    %print new state of minefield
    fprintf("   ")
    fprintf("%d  ",1:9)
    fprintf("%d ",10:numCols-2)
    fprintf("\n")
    for i = 2:numRows-1
        if(i<11)
            fprintf("%d  ",i-1)
        else
            fprintf("%d ",i-1)
        end

        for j = 2:numCols-1
            %only print flag ("X") if tile has not been revealed
            if(flagField(i,j) == 1 && minefield(i,j) > -1)
                fprintf(2,"X  ") %red text is not original code. REFERENCE: https://undocumentedmatlab.com/articles/changing-matlab-command-window-colors-part2
            else
                if(minefield(i,j) == -1)
                    fprintf(".  ")
                elseif(minefield(i,j) < -1)
                    fprintf("%d  ", (-minefield(i,j) - 1))
                elseif(11 > minefield(i,j) && minefield(i,j) > -1)
                        fprintf("*  ")
                end
            end
        end
        fprintf("\n")
    end

    %check if user has hit mine
    if(flagCheck ~= 'y' && minefield(coordinateY,coordinateX) == -10)
        gameEnded = true;
        endCondition = 0;
    end

    %check if user has won
    %win condition: all non-mine tiles have been revealed 
    winCheck = 0;
    for i = 2:numRows-1
        for j = 2:numCols-1
            if(minefield(i,j) > -1 && minefield(i,j) ~= 9)
                winCheck = winCheck + 1;
            end
        end
    end
    if(winCheck == 0)
        gameEnded = true;
        endCondition = 1;
    end
end

%Game end message
if(endCondition == 0)
    fprintf("You've hit a mine! GAME OVER\n")
else
    fprintf("You're still alive, good job!\n")
end
