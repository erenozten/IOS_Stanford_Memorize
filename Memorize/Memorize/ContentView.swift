//
//  ContentView.swift
//  Memorize
//
//  Created by Eren Özten on 30.01.2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(content: {
            Text("🍟").font(.largeTitle)
        })
        .foregroundColor(.orange)
        .imageScale(.small)
        .padding()
    }
}

#Preview {
    ContentView()
}

