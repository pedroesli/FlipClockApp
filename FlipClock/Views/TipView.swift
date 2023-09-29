//
//  TipView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 28/09/23.
//

import SwiftUI
import StoreKit

struct TipView: View {
    
    @EnvironmentObject private var manager: StoreManager
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                SubTitle()
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(Localization.TipView.WhyTip.title)
                            .font(.title3)
                        .fontWeight(.semibold)
                        Image(systemName: "heart.fill")
                            .foregroundColor(.red)
                    }
                    Text(AttributedString.markdown(Localization.TipView.WhyTip.text))
                        .font(.callout)
                }
                .padding(.top, 6)
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text(Localization.TipView.MoreUpdates.title)
                            .font(.title3)
                        .fontWeight(.semibold)
                        Image(systemName: "figure.mixed.cardio")
                            .foregroundColor(.cyan)
                    }
                    Text(AttributedString.markdown(Localization.TipView.MoreUpdates.text))
                        .font(.callout)
                }
                .padding(.top, 6)
                Divider()
                    .padding(.vertical)
                VStack(spacing: 6) {
                    Text(Localization.TipView.yourHelpMeansAlot)
                        .font(.title3.bold())
                    Label(Localization.TipView.disclosure, systemImage: "exclamationmark.circle")
                        .font(.caption)
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
                ForEach(manager.products) { product in
                    HStack {
                        Text(product.displayName)
                        Spacer()
                        Button(product.displayPrice) {
                            manager.purchase(product)
                        }
                        .buttonStyle(.borderedProminent)
                        .foregroundStyle(.blue)
                        .capsuleButtonShape()
                        .frame(height: 44)
                    }
                    .padding(.bottom, 6)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            .padding(.top)
        }
        .navigationTitle(Localization.TipView.title)
        .onAppear {
            manager.getProducts()
        }
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
    }
    
    struct SubTitle: View {
        
        @Environment(\.dismiss) var dismiss
        
        var body: some View {
            #if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .phone {
                Text(Localization.TipView.subtitle)
                    .font(.title2.bold())
            } else {
                Text(Localization.TipView.subtitle)
                    .font(.largeTitle.bold())
            }
            #else
                Text(Localization.TipView.subtitle)
                    .font(.largeTitle.bold())
            #endif
        }
    }
}

#Preview("TipView") {
    TipView()
        .environmentObject(StoreManager())
}
