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
    @Binding var opponents: [Opponent]
    
    @State private var isLifeUpPressed = false
    @State private var isLifeDownPressed = false
    
    var body: some View {
        ZStack {
            Color(getAccentColor())
                .animation(.smooth, value: activeCommanderDamagePlayer)
            switch getDisplayOrientation() {
            case .north, .south:
                Rectangle()
                    .fill(getBaseColor().opacity(0.15))
                    .frame(height: 2)
                    .animation(.smooth, value: activeCommanderDamagePlayer)
                Text(getLifeOrCommanderDamage(), format: .number)
                    .font(.rubik(.extraBold, 90.0))
                    .foregroundStyle(getBaseColor())
                    .padding()
                    .background {
                        Color(getAccentColor())
                            .rotationEffect(.degrees(getDisplayOrientation().rawValue))
                            .animation(.smooth, value: activeCommanderDamagePlayer)
                    }
                    .rotationEffect(.degrees(getDisplayOrientation().rawValue))
//                    .animation(.smooth, value: activeCommanderDamagePlayer)
            case .east, .west:
                Rectangle()
                    .fill(getBaseColor().opacity(0.15))
                    .frame(width: 2)
                    .animation(.smooth, value: activeCommanderDamagePlayer)
                VerticalLayout {
                    Text(getLifeOrCommanderDamage(), format: .number)
                }
                .font(.rubik(.extraBold, 90.0))
                .foregroundStyle(getBaseColor())
                .padding()
                .background {
                    Color(getAccentColor())
                        .rotationEffect(.degrees(getDisplayOrientation().rawValue))
                        .animation(.smooth, value: activeCommanderDamagePlayer)
                }
                .rotationEffect(.degrees(getDisplayOrientation().rawValue))
//                .animation(.smooth, value: activeCommanderDamagePlayer)
            }
            
            if !isInCommanderDamageMode() {
                switch getDisplayOrientation() {
                case .north:
                    VStack {
                        opponentLifeStack()
                            .padding(.top, 12)
                        Spacer()
                    }
                case .east:
                    HStack {
                        Spacer()
                        VerticalLayout {
                            opponentLifeStack()
                        }
                        .rotationEffect(.degrees(getDisplayOrientation().rawValue))
                        .padding(.trailing, 12)
                    }
                case .south:
                    VStack {
                        Spacer()
                        opponentLifeStack()
                            .rotationEffect(.degrees(getDisplayOrientation().rawValue))
                            .padding(.bottom, 12)
                    }
                case .west:
                    HStack {
                        VerticalLayout {
                            opponentLifeStack()
                        }
                        .rotationEffect(.degrees(getDisplayOrientation().rawValue))
                        .padding(.leading, 12)
                        Spacer()
                    }
                }
            }
            
//            TODO: return to this when you have enough patience to figure out the issue with the minus sign rotation offsets
//            else {
//                switch getDisplayOrientation() {
//                case .north:
//                    VStack {
//                        Image(systemName: "plus")
//                            .font(Font.headline.weight(.black))
//                            .foregroundColor(getBaseColor().opacity(0.5))
//                            .padding(.top, 16)
////                            .rotationEffect(.degrees(getDisplayOrientation().rawValue))
//                        Spacer()
//                        Image(systemName: "minus")
//                            .font(Font.headline.weight(.black))
//                            .foregroundColor(getBaseColor().opacity(0.5))
//                            .padding(.bottom, 12)
////                            .rotationEffect(.degrees(getDisplayOrientation().rawValue))
//                    }
//                case .south:
//                    VStack {
//                        Image(systemName: "minus")
//                            .font(Font.headline.weight(.black))
//                            .foregroundColor(getBaseColor().opacity(0.5))
//                            .padding(.top, 16)
////                            .rotationEffect(.degrees(getDisplayOrientation().rawValue))
//                        Spacer()
//                        Image(systemName: "plus")
//                            .font(Font.headline.weight(.black))
//                            .foregroundColor(getBaseColor().opacity(0.5))
//                            .padding(.bottom, 16)
////                            .rotationEffect(.degrees(getDisplayOrientation().rawValue))
//                    }
//                case .east:
//                    HStack {
//                        Image(systemName: "minus")
//                            .font(Font.headline.weight(.black))
//                            .foregroundColor(getBaseColor().opacity(0.5))
//                            .padding(.leading, 16)
//                            .rotationEffect(.degrees(getDisplayOrientation().rawValue)).offset(x: 10)
//                        Spacer()
//                        Image(systemName: "plus")
//                            .font(Font.headline.weight(.black))
//                            .foregroundColor(getBaseColor().opacity(0.5))
//                            .padding(.trailing, 16)
////                            .rotationEffect(.degrees(getDisplayOrientation().rawValue))
//                    }
//                case .west:
//                    HStack {
//                        Image(systemName: "plus")
//                            .font(Font.headline.weight(.black))
//                            .foregroundColor(getBaseColor().opacity(0.5))
//                            .padding(.leading, 16)
////                            .rotationEffect(.degrees(getDisplayOrientation().rawValue))
//                        Spacer()
//                        Image(systemName: "minus")
//                            .font(Font.headline.weight(.black))
//                            .foregroundColor(getBaseColor().opacity(0.5))
//                            .padding(.trailing, 16)
//                            .rotationEffect(.degrees(getDisplayOrientation().rawValue)).offset(x: -10)
//                    }
//                }
//            }

            
            switch getDisplayOrientation() {
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
                Image(systemName: activeCommanderDamagePlayer == playerIndex ? "xmark" : "seal.fill")
                    .if(activeCommanderDamagePlayer == playerIndex, transform: { view in
                        view
                            .font(Font.headline.weight(.black))
                    })
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
    
    @ViewBuilder
    private func opponentLifeStack() ->  some View {
        HStack {
            ForEach(Array(opponents.enumerated()), id: \.offset ) { index, opponent in
                if index != playerIndex , opponent.damageDelt != 0 {
                    Text(opponent.damageDelt, format: .number)
                        .font(.rubik(.bold, 18))
                        .foregroundStyle(getBaseColor())
                        .padding(.vertical, 2)
                        .padding(.horizontal, 8)
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(opponent.color)
                        }
                }
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
    
    private func getDisplayOrientation() -> Orientation {
        if isInCommanderDamageMode(),
           let activeCommanderDamagePlayer = activeCommanderDamagePlayer {
            return opponents[activeCommanderDamagePlayer].orientation
        }
        return orientation
    }
}

#Preview {
    struct Preview: View {
        @State var lifeTotal = 40
        @State var commanderDamageDelt = [0, 0, 0, 0]
        @State var opponents = [
            Opponent(color: .red, orientation: .north),
            Opponent(color: .green, orientation: .east),
            Opponent(color: .yellow, orientation: .south),
            Opponent(color: .purple, orientation: .west)
        ]
        var body: some View {
            VStack {
                PlayerCounterView(playerIndex: 0,
                                  orientation: .north,
                                  lifeTotal: $lifeTotal,
                                  commanderDamageDelt: $commanderDamageDelt,
                                  commanderDamageButtonAlignment: .bottomTrailing,
                                  commanderDamageTapped: { print("north") },
                                  activeCommanderDamagePlayer: .constant(nil), 
                                  commanderDamageChange: {_ in },
                                  opponents: $opponents)
                    .frame(width: 300, height: 150)
                PlayerCounterView(playerIndex: 1,
                                  orientation: .east,
                                  lifeTotal: $lifeTotal,
                                  commanderDamageDelt: $commanderDamageDelt,
                                  commanderDamageButtonAlignment: .bottomTrailing,
                                  commanderDamageTapped: { print("north") },
                                  activeCommanderDamagePlayer: .constant(nil),
                                  commanderDamageChange: {_ in },
                                  opponents: $opponents)
                    .frame(width: 300, height: 150)
                PlayerCounterView(playerIndex: 2,
                                  orientation: .south,
                                  lifeTotal: $lifeTotal,
                                  commanderDamageDelt: $commanderDamageDelt,
                                  commanderDamageButtonAlignment: .bottomTrailing,
                                  commanderDamageTapped: { print("north") },
                                  activeCommanderDamagePlayer: .constant(nil),
                                  commanderDamageChange: {_ in },
                                  opponents: $opponents)
                    .frame(width: 300, height: 150)
                PlayerCounterView(playerIndex: 3,
                                  orientation: .west,
                                  lifeTotal: $lifeTotal,
                                  commanderDamageDelt: $commanderDamageDelt,
                                  commanderDamageButtonAlignment: .bottomTrailing,
                                  commanderDamageTapped: { print("north") },
                                  activeCommanderDamagePlayer: .constant(nil),
                                  commanderDamageChange: {_ in },
                                  opponents: $opponents)
                    .frame(width: 300, height: 150)
            }
            .padding()
            .background(.black)
        }
    }
    
    return Preview()
}
