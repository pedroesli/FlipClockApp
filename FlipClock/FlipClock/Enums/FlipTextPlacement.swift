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
    case center
    
    var alignmentBottom: Alignment {
        switch self {
        case .left: return .topLeading
        case .right: return .topTrailing
        case .center: return .top
        }
    }
    
    var alignmentTop: Alignment {
        switch self {
        case .left: return .bottomLeading
        case .right: return .bottomTrailing
        case .center: return .bottom
        }
    }
}
