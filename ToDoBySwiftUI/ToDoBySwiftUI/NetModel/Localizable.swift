//
//  Localizable.swift
//  Localizable
//
//  Created by 李佳林 on 2021/9/12.
//
import SwiftUI

enum Localizable: LocalizedStringKey, CaseIterable {
    case urlError, requestFailed, loginFailed, unknownError, alreadyLogin, usorpwWrong, captchaWrong
}

extension LocalizedStringKey {
    var stringKey: String {
        let description = "\(self)"

        let components = description.components(separatedBy: "key: \"")
            .map { $0.components(separatedBy: "\",") }

        return components[1][0]
    }
}

extension String {
    static func localizedString(for key: String,
                                locale: Locale = .current) -> String {
        
        let language = locale.languageCode
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj") else {
            return ""
        }
        guard let bundle = Bundle(path: path) else {
            return ""
        }
        let localizedString = NSLocalizedString(key, bundle: bundle, comment: "")
        
        return localizedString
    }
}


extension LocalizedStringKey {
    func stringValue(locale: Locale = .current) -> String {
        return .localizedString(for: self.stringKey, locale: locale)
    }
}
