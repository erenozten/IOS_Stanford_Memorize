//
//  ContentView.swift
//  Memorize
//
//  Created by Eren Özten on 30.01.2025.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = ["🍔", "🍟", "🍕",
                  "🌮", "🌯", "🥪", "🍗", "🍿", "🌭",
                  "🥤"]
    
    @State var cardCount: Int = 4

    var body: some View {
        VStack{
            HStack {
                ForEach(0..<cardCount, id: \.self){ index in
                    CardView(content: emojis[index])
                }
            }
            .foregroundColor(.orange)
            .padding()

            HStack{
                Button("Add Card"){
                    cardCount += 1
                }
                Spacer()
                Button("Remove Card"){
                    cardCount -= 1
                }
            }
            .padding()
        }

    }
    
}

struct CardView: View{
    
    let content: String
    @State var isFaceUp: Bool = true
    

    var body: some View{
        ZStack(content: {
            
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.fill(Color.white)
                base.strokeBorder(lineWidth:10) // Sadece çerçeve çizer. Background color vesaire hiçbir şey yok. (background color için bu rectangle'ın hemen arkasına bi rectangle ekleyeceğiz --> RoundedRectangle şekline bir arka plan rengi verebilirsiniz. Ancak, doğrudan .strokeBorder() kullanırken arka plan rengi ekleyemezsiniz, çünkü .strokeBorder() sadece kenarlık çizer. Bunun yerine .background() veya .fill() kullanarak bir arka plan rengi ekleyebilirsiniz.
                Text(content).font(.largeTitle)
            }
            else{
                base
            }
        })
        .onTapGesture {
            // onTapGesture bir view Modifier'dır. gördüğün gibi ZStack'ı modifiye ediyor! buna dikkat et..
            isFaceUp.toggle()
            print(isFaceUp)
            
        }
    }
}






#Preview {
    ContentView()
}
