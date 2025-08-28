//
//  ControlView.swift
//  life-counter-ios
//
//  Created by Alexander on 24.08.25.
//

import SwiftUI

enum EventType {
    case minus
    case plus
}

enum ControlType {
    case down
    case up
}

struct ControlView: View {
    @EnvironmentObject var model: LifeTotalModel
    @State var pressed: EventType? = nil

    var type: ControlType
    var path: KeyPath<LifeTotalModel, [Digit]>

    var body: some View {
        ZStack {
            Image(.buttonTexture)
                .resizable(
                    capInsets: .init(
                        top: 0,
                        leading: 0,
                        bottom: 0,
                        trailing: 0
                    ),
                    resizingMode: .stretch
                )
            VStack(spacing: 0.0) {
                TotalView(model: model, path: path)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.darkerGray, width: 1.0)
                    .background(
                        LinearGradient(
                            colors: [.metalGradientStart, .metalGradientMid],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        ignoresSafeAreaEdges: []
                    )

                HStack(spacing: 0.0) {
                    CompatibleText(text: "－")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        LinearGradient(
                            colors: [.metalGradientMid, .metalGradientEnd],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        ignoresSafeAreaEdges: []
                    )
                    .border(.darkerGray, width: 1.0)
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                if pressed == nil {
                                    pressed = .minus
                                    model.onEventStarted(control: self.type, event: .minus)
                                }
                            }
                            .onEnded { _ in
                                if pressed == .minus {
                                    pressed = nil
                                    model.onEventEnded(control: self.type, event: .minus)
                                }
                            }
                    )
                    .overlay(pressed == .minus ? .controlBackground : .clear)

                    CompatibleText(text: "＋")                       
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .border(.darkerGray, width: 1.0)
                    .background(
                        LinearGradient(
                            colors: [.metalGradientMid, .metalGradientEnd],
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        ignoresSafeAreaEdges: []
                    )
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { _ in
                                if pressed == nil {
                                    pressed = .plus
                                    model.onEventStarted(control: self.type, event: .plus)
                                }
                            }
                            .onEnded { _ in
                                if pressed == .plus {
                                    pressed = nil
                                    model.onEventEnded(control: self.type, event: .plus)
                                }
                            }
                    )
                    .overlay(pressed == .plus ? .controlBackground : .clear)
                }
                .frame(maxHeight: .infinity)
            }
        }
        .cornerRadius(24)
    }
}

//struct ControlView_Preview: PreviewProvider {
//    static var previews: some View {
//        ControlView(value: 0, type: .down).previewLayout(.fixed(width: 400, height: 200))
//    }
//}
