function [revealedValue] = reveal(minefield, i, j)
revealedValue = -(minefield(i,j) + 1);
end