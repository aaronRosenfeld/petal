//
//  ContentView.swift
//  petal
//
//  Created by Aaron Rosenfeld on 8/15/24.
//

import SwiftUI

struct ContentView: View {
    @State var playerOneLifeTotal = 40
    @State var playerTwoLifeTotal = 40
    @State var playerThreeLifeTotal = 40
    @State var playerFourLifeTotal = 40
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    PlayerCounterView(orientation: .east,
                                      lifeTotal: $playerOneLifeTotal,
                                      commanderDamageButtonAlignment: .topLeading,
                                      commanderDamageTapped: { print("north") })
                    PlayerCounterView(orientation: .west,
                                      lifeTotal: $playerTwoLifeTotal,
                                      commanderDamageButtonAlignment: .topTrailing,
                                      commanderDamageTapped: { print("east") })
                }
                HStack(spacing: 8) {
                    PlayerCounterView(orientation: .east,
                                      lifeTotal: $playerThreeLifeTotal,
                                      commanderDamageButtonAlignment: .bottomLeading,
                                      commanderDamageTapped: { print("south") })
                    PlayerCounterView(orientation: .west,
                                      lifeTotal: $playerFourLifeTotal,
                                      commanderDamageButtonAlignment: .bottomTrailing,
                                      commanderDamageTapped: { print("west") })
                }
            }
        }
        .background {
            Color(.black)
        }
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
}

#Preview {
    ContentView()
}
