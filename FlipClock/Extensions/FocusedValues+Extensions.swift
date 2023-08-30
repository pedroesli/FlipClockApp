//
//  FocusedValues+Extensions.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 29/08/23.
//

import SwiftUI

struct FocusedViewOptionKey: FocusedValueKey {
    typealias Value = Binding<ViewOption>
}

extension FocusedValues {
    var viewOption: FocusedViewOptionKey.Value? {
        get { self[FocusedViewOptionKey.self] }
        set { self[FocusedViewOptionKey.self] = newValue }
    }
}
