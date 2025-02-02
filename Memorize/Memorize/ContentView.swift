//
//  ContentView.swift
//  Memorize
//
//  Created by Eren Özten on 30.01.2025.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = ["🍔", "🍟", "🍕",
                  "🌮", "🌯", "🥪",
                  "🍗", "🍿", "🌭",
                  "🥤"]
    
    @State var cardCount: Int = 6

    var body: some View {
        VStack{
            Cards
            Spacer()
            CardCountAdjusters
        }
        .padding()
    }
        
    var Cards: some View{
        LazyVGrid(columns: [GridItem(),GridItem(),GridItem()]) {
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
            }
        }
        .foregroundColor(.orange)
    }
    
    
    var CardCountAdjusters: some View{
        HStack{
            CardAdder
            Spacer()
            CardRemover
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    
    func CardCountAdjuster(by offset: Int, symbol: String) -> some View{
        Button(action :{
                cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var CardAdder: some View{
        return CardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var CardRemover: some View{
        return CardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.plus.fill")
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
                base.strokeBorder(lineWidth:5) // Sadece çerçeve çizer. Background color vesaire hiçbir şey yok. (background color için bu rectangle'ın hemen arkasına bi rectangle ekleyeceğiz --> RoundedRectangle şekline bir arka plan rengi verebilirsiniz. Ancak, doğrudan .strokeBorder() kullanırken arka plan rengi ekleyemezsiniz, çünkü .strokeBorder() sadece kenarlık çizer. Bunun yerine .background() veya .fill() kullanarak bir arka plan rengi ekleyebilirsiniz.
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
