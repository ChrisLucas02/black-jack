//
//  ViewModel.swift
//  BlackJack
//
//  Created by Chris Lucas on 02.12.21.
//

import UIKit
import SwiftUI

final class ViewModel : ObservableObject {
// Data displayed by ContentView
    @Published private(set) var userScores: [Int] = [0]
    @Published private(set) var dealerScores: [Int] = [0]
    @Published private(set) var currentCard = Card.hiddenCard
    @Published private(set) var gameOverText = ""
    @Published private(set) var isGameOver = false
    @Published private(set) var isUserTurn = true

    // Private variables used to manage a BlackJack game
    private var cards = CardUtils.generateCards()
    public var userCards = [Card]()
    public var dealerCards = [Card]()
    private let maxScore:Int = 21

    func newCard () {
        self.currentCard = self.cards[Int.random(in: 0..<self.cards.count)]
       
            if self.isUserTurn {
                self.userCards.append(self.currentCard)
                self.userScores = CardUtils.getScores(cards: self.userCards)
            } else {
                self.dealerCards.append(self.currentCard)
                self.dealerScores = CardUtils.getScores(cards: self.dealerCards)
            }
        self.endGame()
    }
    
    func stay () {
        isUserTurn = false
        let userScore:Int = determineUserBestScore()
        var dealerLen:Int = dealerScores.count-1
        var i:Int = dealerLen
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) {
            timer in
            if self.isGameOver {
                timer.invalidate()
            } else {
                dealerLen = self.dealerScores.count-1
                if (self.dealerScores[i] < 17) {
                    self.newCard()
                } else {
                    if (self.dealerScores[i] <= 21) {
                        self.isGameOver = true
                        if (self.dealerScores[i] <= userScore) {
                            self.gameOverText = "You win!"
                        } else {
                            self.gameOverText = "Game Over!"
                        }
                    }
                   i -= 1
                }
            }
        }
    }
    
    func replay () {
        isUserTurn = true
        isGameOver = false
        userScores = [0]
        dealerScores = [0]
        userCards = []
        dealerCards = []
    }
    
    func determineUserBestScore() -> Int {
        let userLen:Int = userScores.count-1
        var bestScore:Int = 0
        for i in (0...userLen).reversed() {
            if (userScores[i] > 21){
                continue
            } else {
                bestScore = userScores[i]
                break
            }
        }
        return bestScore
    }

    
    func endGame () {
        if isUserTurn {
            if userScores[0] > maxScore {
                isGameOver = true
                gameOverText = "Game Over!"
            }
        } else {
            if dealerScores[0] > maxScore {
                isGameOver = true
                gameOverText = "You win!"
            }
        }
    }
}


