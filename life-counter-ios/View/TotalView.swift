//
//  TotalView.swift
//  life-counter-ios
//
//  Created by Alexander on 25.08.25.
//

import SwiftUI

struct TotalView: View {
    @StateObject var model: LifeTotalModel

    var path: KeyPath<LifeTotalModel, [Digit]>

    var body: some View {
        HStack(spacing: 2) {
            ForEach(model[keyPath: path].indices, id: \.self) { digit in
                if #available(iOS 16.0, *) {
                    Text("\(model[keyPath: path][digit].rawValue)")
                        .font(Fonts.main)
                        .foregroundStyle(
                            .totalText.shadow(
                                .inner(color: .black.opacity(0.4), radius: 4, x: -2, y: 2)
                            )
                        )
                } else {
                    Text("\(model[keyPath: path][digit].rawValue)")
                        .font(Fonts.main)
                        .foregroundStyle(.textCompat)
                }
            }
        }
    }
}
