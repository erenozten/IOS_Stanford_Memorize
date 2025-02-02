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
    
    let emojis_nature = ["🌿", "🌲", "🍃","🌻", "🌸", "🍄", "🏞", "🌊", "⛰","☀️"]
    let emojis_animals = ["🐶", "🐱", "🦁","🐼", "🐸", "🐧","🐘", "🦉", "🦋","🐢"]

    
    var ProjectName: some View{
        HStack{
        Text("Memorize")
            .font(.largeTitle)
        }
    }
    
    @State var cardCount: Int = 6

    var body: some View {
        VStack{
            ProjectName
            ScrollView{
                Cards
            }
            Spacer()
            CardCountAdjusters
            ThemeSelectors
        }
        .padding()
    }
        
    var Cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
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
    
    
    
    var ThemeSelectors: some View{
        HStack{
            Group{
                ThemeSelector(themeName: "hare")
                ThemeSelector(themeName: "leaf")
                ThemeSelector(themeName: "fork.knife")
            }
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
    
    
    func ThemeSelector(themeName: String) -> some View{
        Button(action :{
               
        }, label: {
            Image(systemName: themeName)
        })
    }
    
    
    var CardAdder: some View{
        return CardCountAdjuster(by: +1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var CardRemover: some View{
        return CardCountAdjuster(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
    
}

struct CardView: View{
    
    let content: String
    @State var isFaceUp: Bool = true
    

    var body: some View{
        ZStack(content: {
            
            let base = RoundedRectangle(cornerRadius: 12) // base'yi isFaceUp durumundan bağımsız olarak: her durumda oluşturuyoruz. Bunu (base'yi) isFaceUp durumuna göre aşağıda modifiye ediyoruz
            
            Group {
                base.fill(Color.white) // arkaplan rengi
                base.strokeBorder(lineWidth:5) // Sadece çerçeve çizer. Background color vesaire hiçbir şey yok. (background color için bu rectangle'ın hemen arkasına bi rectangle ekleyeceğiz --> RoundedRectangle şekline bir arka plan rengi verebilirsiniz. Ancak, doğrudan .strokeBorder() kullanırken arka plan rengi ekleyemezsiniz, çünkü .strokeBorder() sadece kenarlık çizer. Bunun yerine .background() veya .fill() kullanarak bir arka plan rengi ekleyebilirsiniz.
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0) // isFaceUp ise -> Group'takilerin tümünü göster! böylece kart görünür olmuş oluyor
            
            base.fill().opacity(isFaceUp ? 0 : 1) // isfaceup değilse: arkaplan gösterilir (turuncu şuan)
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
