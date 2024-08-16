//
//  PlayerCounterView.swift
//  petal
//
//  Created by Aaron Rosenfeld on 8/15/24.
//

import SwiftUI

struct PlayerCounterView: View {
    enum Orientation: Double {
        case north = 0
        case east = 90
        case south = 180
        case west = 270
    }
    
    let playerIndex: Int
    let orientation: Orientation
    @Binding var lifeTotal: Int
    @Binding var commanderDamageDelt: [Int]
    @State var backgroundColor: Color = .teal
    let commanderDamageButtonAlignment: Alignment
    let commanderDamageTapped: () -> Void
    @Binding var activeCommanderDamagePlayer: Int?
    let commanderDamageChange: (Int) -> Void
    
    @State private var isLifeUpPressed = false
    @State private var isLifeDownPressed = false
    
    var body: some View {
        ZStack {
            Color(getAccentColor())
                .animation(.smooth, value: activeCommanderDamagePlayer)
            switch orientation {
            case .north, .south:
                Rectangle()
                    .fill(getBaseColor().opacity(0.15))
                    .frame(height: 1)
                    .animation(.smooth, value: activeCommanderDamagePlayer)
            case .east, .west:
                Rectangle()
                    .fill(getBaseColor().opacity(0.15))
                    .frame(width: 1)
                    .animation(.smooth, value: activeCommanderDamagePlayer)
            }
            
            if orientation == .east || orientation == .west {
                VerticalLayout {
                    Text(getLifeOrCommanderDamage(), format: .number)
                }
                .font(.rubik(.extraBold, 90.0))
                .foregroundStyle(getBaseColor())
                .padding()
                .background {
                    Color(getAccentColor())
                        .rotationEffect(.degrees(orientation.rawValue))
                        .animation(.smooth, value: activeCommanderDamagePlayer)
                }
                .rotationEffect(.degrees(orientation.rawValue))
                .animation(.smooth, value: activeCommanderDamagePlayer)
            } else {
                Text(getLifeOrCommanderDamage(), format: .number)
                    .font(.rubik(.extraBold, 90.0))
                    .foregroundStyle(getBaseColor())
                    .padding()
                    .background {
                        Color(getAccentColor())
                            .rotationEffect(.degrees(orientation.rawValue))
                            .animation(.smooth, value: activeCommanderDamagePlayer)
                    }
                    .rotationEffect(.degrees(orientation.rawValue))
                    .animation(.smooth, value: activeCommanderDamagePlayer)
            }
            
            switch orientation {
            case .north:
                VStack(spacing: 0) {
                    lifeUpButton()
                    lifeDownButton()
                }
            case .east:
                HStack(spacing: 0) {
                    lifeDownButton()
                    lifeUpButton()
                }
            case .south:
                VStack(spacing: 0) {
                    lifeDownButton()
                    lifeUpButton()
                }
            case .west:
                HStack(spacing: 0) {
                    lifeUpButton()
                    lifeDownButton()
                }
            }
            
            Button {
                commanderDamageTapped()
            } label: {
                Image(systemName: "seal.fill")
                    .scaleEffect(1.5)
                    .frame(width: 40, height: 40)
                    .padding(4)
                    .background {
                        Circle()
                            .fill(getBaseColor())
                            .animation(.smooth, value: activeCommanderDamagePlayer)
                    }
            }
            .tint(getAccentColor())
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: commanderDamageButtonAlignment)
            .padding(24)
            .animation(.smooth, value: activeCommanderDamagePlayer)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func lifeUpButton() -> some View {
        Color(getBaseColor())
            .opacity(isLifeUpPressed ? 0.2 : 0.0001)
            .onTapGesture {
                if isInCommanderDamageMode(), let index = activeCommanderDamagePlayer {
                    commanderDamageDelt[index] += 1
                    commanderDamageChange(1)
                } else {
                    lifeTotal += 1
                }
            }
            .onLongPressGesture(minimumDuration: 0.2) {
                if isInCommanderDamageMode(), let index = activeCommanderDamagePlayer {
                    commanderDamageDelt[index] += 10
                    commanderDamageChange(10)
                } else {
                    lifeTotal += 10
                }
            }
            .pressEvents {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isLifeUpPressed = true
                }
            } onRelease: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isLifeUpPressed = false
                }
            }
    }
    
    @ViewBuilder
    private func lifeDownButton() -> some View {
        Color(getBaseColor())
            .opacity(isLifeDownPressed ? 0.2 : 0.0001)
            .onTapGesture {
                if isInCommanderDamageMode(), let index = activeCommanderDamagePlayer {
                    commanderDamageDelt[index] -= 1
                    commanderDamageChange(-1)
                } else {
                    lifeTotal -= 1
                }
            }
            .onLongPressGesture(minimumDuration: 0.2) {
                if isInCommanderDamageMode(), let index = activeCommanderDamagePlayer {
                    commanderDamageDelt[index] -= 10
                    commanderDamageChange(-10)
                } else {
                    lifeTotal -= 10
                }
            }
            .pressEvents {
                withAnimation(.easeInOut(duration: 0.1)) {
                    isLifeDownPressed = true
                }
            } onRelease: {
                withAnimation(.easeInOut(duration: 0.4)) {
                    isLifeDownPressed = false
                }
            }
    }
    
    private func isInCommanderDamageMode() -> Bool {
        return activeCommanderDamagePlayer != nil && activeCommanderDamagePlayer != playerIndex
    }
    
    private func getAccentColor() -> Color {
        return isInCommanderDamageMode() ? .white : backgroundColor
    }
    
    private func getBaseColor() -> Color {
        return isInCommanderDamageMode() ? backgroundColor : .white
    }
    
    private func getLifeOrCommanderDamage() -> Int {
        if isInCommanderDamageMode(), let index = activeCommanderDamagePlayer {
            return commanderDamageDelt[index]
        } else {
            return lifeTotal
        }
    }
}

