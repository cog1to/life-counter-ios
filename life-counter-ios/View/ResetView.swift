//
//  ResetView.swift
//  life-counter-ios
//
//  Created by Alexander on 25.08.25.
//

import SwiftUI

struct ResetView: View {
    @State var pressed: Bool = false

    var onTap: () -> ()
    var onCancel: () -> ()

    let image: ImageResource = {
        if #available(iOS 16.0, *) {
            return .resetButtonLight
        } else {
            return .resetButtonDark
        }
    }()

    var body: some View {
        GeometryReader { metrics in
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            if !pressed {
                                pressed = true
                                onTap()
                            }
                        }
                        .onEnded { _ in
                            if pressed {
                                pressed = false
                                onCancel()
                            }
                        }
                )
                .overlay(
                    Rectangle()
                        .fill(pressed ? .controlBackground : .clear)
                        .cornerRadius(metrics.size.height / 2.0)
                )
                .position(x: metrics.size.width / 2.0, y: metrics.size.height / 2.0)
        }.padding(EdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0))
    }
}
