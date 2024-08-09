# Tic Tac Toe Game

## Simple game using SwiftUI to train my logic in ios programming

## Using the MVVM method

Tic Tac Toe is a classic game played on a 3x3 board. In this implementation, we have two players: human and computer. Below is a brief explanation of how the game works and the basic algorithm used.

## Data Structure

- **Board Array:**
  - Type: `[Move?]`
  - Size: 9 (representing a 3x3 board)
  - Stores information about each move made (whether by human or computer).

- **Player Enum:**
  - Stores two player types: `Human` and `Computer`.

- **Move Struct:**
  - Stores information about a move made:
    - `player`: The player making the move (Human or Computer)
    - `boardIndex`: The index on the board where the move is made
    - `indicator`: The indicator for the move (e.g., 'X' or 'O')

## Simple Algorithm

1. **Check the Board:**
   - Start by checking if the board is fully occupied. If it is, disable the tap gesture by returning.

2. **Human Turn:**
   - The human makes the first move. Use the tap gesture provided by Apple to fill the board array.

3. **Delay for Computer:**
   - Give a 0.5-second delay for the computer to make its choice.

4. **Computer Turn:**
   - The computer will look for an empty index on the board at random.
   - Use a loop to find an empty space.
   - When an empty space is found, the computer will fill it.

5. **Repeat:**
   - Repeat steps 1 to 4 continuously until the entire board is filled.


![Simulator Screenshot - iPhone 15 Pro - 2024-08-09 at 07 34 16](https://github.com/user-attachments/assets/01c0e9b5-8c13-4586-8413-a3f3fda21e00)
![Simulator Screenshot - iPhone 15 Pro - 2024-08-09 at 07 35 21](https://github.com/user-attachments/assets/011fa04d-c50c-4246-bbbb-19de96077710)
