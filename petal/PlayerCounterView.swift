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
    
    let orientation: Orientation
    @Binding var lifeTotal: Int
    @State var backgroundColor: Color = .teal
    let commanderDamageButtonAlignment: Alignment
    let commanderDamageTapped: () -> Void
    
    @State private var isLifeUpPressed = false
    @State private var isLifeDownPressed = false
    
    var body: some View {
        ZStack {
            Color(backgroundColor)
            switch orientation {
            case .north, .south:
                Rectangle()
                    .fill(.white.opacity(0.15))
                    .frame(height: 1)
            case .east, .west:
                Rectangle()
                    .fill(.white.opacity(0.15))
                    .frame(width: 1)
            }
            Text(lifeTotal, format: .number)
                .font(.system(size: 60))
                .foregroundStyle(.white)
                .padding()
                .background {
                    Color(backgroundColor)
                }
                .rotationEffect(.degrees(orientation.rawValue))
            
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
                            .fill(.white)
                    }
            }
            .tint(backgroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: commanderDamageButtonAlignment)
            .padding(24)
        }
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .ignoresSafeArea()
    }
    
    @ViewBuilder
    private func lifeUpButton() -> some View {
        Color(.white)
            .opacity(isLifeUpPressed ? 0.2 : 0.0001)
            .onTapGesture {
                lifeTotal += 1
            }
            .onLongPressGesture(minimumDuration: 0.2) {
                lifeTotal += 10
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
        Color(.white)
            .opacity(isLifeDownPressed ? 0.2 : 0.0001)
            .onTapGesture {
                lifeTotal -= 1
            }
            .onLongPressGesture(minimumDuration: 0.2) {
                lifeTotal -= 10
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
}

#Preview {
    struct Preview: View {
        @State var lifeTotal = 40
        var body: some View {
            VStack {
                PlayerCounterView(orientation: .north, lifeTotal: $lifeTotal, commanderDamageButtonAlignment: .bottomTrailing, commanderDamageTapped: { print("north") })
                    .frame(width: 300, height: 150)
                PlayerCounterView(orientation: .east, lifeTotal: $lifeTotal, commanderDamageButtonAlignment: .topLeading, commanderDamageTapped: { print("east") })
                    .frame(width: 300, height: 150)
                PlayerCounterView(orientation: .south, lifeTotal: $lifeTotal, commanderDamageButtonAlignment: .topTrailing, commanderDamageTapped: { print("south") })
                    .frame(width: 300, height: 150)
                PlayerCounterView(orientation: .west, lifeTotal: $lifeTotal, commanderDamageButtonAlignment: .bottomLeading, commanderDamageTapped: { print("west") })
                    .frame(width: 300, height: 150)
            }
            .padding()
        }
    }
    
    return Preview()
}
