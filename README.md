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
    
- **Winning condition rules in 3x3 matrix form:**
  - [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]

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
   
## To make AI smarter

### Make the AI ​​smarter but that doesn't mean it can't be beaten

- If AI has a chance of winning, then win
- If the AI ​​has no chance of winning, then block the enemy
- If AI can't block, then take the middle box
- If Ai can't take the middle box, then take a random box

## Preview on IPhone 15 Pro

<img src="https://github.com/user-attachments/assets/01c0e9b5-8c13-4586-8413-a3f3fda21e00" alt="Simulator Screenshot 1" width="200"/>
<img src="https://github.com/user-attachments/assets/011fa04d-c50c-4246-bbbb-19de96077710" alt="Simulator Screenshot 2" width="200"/>
<img src="https://github.com/user-attachments/assets/2c067007-e255-49cd-a2b3-95abc01f6184" alt="Simulator Screenshot - iPhone 15 Pro - 2024-08-10 at 10 03 45" width="200"/>
<img src="https://github.com/user-attachments/assets/c1fbe469-7099-4463-ac62-0d7a1a6e5b65" alt="Simulator Screenshot - iPhone 15 Pro - 2024-08-10 at 10 12 46" width="200"/>


