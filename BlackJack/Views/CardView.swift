//
//  CardView.swift
//  BlackJack
//
//  Created by Chris Lucas on 11.08.20.
//  Copyright © 2020 Chris Lucas. All rights reserved.
//

import SwiftUI

struct CardView: View {
    let card: Card
    
    var body: some View {
        Image(card.image)
            .shadow(radius: 5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: Card(cardType: .clubFive))
    }
}
