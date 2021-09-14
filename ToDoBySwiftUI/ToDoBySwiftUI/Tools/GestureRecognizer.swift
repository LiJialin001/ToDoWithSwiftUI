//
//  GestureRecognizer.swift
//  GestureRecognizer
//
//  Created by 李佳林 on 2021/8/14.
//

import Foundation
import UIKit


//MARK: - hide keyboard on press outside

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
