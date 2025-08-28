//
//  CompatibleText.swift
//  life-counter-ios
//
//  Created by Alexander on 28.08.25.
//

import SwiftUI

struct CompatibleText: View {
    let text: String

    var body: some View {
        if #available(iOS 16.0, *) {
            Text(text)
                .font(Fonts.main)
                .foregroundStyle(
                    .text.shadow(
                        .inner(color: .black.opacity(0.4), radius: 4, x: -2, y: 2)
                    )
                )
        } else {
            Text(text)
                .font(Fonts.main)
                .foregroundStyle(.textCompat)
        }
    }
}
