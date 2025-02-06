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
    
    var body: some View {
            ScrollView{
                Cards
            }
        .padding()
    }
        
    var Cards: some View{
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
            ForEach(emojis.indices, id: \.self){ index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
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
                base.strokeBorder(lineWidth:2) // Sadece çerçeve çizer. Background color vesaire hiçbir şey yok. (background color için bu rectangle'ın hemen arkasına bi rectangle ekleyeceğiz --> RoundedRectangle şekline bir arka plan rengi verebilirsiniz. Ancak, doğrudan .strokeBorder() kullanırken arka plan rengi ekleyemezsiniz, çünkü .strokeBorder() sadece kenarlık çizer. Bunun yerine .background() veya .fill() kullanarak bir arka plan rengi ekleyebilirsiniz.
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
