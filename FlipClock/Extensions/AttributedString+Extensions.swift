//
//  AttributedString+Extensions.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/09/23.
//

import Foundation

extension AttributedString {
    static func markdown(_ text: String) -> AttributedString {
        do {
            return try AttributedString(markdown: text)
        } catch {
            print("Markdown error: \(error)")
            let removedBold = text.replacingOccurrences(of: "*", with: "")
            return AttributedString(stringLiteral: removedBold)
        }
    }
}
