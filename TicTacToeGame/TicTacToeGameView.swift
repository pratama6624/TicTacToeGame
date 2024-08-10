//
//  ContentView.swift
//  TicTacToeGame
//
//  Created by Pratama One on 05/08/24.
//

import SwiftUI

struct TicTacToeGameView: View {
    
    @StateObject private var ticTacToeViewModel = TicTacToeGameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                Text("Tic Tac Toe")
                    .font(.title)
                    .bold()
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                Text(ticTacToeViewModel.gameStatus)
                    .font(.title3)
                    .bold()
                    .foregroundStyle(Color.white)
                
                Spacer()
                
                LazyVGrid(columns: ticTacToeViewModel.columns) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameRectangleView(proxy: geometry)
                            PlayerIndicator(systemImageName: ticTacToeViewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            ticTacToeViewModel.handleTap(at: i)
                        }
                    }
                }
                .disabled(ticTacToeViewModel.isGameBoardDisabled)
                
                Spacer()
                
                Button {
                    ticTacToeViewModel.resetGame()
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
    TicTacToeGameView()
}

struct GameRectangleView: View {
    var proxy: GeometryProxy
    var body: some View {
        Rectangle()
            .foregroundStyle(Color.blue.opacity(0.8))
            .frame(width: proxy.size.width / 3 - 6, height: proxy.size.height / 6 - 6)
            .cornerRadius(20)
    }
}

struct PlayerIndicator: View {
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .bold()
            .frame(width: 40, height: 40)
            .foregroundStyle(Color.white)
    }
}
