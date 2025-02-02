//
//  ContentView.swift
//  Memorize
//
//  Created by Eren Özten on 30.01.2025.
//

import SwiftUI

struct ContentView: View {
    
    //@State var emojis: [String] = [""]
    @State var emojis = ["🍔", "🍟", "🍕","🌮", "🌯", "🥪","🍗", "🍿", "🌭","🥤"]

    @State var emojis_food = ["🍔", "🍟", "🍕","🌮", "🌯", "🥪","🍗", "🍿", "🌭","🥤"]
    @State var emojis_nature = ["🌿", "🌲", "🍃","🌻", "🌸", "🍄", "🏞", "🌊", "⛰","☀️"]
    @State var emojis_animal = ["🐶", "🐱", "🦁","🐼", "🐸", "🐧","🐘", "🦉", "🦋","🐢"]

    
    var ProjectName: some View{
        HStack{
        Text("Memorize")
            .font(.largeTitle)
        }
    }
    
    @State var cardCount: Int = 2

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
            if(cardCount <= emojis.count){
            ForEach(0..<cardCount, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
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
                ThemeSelector(selectedTheme: emojis_food, selectedThemeName: "fork.knife", selectedCardCount: 2)
                ThemeSelector(selectedTheme: emojis_nature, selectedThemeName: "tree.fill", selectedCardCount: 4)
                ThemeSelector(selectedTheme: emojis_animal, selectedThemeName: "hare.fill", selectedCardCount: 6)
            }
        }
        .imageScale(.large)
        .font(.largeTitle)
        .foregroundColor(.cyan)
    }
    
    func CardCountAdjuster(by offset: Int, symbol: String) -> some View{
        Button(action :{
                cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    
    func ThemeSelector(selectedTheme: Array<String>, selectedThemeName: String, selectedCardCount: Int) -> some View{
        Button(action :{
            emojis = selectedTheme
            cardCount = selectedCardCount
            print(emojis)
        }, label: {
            Image(systemName: selectedThemeName)
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
