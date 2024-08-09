//
//  ContentView.swift
//  TicTacToeGame
//
//  Created by Pratama One on 05/08/24.
//

import SwiftUI

struct ContentView: View {
    
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isGameBoardDisabled: Bool = false
    @State private var gameStatus: String = "Hello, you first"
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Text("Tic Tac Toe")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                Text(gameStatus)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Rectangle()
                                .foregroundStyle(Color.blue.opacity(0.8))
                                .frame(width: geometry.size.width / 3 - 6, height: geometry.size.height / 6 - 6)
                                .cornerRadius(20)
                            
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .bold()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color.white)
                        }
                        .onTapGesture {
                            handleTap(at: i)
                        }
                    }
                }
                .disabled(isGameBoardDisabled)
                
                Spacer()
                
                Button {
                    resetGame()
                    print("Masih bisa di tekan")
                } label: {
                    Text("RESET GAME")
                        .font(.title3)
                        .bold()
                        .padding(.horizontal, 20)
                        .padding(.vertical, 10)
                        .background(Color.blue)
                        .foregroundStyle(Color.white)
                }
                .cornerRadius(20)
                
                Spacer()
            }
        }
        .padding(20)
        .background(Color.black)
    }
    
    func handleTap(at index: Int) {
        guard !isSquareOccupied(in: moves, forIndex: index) else { return }
        moves[index] = Move(player: .human, boardIndex: index)
        gameStatus = "Computer's Turn"
        isGameBoardDisabled = true
        
        // Check for win or draw
        if checkWinCondition(for: .human, in: moves) {
            gameStatus = "You Win"
            isGameBoardDisabled = true
            return
        }
        
        if checkForDrawCondition(for: .human, in: moves) {
            gameStatus = "Draw"
            isGameBoardDisabled = true
            return
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            let computerPosition = determinanComputerMovePosition(in: moves)
            moves[computerPosition] = Move(player: .computer, boardIndex: computerPosition)
            isGameBoardDisabled = false
            gameStatus = "Your Turn"
            
            if checkWinCondition(for: .computer, in: moves) {
                gameStatus = "Computer win"
                isGameBoardDisabled = true
                return
            }
            
            if checkForDrawCondition(for: .human, in: moves) {
                gameStatus = "Draw"
                isGameBoardDisabled = true
                return
            }
        }
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determinanComputerMovePosition(in movex: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
    
    func checkWinCondition(for player: Player, in moves: [Move?]) -> Bool {
        let winPattern: Set<Set<Int>> = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
        ]
        
        let playerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPosition = Set(playerMoves.map { $0.boardIndex })
        
        for pattern in winPattern where pattern.isSubset(of: playerPosition) { return true }
        
        return false
    }
    
    func checkForDrawCondition(for player: Player, in moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
        gameStatus = "Hello, you first"
        isGameBoardDisabled = false
    }
    
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

#Preview {
    ContentView()
}
