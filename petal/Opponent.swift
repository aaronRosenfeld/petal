//
//  Opponent.swift
//  petal
//
//  Created by Aaron Rosenfeld on 8/16/24.
//

import Foundation
import SwiftUI

class Opponent {
    var color: Color
    let orientation: PlayerCounterView.Orientation
    var damageDelt: Int = 0
    
    init(color: Color, orientation: PlayerCounterView.Orientation, damageDelt: Int = 0) {
        self.color = color
        self.orientation = orientation
        self.damageDelt = damageDelt
    }
}
