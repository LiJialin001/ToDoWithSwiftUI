//
//  PopupModifier.swift
//  PopupModifier
//
//  Created by 李佳林 on 2021/8/29.
//

import Foundation
import SwiftUI

struct OverlayModifier<OverlayView: View>: ViewModifier {
    
    @Binding var isPresented: Bool
    @ViewBuilder var overlayView: () -> OverlayView
    
    init(isPresented: Binding<Bool>, @ViewBuilder overlayView: @escaping () -> OverlayView) {
        self._isPresented = isPresented
        self.overlayView = overlayView
    }
    
    func body(content: Content) -> some View {
        content.overlay(isPresented ? overlayView() : nil)
    }
}

extension View {
    
    func popup<OverlayView: View>(isPresented: Binding<Bool>,
                                  blurRadius: CGFloat = 3,
                                  blurAnimation: Animation? = .linear,
                                  @ViewBuilder overlayView: @escaping () -> OverlayView) -> some View {
        return blur(radius: isPresented.wrappedValue ? blurRadius : 0)
            .animation(blurAnimation)
            .allowsHitTesting(!isPresented.wrappedValue)
            .modifier(OverlayModifier(isPresented: isPresented, overlayView: overlayView))
    }
}
