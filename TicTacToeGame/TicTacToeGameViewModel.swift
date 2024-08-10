//
//  TicTacToeViewModel.swift
//  TicTacToeGame
//
//  Created by Pratama One on 10/08/24.
//

import Foundation
import SwiftUI

final class TicTacToeGameViewModel: ObservableObject {
    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]
    
    @Published var moves: [Move?] = Array(repeating: nil, count: 9)
    @Published var isGameBoardDisabled: Bool = false
    @Published var gameStatus: String = "Hello, you first"
    
    func handleTap(at index: Int) {
        // Human move processing
        guard !isSquareOccupied(in: moves, forIndex: index) else { return }
        moves[index] = Move(player: .human, boardIndex: index)
        gameStatus = "Computer's Turn"
        isGameBoardDisabled = true
        
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
        
        // Computer move processing
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [self] in
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
    
    func determinanComputerMovePosition(in moves: [Move?]) -> Int {
        // If AI has a chance of winning, then win
        let winPattern: Set<Set<Int>> = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]
        ]
        
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPosition = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winPattern {
            let winPosition = pattern.subtracting(computerPosition)
            
            if winPosition.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                if isAvailable { return winPosition.first!}
            }
        }
        
        // If the AI ​​has no chance of winning, then block the enemy
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPosition = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winPattern {
            let winPosition = pattern.subtracting(humanPosition)
            
            if winPosition.count == 1 {
                let isAvailable = !isSquareOccupied(in: moves, forIndex: winPosition.first!)
                if isAvailable { return winPosition.first!}
            }
        }
        
        // If AI can't block, then take the middle box
        let middleBox = 4
        if !isSquareOccupied(in: moves, forIndex: middleBox) {
            return middleBox
        }
        
        // If Ai can't take the middle box, then take a random box
        
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
