//
//  FlipType.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI

enum FlipPlacement {
    case top
    case bottom
    
    var alignment: Alignment {
        switch self {
        case .top: return Alignment.top
        case .bottom: return Alignment.bottom
        }
    }
}
