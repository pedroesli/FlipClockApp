//
//  FlipTextPlacement.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 07/08/23.
//

import SwiftUI

enum FlipTextPlacement {
    case left
    case right
    
    var alignmentBottom: Alignment {
        switch self {
        case .left: return .topLeading
        case .right: return .topTrailing
        }
    }
    
    var alignmentTop: Alignment {
        switch self {
        case .left: return .bottomLeading
        case .right: return .bottomTrailing
        }
    }
}
