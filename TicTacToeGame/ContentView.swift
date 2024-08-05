//
//  ContentView.swift
//  TicTacToeGame
//
//  Created by Pratama One on 05/08/24.
//

import SwiftUI

let columns: [GridItem] = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
]

struct ContentView: View {
    var body: some View {
        LazyVGrid(columns: columns, content: {
            Text("Placeholder")
            Text("Placeholder")
            Text("Placeholder")
            Text("Placeholder")
            Text("Placeholder")
            Text("Placeholder")
            Text("Placeholder")
            Text("Placeholder")
            Text("Placeholder")
        })
    }
}

#Preview {
    ContentView()
}
