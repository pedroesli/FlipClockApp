//
//  FlipType.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 06/08/23.
//

import SwiftUI
import CornerRoundedRectangle

enum FlipTextHalfPlacement {
    case top
    case bottom
    
    var alignment: Alignment {
        switch self {
        case .top: return Alignment.top
        case .bottom: return Alignment.bottom
        }
    }
    
    var corners: CornerRoundedRectangle.CornerSet {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
    
    var edges: Edge.Set {
        switch self {
        case .top: return .top
        case .bottom: return .bottom
        }
    }
}
