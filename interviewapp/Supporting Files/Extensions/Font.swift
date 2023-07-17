//
//  Font.swift
//  interviewapp
//
//  Created by Iván Fernández Arenas on 15/7/23.
//

import SwiftUI

extension Font {

    enum UbuntuFont {
        case bold
        case medium
        case regular

        var value: String {
            switch self {
            case .bold:
                return "Ubuntu-B"
            case .medium:
                return "Ubuntu-M"
            case .regular:
                return "Ubuntu-R"
            }
        }
    }


    static func ubuntu(_ type: UbuntuFont, size: CGFloat = 16) -> Font {
        return Font.custom(type.value, size: size)
    }

}
