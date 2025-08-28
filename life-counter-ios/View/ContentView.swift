//
//  ContentView.swift
//  life-counter-ios
//
//  Created by Alexander on 24.08.25.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: LifeTotalModel

    var body: some View {
        GeometryReader { metrics in
            ZStack {
                Image("BackgroundTile")
                    .resizable(
                        capInsets: .init(
                            top: 0,
                            leading: 0,
                            bottom: 0,
                            trailing: 0
                        ),
                        resizingMode: .tile
                    )
                    .ignoresSafeArea()
                VStack {
                    ControlView(type: .up, path: \.playerUpDigits)
                        .frame(
                            width: metrics.size.width * 0.97,
                            height: metrics.size.height * 0.40
                        )
                        .rotationEffect(.degrees(180))

                    ResetView(
                        onTap: model.onReset,
                        onCancel: model.onResetCancel
                    )

                    ControlView(type: .down, path: \.playerDownDigits)
                        .frame(
                            width: metrics.size.width * 0.97,
                            height: metrics.size.height * 0.40
                        )
                }
                .padding(
                    EdgeInsets(top: 12, leading: 0, bottom: 12, trailing: 0)
                )

            }
        }
    }
}

#Preview {
    ContentView().environmentObject(LifeTotalModel())
}
