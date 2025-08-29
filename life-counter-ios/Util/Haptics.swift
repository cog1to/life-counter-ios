//
//  Haptics.swift
//  life-counter-ios
//
//  Created by Alexander on 29.08.25.
//

import CoreHaptics
import UIKit

enum Strength: Float {
    case strong = 1.0
    case middle = 0.5
    case weak = 0.3
}

struct Haptics {
    var engine: CHHapticEngine?
    var generator: UIImpactFeedbackGenerator?

    init() {
        if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
            do {
                engine = try CHHapticEngine()
                try engine?.start()
            } catch {
                print("There was an error starting the haptic engine: \(error.localizedDescription)")
            }
        } else {
            generator = UIImpactFeedbackGenerator()
            generator?.prepare()
        }
    }

    func play(strength: Strength) {
        if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: strength.rawValue)
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: strength.rawValue)
            let event = CHHapticEvent(
                eventType: .hapticTransient,
                parameters: [intensity, sharpness],
                relativeTime: 0
            )

            do {
                let pattern = try CHHapticPattern(events: [event], parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: .zero)
            } catch {
                print("There was an error playing the haptic pattern: \(error.localizedDescription)")
            }
        } else {
            generator?.impactOccurred(intensity: CGFloat(strength.rawValue))
        }
    }
}