#Preview {
    struct Preview: View {
        @State var lifeTotal = 40
        @State var commanderDamageDelt = [0, 0, 0, 0]
        var body: some View {
            VStack {
                PlayerCounterView(playerIndex: 0,
                                  orientation: .north,
                                  lifeTotal: $lifeTotal,
                                  commanderDamageDelt: $commanderDamageDelt,
                                  commanderDamageButtonAlignment: .bottomTrailing,
                                  commanderDamageTapped: { print("north") },
                                  activeCommanderDamagePlayer: .constant(nil), 
                                  commanderDamageChange: {_ in })
                    .frame(width: 300, height: 150)
                PlayerCounterView(playerIndex: 1,
                                  orientation: .east,
                                  lifeTotal: $lifeTotal,
                                  commanderDamageDelt: $commanderDamageDelt,
                                  commanderDamageButtonAlignment: .bottomTrailing,
                                  commanderDamageTapped: { print("north") },
                                  activeCommanderDamagePlayer: .constant(nil),
                                  commanderDamageChange: {_ in })
                    .frame(width: 300, height: 150)
                PlayerCounterView(playerIndex: 2,
                                  orientation: .south,
                                  lifeTotal: $lifeTotal,
                                  commanderDamageDelt: $commanderDamageDelt,
                                  commanderDamageButtonAlignment: .bottomTrailing,
                                  commanderDamageTapped: { print("north") },
                                  activeCommanderDamagePlayer: .constant(nil),
                                  commanderDamageChange: {_ in })
                    .frame(width: 300, height: 150)
                PlayerCounterView(playerIndex: 3,
                                  orientation: .west,
                                  lifeTotal: $lifeTotal,
                                  commanderDamageDelt: $commanderDamageDelt,
                                  commanderDamageButtonAlignment: .bottomTrailing,
                                  commanderDamageTapped: { print("north") },
                                  activeCommanderDamagePlayer: .constant(nil),
                                  commanderDamageChange: {_ in })
                    .frame(width: 300, height: 150)
            }
            .padding()
            .background(.black)
        }
    }
    
    return Preview()
}
