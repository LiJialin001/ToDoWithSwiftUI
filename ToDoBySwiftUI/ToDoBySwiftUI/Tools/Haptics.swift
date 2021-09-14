//
//  Haptics.swift
//  Haptics
//
//  Created by 李佳林 on 2021/8/13.
//

import Foundation
import SwiftUI

struct Haptics {
    static func giveHaptic() {
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
           
    }
    
    static func giveSmallHaptic() {
        let impactMed = UIImpactFeedbackGenerator(style: .light)
            impactMed.impactOccurred()
           
    }
    
    static func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    

}
