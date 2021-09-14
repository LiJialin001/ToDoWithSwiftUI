//
//  BottomPopupView.swift
//  BottomPopupView
//
//  Created by 李佳林 on 2021/8/29.
//

import Foundation
import SwiftUI

struct BottomPopupView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                if colorScheme == .dark {
                    content()
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                        .background(Color.black)
                        .cornerRadius(radius: 16, corners: [.topLeft, .topRight])
                }else {
                    content()
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                        .background(Color.white)
                        .cornerRadius(radius: 16, corners: [.topLeft, .topRight])
                }
            }
            .edgesIgnoringSafeArea([.bottom])
        }
        .animation(.easeOut)
        .transition(.move(edge: .bottom))
    }
}


struct shakePopupView<Content: View>: View {
    @Environment(\.colorScheme) var colorScheme
    @ViewBuilder var content: () -> Content
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                if colorScheme == .dark {
                    content()
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                        .background(Color.black)
                        .cornerRadius(radius: 16)
                }else {
                    content()
                        .padding(.bottom, geometry.safeAreaInsets.bottom)
                        .background(Color.white)
                        .cornerRadius(radius: 16)
                }
            }
            .edgesIgnoringSafeArea([.bottom])
        }
        .animation(.easeOut)
        .transition(.move(edge: .bottom))
    }
}

