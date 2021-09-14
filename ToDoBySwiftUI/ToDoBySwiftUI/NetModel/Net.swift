//
//  Net.swift
//  Net
//
//  Created by 李佳林 on 2021/9/12.
//

import SwiftUI

struct Network {
    enum Failure: Error, Equatable, Hashable {
        case urlError, requestFailed, loginFailed, unknownError, alreadyLogin, usorpwWrong, captchaWrong
        case custom(String)

        private static let pair: [Failure: Localizable] = [
            .urlError: .urlError,
            .requestFailed: .requestFailed,
            .loginFailed: .loginFailed,
            .unknownError: .unknownError,
            .alreadyLogin: .alreadyLogin,
            .usorpwWrong: .usorpwWrong,
            .captchaWrong: .captchaWrong,
        ]

        var localizedStringKey: LocalizedStringKey {
            Failure.pair[self]?.rawValue ?? ""
        }

    }

    enum Method: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }

    static func fetch(
        _ urlString: String,
        query: [String: String] = [:],
        headers: [String: String] = [:],
        method: Method = .get,
        body: [String: Any] = [:],
        async: Bool = true,
        completion: @escaping (Result<(Data, HTTPURLResponse), Failure>) -> Void
    ) {
            guard let url = URL(string: urlString) else {
            completion(.failure(.urlError))
            return
        }

        var requestURL: URL
        if query.isEmpty {
            requestURL = url
        } else {
            var comps = URLComponents(url: url, resolvingAgainstBaseURL: true)!
            comps.queryItems = comps.queryItems ?? []
            comps.queryItems!.append(contentsOf: query.map { URLQueryItem(name: $0.0, value: $0.1) })
            requestURL = comps.url!
        }

        var request = URLRequest(url: requestURL)
        if !headers.isEmpty {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }

        request.httpMethod = method.rawValue

        request.httpBody = body.percentEncoded()

//MARK: - Request
        URLSession.shared.dataTask(with: request) { data, response, error in
            func process() {
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    print(error?.localizedDescription ?? "Unknown Error")
                    completion(.failure(.requestFailed))
                    return
                }
                completion(.success((data, response)))

                guard let url = response.url, let headers = response.allHeaderFields as? [String: String] else {
                    completion(.failure(.requestFailed))
                    return
                }
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: headers, for: url)
                HTTPCookieStorage.shared.setCookies(cookies, for: url, mainDocumentURL: nil)
                for cookie in cookies {
                    var cookieProperties = [HTTPCookiePropertyKey: Any]()
                    cookieProperties[.name] = cookie.name
                    cookieProperties[.value] = cookie.value
                    cookieProperties[.domain] = cookie.domain
                    cookieProperties[.path] = cookie.path
                    cookieProperties[.version] = cookie.version
                    cookieProperties[.expires] = Date().addingTimeInterval(31536000)

                    if let newCookie = HTTPCookie(properties: cookieProperties) {
                        HTTPCookieStorage.shared.setCookie(newCookie)
                    }
                }
            }

            if async {
                DispatchQueue.main.async {
                    process()
                }
            } else {
                process()
            }
        }.resume()
    }
}

extension Data{

    mutating func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension Network.Failure: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .custom(let desc):
                return desc
            default: return self.localizedStringKey.stringValue()
        }
    }
}

