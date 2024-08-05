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
    @State private var isHumanMove = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                LazyVGrid(columns: columns) {
                    ForEach(0..<9) { i in
                        ZStack {
                            Circle()
                                .foregroundStyle(Color.blue.opacity(0.8))
                                .frame(width: geometry.size.width / 3 - 6, height: geometry.size.height / 6 - 6)
                            
                            Image(systemName: moves[i]?.indicator ?? "")
                                .resizable()
                                .bold()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(Color.white)
                        }
                        .onTapGesture {
                            if isSquareOccupied(in: moves, forIndex: i) { return }
                            moves[i] = Move(player: isHumanMove ? .human : .computer, boardIndex: i)
                            isHumanMove.toggle()
                        }
                    }
                }
                
                Spacer()
            }
        }
        .padding(20)
    }
    
    func isSquareOccupied(in moves: [Move?], forIndex index: Int) -> Bool {
        return moves.contains(where: { $0?.boardIndex == index})
    }
    
    func determinanComputerMovePosition(in movex: [Move?]) -> Int {
        var movePosition = Int.random(in: 0..<9)
        
        while isSquareOccupied(in: moves, forIndex: movePosition) {
            var movePosition = Int.random(in: 0..<9)
        }
        
        return movePosition
    }
}

enum Player {
    case human, computer
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "cat.fill" : "hare.fill"
    }
}

#Preview {
    ContentView()
}
