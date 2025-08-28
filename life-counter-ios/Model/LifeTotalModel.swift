//
//  LifeTotalModel.swift
//  life-counter-ios
//
//  Created by Alexander on 26.08.25.
//

import SwiftUI

enum Digit: Int {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
}

class LifeTotalModel: ObservableObject {

    // MARK: State.

    private var playerUp: Int = 20 {
        didSet {
            playerUpDigits = Self.digitsFromNumber(playerUp)
        }
    }
    private var playerDown: Int = 20 {
        didSet {
            playerDownDigits = Self.digitsFromNumber(playerDown)
        }
    }

    @Published private(set) var playerUpDigits: [Digit]
    @Published private(set) var playerDownDigits: [Digit]

    // MARK: Timer state.

    var startTimer: Timer?
    var timer: Timer?
    var resetTimer: Timer?



    // MARK: Init.

    init() {
        playerUpDigits = Self.digitsFromNumber(playerUp)
        playerDownDigits = Self.digitsFromNumber(playerDown)
    }

    private static func digitsFromNumber(_ number: Int) -> [Digit] {
        var digits: [Digit] = []
        var counter = number
        while counter > 0 {
            digits.append(Digit(rawValue:counter % 10)!)
            counter /= 10
        }

        if digits.isEmpty {
            return [.zero]
        } else {
            return digits.reversed()
        }
    }

    // MARK: Timer manipulation.

    func onEventStarted(control: ControlType, event: EventType) {
        // Trigger immediately on first touch.
        tick(control: control, event: event)

        // Start triggering repeatedly after a delay.
        self.startTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            self?.tick(control: control, event: event)

            self?.timer = Timer.scheduledTimer(
                withTimeInterval: 0.1,
                repeats: true,
                block: { [weak self] _ in
                    self?.tick(control: control, event: event)
                }
            )
        }
    }

    func onReset() {
        // Wait for 1 sec before reset.
        self.resetTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { [weak self] _ in
            self?.playerDown = 20
            self?.playerUp = 20
        }
    }

    func onResetCancel() {
        self.resetTimer?.invalidate()
    }

    func onEventEnded(control: ControlType, event: EventType) {
        self.startTimer?.invalidate()
        self.timer?.invalidate()
    }

    // MARK: Helpers.

    private func tick(control: ControlType, event: EventType) {
        switch (control, event) {
        case (.down, .minus):
            playerDown = max(playerDown - 1, 0)
        case (.down, .plus):
            playerDown = min(playerDown + 1, 999)
        case (.up, .minus):
            playerUp = max(playerUp - 1, 0)
        case (.up, .plus):
            playerUp = min(playerUp + 1, 999)
        }
    }
}
