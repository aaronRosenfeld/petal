//
//  ContentView.swift
//  petal
//
//  Created by Aaron Rosenfeld on 8/15/24.
//

import SwiftUI

struct ContentView: View {
    @State var playerOneLifeTotal = 40
    @State var playerOneCommanderDamageDelt = [0, 0, 0, 0]
    @State var playerTwoLifeTotal = 40
    @State var playerTwoCommanderDamageDelt = [0, 0, 0, 0]
    @State var playerThreeLifeTotal = 40
    @State var playerThreeCommanderDamageDelt = [0, 0, 0, 0]
    @State var playerFourLifeTotal = 40
    @State var playerFourCommanderDamageDelt = [0, 0, 0, 0]
    @State var activeCommanderDamagePlayer: Int? = nil
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    PlayerCounterView(playerIndex: 0,
                                      orientation: .east,
                                      lifeTotal: $playerOneLifeTotal,
                                      commanderDamageDelt: $playerOneCommanderDamageDelt,
                                      commanderDamageButtonAlignment: .topLeading,
                                      commanderDamageTapped: { toggleActiveCommander(index: 0) },
                                      activeCommanderDamagePlayer: $activeCommanderDamagePlayer, 
                                      commanderDamageChange: { amount in commanderDamageChange(amount: amount) })
                    PlayerCounterView(playerIndex: 1,
                                      orientation: .west,
                                      lifeTotal: $playerTwoLifeTotal,
                                      commanderDamageDelt: $playerTwoCommanderDamageDelt,
                                      commanderDamageButtonAlignment: .topTrailing,
                                      commanderDamageTapped: { toggleActiveCommander(index: 1) },
                                      activeCommanderDamagePlayer: $activeCommanderDamagePlayer, 
                                      commanderDamageChange: { amount in commanderDamageChange(amount: amount) })
                }
                HStack(spacing: 8) {
                    PlayerCounterView(playerIndex: 2,
                                      orientation: .east,
                                      lifeTotal: $playerThreeLifeTotal,
                                      commanderDamageDelt: $playerThreeCommanderDamageDelt,
                                      commanderDamageButtonAlignment: .bottomLeading,
                                      commanderDamageTapped: { toggleActiveCommander(index: 2) },
                                      activeCommanderDamagePlayer: $activeCommanderDamagePlayer, 
                                      commanderDamageChange: { amount in commanderDamageChange(amount: amount) })
                    PlayerCounterView(playerIndex: 3,
                                      orientation: .west,
                                      lifeTotal: $playerFourLifeTotal,
                                      commanderDamageDelt: $playerFourCommanderDamageDelt,
                                      commanderDamageButtonAlignment: .bottomTrailing,
                                      commanderDamageTapped: { toggleActiveCommander(index: 3) },
                                      activeCommanderDamagePlayer: $activeCommanderDamagePlayer, 
                                      commanderDamageChange: { amount in commanderDamageChange(amount: amount) })
                }
            }
        }
        .background {
            Color(.black)
        }
        .ignoresSafeArea()
        .statusBar(hidden: true)
    }
    
    private func toggleActiveCommander(index: Int) {
        if activeCommanderDamagePlayer == index {
            activeCommanderDamagePlayer = nil
        } else {
            activeCommanderDamagePlayer = index
        }
    }
    
    private func commanderDamageChange(amount: Int) {
        switch activeCommanderDamagePlayer {
        case .some(0):
            playerOneLifeTotal -= amount
        case .some(1):
            playerTwoLifeTotal -= amount
        case .some(2):
            playerThreeLifeTotal -= amount
        case .some(3):
            playerFourLifeTotal -= amount
        default:
            return
        }
    }
}

#Preview {
    ContentView()
}
