//
//  ContentView.swift
//  Memorize
//
//  Created by sunny on 2023/9/3.
//

import SwiftUI

struct ContentView: View {
    let emojis = ["👻", "💩", "🤡", "🎃", "👻", "💩", "🤡", "🎃"]
    @State var cardCount = 4
    var body: some View {
        VStack() {
            ScrollView{
                cards
            }
            Spacer()
            cardOprator
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 120))]) {
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.orange)
    }
    
    var cardOprator: some View {
        HStack {
            addCard
            Spacer()
            removeCard
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    func cardAjust(by offset: Int, symbol: String) -> some View {
        Button(action: {
            cardCount += offset
        }, label: {
            Image(systemName: symbol)
        })
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)
    }
    
    var addCard: some View {
        cardAjust(by: 1, symbol: "rectangle.stack.badge.plus.fill")
    }
    
    var removeCard: some View {
        cardAjust(by: -1, symbol: "rectangle.stack.badge.minus.fill")
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack() {
            let base = RoundedRectangle(cornerRadius: 12)
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
        .font(.largeTitle)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
