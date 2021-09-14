//
//  OutlookView.swift
//  OutlookView
//
//  Created by 李佳林 on 2021/9/2.
//

import Foundation
import SwiftUI


struct CodeScannerView: View {
    @Binding var isShowingScanner: Bool
    var codeTypes: Array<CIQRCodeDescriptor>
    var simulatedData: String
    
    enum ScanError: Error {
        case overflow
        case invalidInput(Character)
    }
 //   var ScanError: Error
    func completion(result: Result<String, Error>) {
        isShowingScanner = false
    }
    var body: some View {
        ZStack {
            
        }
    }
}

