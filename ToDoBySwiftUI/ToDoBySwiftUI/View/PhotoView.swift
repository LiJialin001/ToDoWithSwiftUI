//
//  PhotoView.swift
//  PhotoView
//
//  Created by 李佳林 on 2021/8/18.
//

import Foundation
import SwiftUI


struct PhotoView: View {
    var image: Image
    var body: some View{
        image
            .resizable()
            .scaledToFit()
    }
}
