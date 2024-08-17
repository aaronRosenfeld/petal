//
//  ContentView.swift
//  petal
//
//  Created by Aaron Rosenfeld on 8/15/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showingResetAlert = false
    
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
        
        let colors = ContentView.getRandomColors()
        
        self.playerOneOpponents = [Opponent(color: colors[0], orientation: .east),
                                   Opponent(color: colors[1], orientation: .west),
                                   Opponent(color: colors[2], orientation: .east),
                                   Opponent(color: colors[3], orientation: .west)]
        self.playerTwoOpponents = [Opponent(color: colors[0], orientation: .east),
                                   Opponent(color: colors[1], orientation: .west),
                                   Opponent(color: colors[2], orientation: .east),
                                   Opponent(color: colors[3], orientation: .west)]
        self.playerThreeOpponents = [Opponent(color: colors[0], orientation: .east),
                                     Opponent(color: colors[1], orientation: .west),
                                     Opponent(color: colors[2], orientation: .east),
                                     Opponent(color: colors[3], orientation: .west)]
        self.playerFourOpponents = [Opponent(color: colors[0], orientation: .east),
                                    Opponent(color: colors[1], orientation: .west),
                                    Opponent(color: colors[2], orientation: .east),
                                    Opponent(color: colors[3], orientation: .west)]
    }
    
    var body: some View {
        ZStack {
            HStack(spacing: 0) {
                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        PlayerCounterView(playerIndex: 0,
                                          orientation: .east,
                                          lifeTotal: $playerOneLifeTotal,
                                          commanderDamageDelt: $playerOneCommanderDamageDelt,
                                          backgroundColor: $playerOneOpponents[0].color,
                                          commanderDamageButtonAlignment: .topLeading,
                                          commanderDamageTapped: { toggleActiveCommander(index: 0) },
                                          activeCommanderDamagePlayer: $activeCommanderDamagePlayer,
                                          commanderDamageChange: { amount in commanderDamageChange(amount: amount, callerIndex: 0) },
                                          opponents: $playerOneOpponents)
                        PlayerCounterView(playerIndex: 1,
                                          orientation: .west,
                                          lifeTotal: $playerTwoLifeTotal,
                                          commanderDamageDelt: $playerTwoCommanderDamageDelt,
                                          backgroundColor: $playerOneOpponents[1].color,
                                          commanderDamageButtonAlignment: .topTrailing,
                                          commanderDamageTapped: { toggleActiveCommander(index: 1) },
                                          activeCommanderDamagePlayer: $activeCommanderDamagePlayer,
                                          commanderDamageChange: { amount in commanderDamageChange(amount: amount, callerIndex: 1) },
                                          opponents: $playerTwoOpponents)
                    }
                    HStack(spacing: 8) {
                        PlayerCounterView(playerIndex: 2,
                                          orientation: .east,
                                          lifeTotal: $playerThreeLifeTotal,
                                          commanderDamageDelt: $playerThreeCommanderDamageDelt,
                                          backgroundColor: $playerOneOpponents[2].color,
                                          commanderDamageButtonAlignment: .bottomLeading,
                                          commanderDamageTapped: { toggleActiveCommander(index: 2) },
                                          activeCommanderDamagePlayer: $activeCommanderDamagePlayer,
                                          commanderDamageChange: { amount in commanderDamageChange(amount: amount, callerIndex: 2) },
                                          opponents: $playerThreeOpponents)
                        PlayerCounterView(playerIndex: 3,
                                          orientation: .west,
                                          lifeTotal: $playerFourLifeTotal,
                                          commanderDamageDelt: $playerFourCommanderDamageDelt,
                                          backgroundColor: $playerOneOpponents[3].color,
                                          commanderDamageButtonAlignment: .bottomTrailing,
                                          commanderDamageTapped: { toggleActiveCommander(index: 3) },
                                          activeCommanderDamagePlayer: $activeCommanderDamagePlayer,
                                          commanderDamageChange: { amount in commanderDamageChange(amount: amount, callerIndex: 3) },
                                          opponents: $playerFourOpponents)
                    }
                }
            }
            Button {
                showingResetAlert = true
            } label: {
                Circle()
                    .fill(.black)
                    .frame(width: 60)
                    .overlay {
                        Circle()
                            .fill(.white)
                            .frame(width: 44)
                    }
            }
            .background {
                Circle()
                    .fill(.black)
            }
        }
        .alert("Are you sure you want to reset?", isPresented: $showingResetAlert) {
            Button("Yes", role:  .destructive) {
                playerOneLifeTotal = 40
                playerOneCommanderDamageDelt = [0, 0, 0, 0]
                playerTwoLifeTotal = 40
                playerTwoCommanderDamageDelt = [0, 0, 0, 0]
                playerThreeLifeTotal = 40
                playerThreeCommanderDamageDelt = [0, 0, 0, 0]
                playerFourLifeTotal = 40
                playerFourCommanderDamageDelt = [0, 0, 0, 0]
                activeCommanderDamagePlayer = nil
                
                let colors = ContentView.getRandomColors()
                
                self.playerOneOpponents = [Opponent(color: colors[0], orientation: .east),
                                           Opponent(color: colors[1], orientation: .west),
                                           Opponent(color: colors[2], orientation: .east),
                                           Opponent(color: colors[3], orientation: .west)]
                self.playerTwoOpponents = [Opponent(color: colors[0], orientation: .east),
                                           Opponent(color: colors[1], orientation: .west),
                                           Opponent(color: colors[2], orientation: .east),
                                           Opponent(color: colors[3], orientation: .west)]
                self.playerThreeOpponents = [Opponent(color: colors[0], orientation: .east),
                                             Opponent(color: colors[1], orientation: .west),
                                             Opponent(color: colors[2], orientation: .east),
                                             Opponent(color: colors[3], orientation: .west)]
                self.playerFourOpponents = [Opponent(color: colors[0], orientation: .east),
                                            Opponent(color: colors[1], orientation: .west),
                                            Opponent(color: colors[2], orientation: .east),
                                            Opponent(color: colors[3], orientation: .west)]
            }
            Button("No", role: .cancel) {}
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
    
    private func commanderDamageChange(amount: Int, callerIndex: Int) {
        switch activeCommanderDamagePlayer {
        case .some(0):
            playerOneLifeTotal -= amount
            playerOneOpponents[callerIndex].damageDelt +=  amount
        case .some(1):
            playerTwoLifeTotal -= amount
            playerTwoOpponents[callerIndex].damageDelt +=  amount
        case .some(2):
            playerThreeLifeTotal -= amount
            playerThreeOpponents[callerIndex].damageDelt +=  amount
        case .some(3):
            playerFourLifeTotal -= amount
            playerFourOpponents[callerIndex].damageDelt +=  amount
        default:
            return
        }
    }
    
    private static func getRandomColors() -> [Color] {
        var allColors = [
            Color("concord"),
            Color("honey"),
            Color("peach"),
            Color("stoneWash"),
            Color("tiffany"),
            Color("treeFrog")
        ]
        allColors = allColors.shuffled()
        return allColors.dropLast(2)
    }
}

#Preview {
    ContentView()
}
