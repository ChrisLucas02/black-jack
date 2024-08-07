//
//  ContentView.swift
//  BlackJack
//
//  Created by Chris Lucas on 02.12.21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = ViewModel()
    var body: some View {
        ZStack {
            gameView.opacity(viewModel.isGameOver ? 0.1 : 1)

            if viewModel.isGameOver {
                gameOver
            }
        }
    }

    var gameView: some View {
        VStack(alignment:.leading, spacing: 0) {
            Text("TP - BlackJack")
                .font(.system(size: 36))
                .fontWeight(.bold)
                .padding(.leading, 16)
            VStack {
                scores
                HStack {
                    ZStack {
                        if viewModel.userCards.count == 0 {
                            CardView(card: Card.hiddenCard)
                        } else {
                            ForEach(0..<viewModel.userCards.count, id:\.self)
                            { index in
                                CardView(card:viewModel.userCards[index])
                                    .offset(CGSize(width: 0, height: 30*CGFloat(index)))
                            }
                        }
                        
                    }
                    .frame(maxWidth: .infinity)

                    ZStack {
                        if viewModel.dealerCards.count == 0 {
                            CardView(card: Card.hiddenCard)
                        } else {
                            ForEach(0..<viewModel.dealerCards.count, id:\.self)
                            { index in
                                CardView(card:viewModel.dealerCards[index])
                                    .offset(CGSize(width: 0, height: 30*CGFloat(index)))
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                Spacer()
                commands
            }
        }
        
    }

    var gameOver: some View {
        VStack {
            Spacer()

            Text("\(viewModel.gameOverText)")
                .font(.largeTitle)
                .foregroundColor(Color.red)

            Spacer()

            Button(action: { self.viewModel.replay() }) {
                Text("Replay").font(.title)
            }
            .frame(height: 50).frame(maxWidth: .infinity)
            .padding()
        }
    }
    
    var scores: some View {
        HStack {
            VStack {
                Text("Your Score").foregroundColor(viewModel.isUserTurn ? Color.black : Color.gray)

                HStack {
                    // 1
                    ForEach(viewModel.userScores, id: \.self) { score in
                        Text("\(score)").font(.title).foregroundColor(viewModel.isUserTurn ? Color.black : Color.gray)
                    }
                }
            }
            .frame(maxWidth: .infinity)

            VStack {
                Text("Dealer Score").foregroundColor(viewModel.isUserTurn ? Color.gray : Color.black)

                HStack {
                    // 1
                    ForEach(viewModel.dealerScores, id: \.self) { score in
                        Text("\(score)").font(.title).foregroundColor(viewModel.isUserTurn ? Color.gray : Color.black)
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
    
    var commands: some View {
        HStack {
            Button(action: { self.viewModel.newCard() }) {
                Text("Card").font(.title)
            }
            .frame(height: 50).frame(maxWidth: .infinity)
            .disabled(viewModel.isGameOver)

            Button(action: {self.viewModel.stay()}) {
                Text("Stay").font(.title)
            }
            .frame(height: 50).frame(maxWidth: .infinity)
            .disabled(viewModel.isGameOver)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")
        }
    }
}
