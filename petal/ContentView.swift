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
    @State var playerOneOpponents: [Opponent]
    @State var playerTwoLifeTotal = 40
    @State var playerTwoCommanderDamageDelt = [0, 0, 0, 0]
    @State var playerTwoOpponents: [Opponent]
    @State var playerThreeLifeTotal = 40
    @State var playerThreeCommanderDamageDelt = [0, 0, 0, 0]
    @State var playerThreeOpponents: [Opponent]
    @State var playerFourLifeTotal = 40
    @State var playerFourCommanderDamageDelt = [0, 0, 0, 0]
    @State var playerFourOpponents: [Opponent]
    @State var activeCommanderDamagePlayer: Int? = nil
    
    init(playerOneLifeTotal: Int = 40,
         playerOneCommanderDamageDelt: [Int] = [0, 0, 0, 0],
         playerTwoLifeTotal: Int = 40,
         playerTwoCommanderDamageDelt: [Int] = [0, 0, 0, 0],
         playerThreeLifeTotal: Int = 40,
         playerThreeCommanderDamageDelt: [Int] = [0, 0, 0, 0],
         playerFourLifeTotal: Int = 40,
         playerFourCommanderDamageDelt: [Int] = [0, 0, 0, 0],
         activeCommanderDamagePlayer: Int? = nil) {
        self.playerOneLifeTotal = playerOneLifeTotal
        self.playerOneCommanderDamageDelt = playerOneCommanderDamageDelt
        self.playerTwoLifeTotal = playerTwoLifeTotal
        self.playerTwoCommanderDamageDelt = playerTwoCommanderDamageDelt
        self.playerThreeLifeTotal = playerThreeLifeTotal
        self.playerThreeCommanderDamageDelt = playerThreeCommanderDamageDelt
        self.playerFourLifeTotal = playerFourLifeTotal
        self.playerFourCommanderDamageDelt = playerFourCommanderDamageDelt
        self.activeCommanderDamagePlayer = activeCommanderDamagePlayer
        
        let playerList = [Opponent(color: .teal, orientation: .east),
                          Opponent(color: .green, orientation: .west),
                          Opponent(color: .purple, orientation: .east),
                          Opponent(color: .orange, orientation: .west)]
        self.playerOneOpponents = playerList
        self.playerTwoOpponents = playerList
        self.playerThreeOpponents = playerList
        self.playerFourOpponents = playerList
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(spacing: 8) {
                HStack(spacing: 8) {
                    PlayerCounterView(playerIndex: 0,
                                      orientation: .east,
                                      lifeTotal: $playerOneLifeTotal,
                                      commanderDamageDelt: $playerOneCommanderDamageDelt,
                                      backgroundColor: .teal,
                                      commanderDamageButtonAlignment: .topLeading,
                                      commanderDamageTapped: { toggleActiveCommander(index: 0) },
                                      activeCommanderDamagePlayer: $activeCommanderDamagePlayer, 
                                      commanderDamageChange: { amount in commanderDamageChange(amount: amount) },
                                      opponents: $playerOneOpponents)
                    PlayerCounterView(playerIndex: 1,
                                      orientation: .west,
                                      lifeTotal: $playerTwoLifeTotal,
                                      commanderDamageDelt: $playerTwoCommanderDamageDelt,
                                      backgroundColor: .green,
                                      commanderDamageButtonAlignment: .topTrailing,
                                      commanderDamageTapped: { toggleActiveCommander(index: 1) },
                                      activeCommanderDamagePlayer: $activeCommanderDamagePlayer, 
                                      commanderDamageChange: { amount in commanderDamageChange(amount: amount) }, 
                                      opponents: $playerTwoOpponents)
                }
                HStack(spacing: 8) {
                    PlayerCounterView(playerIndex: 2,
                                      orientation: .east,
                                      lifeTotal: $playerThreeLifeTotal,
                                      commanderDamageDelt: $playerThreeCommanderDamageDelt,
                                      backgroundColor: .purple,
                                      commanderDamageButtonAlignment: .bottomLeading,
                                      commanderDamageTapped: { toggleActiveCommander(index: 2) },
                                      activeCommanderDamagePlayer: $activeCommanderDamagePlayer, 
                                      commanderDamageChange: { amount in commanderDamageChange(amount: amount) },
                                      opponents: $playerThreeOpponents)
                    PlayerCounterView(playerIndex: 3,
                                      orientation: .west,
                                      lifeTotal: $playerFourLifeTotal,
                                      commanderDamageDelt: $playerFourCommanderDamageDelt,
                                      backgroundColor: .orange,
                                      commanderDamageButtonAlignment: .bottomTrailing,
                                      commanderDamageTapped: { toggleActiveCommander(index: 3) },
                                      activeCommanderDamagePlayer: $activeCommanderDamagePlayer, 
                                      commanderDamageChange: { amount in commanderDamageChange(amount: amount) }, 
                                      opponents: $playerFourOpponents)
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
