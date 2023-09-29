//
//  ThankYouTipView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/09/23.
//

import SwiftUI

struct ThankYouTipView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Text(Localization.ThankYouTip.title)
                .font(.largeTitle.bold())
            VStack(alignment: .leading, spacing: 4) {
                Text(Localization.ThankYouTip.text)
                    .padding(.top)
                Link(Localization.ThankYouTip.email, destination: URL(string: "mailto:\(Localization.ThankYouTip.email)")!)
                    .tint(.blue)
            }
            Text("❤️")
                .font(.system(size: 100))
                .padding(.top, 26)
            Button(Localization.ThankYouTip.button) {
                dismiss()
            }
            .font(.title)
            .buttonStyle(.bordered)
            .tint(.blue)
            .buttonBorderShape(.capsule)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .padding(.top, 36)
        .padding(.horizontal)
    }
}

#Preview {
    ThankYouTipView()
}
