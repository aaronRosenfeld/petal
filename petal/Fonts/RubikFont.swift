//
//  RubikFont.swift
//  petal
//
//  Created by Aaron Rosenfeld on 8/15/24.
//

import Foundation
import SwiftUI

enum RubikFontWeight {
    case black
    case blackItalic
    case bold
    case boldItalic
    case extraBold
    case extraBoldItalic
    case italic
    case light
    case lightItalic
    case medium
    case mediumItalic
    case regular
    case semiBold
    case semiBoldItalic
}

extension Font {
    static let rubik: (RubikFontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .black:
            Font.custom("Rubik-Black", size: size)
        case .blackItalic:
            Font.custom("Rubik-BlackItalic", size: size)
        case .bold:
            Font.custom("Rubik-Bold", size: size)
        case .boldItalic:
            Font.custom("Rubik-BoldItalic", size: size)
        case .extraBold:
            Font.custom("Rubik-ExtraBold", size: size)
        case .extraBoldItalic:
            Font.custom("Rubik-ExtraBoldItalic", size: size)
        case .italic:
            Font.custom("Rubik-Italic", size: size)
        case .light:
            Font.custom("Rubik-Light", size: size)
        case .lightItalic:
            Font.custom("Rubik-LightItalic", size: size)
        case .medium:
            Font.custom("Rubik-Medium", size: size)
        case .mediumItalic:
            Font.custom("Rubik-MediumItalic", size: size)
        case .regular:
            Font.custom("Rubik-Regular", size: size)
        case .semiBold:
            Font.custom("Rubik-SemiBold", size: size)
        case .semiBoldItalic:
            Font.custom("Rubik-SemiBoldItalic", size: size)
        }
    }
}
