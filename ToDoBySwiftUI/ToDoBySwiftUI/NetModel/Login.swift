//
//  Login.swift
//  Login
//
//  Created by 李佳林 on 2021/9/12.
//

import Foundation

struct LgLoginManager {
    static func LoginPost(account: String, password: String, completion: @escaping (Result<AccountInfo, OrdinaryMessage>) -> Void) {
        Network.fetch(
            "http://42.193.115.210:8080/api/login",
            method: .post,
            body: [
                "account": account,
                "password": password
            ]
        ) {
            result in
            switch result {
            case .success(let(data, _)):
                guard let accountInfo = try? JSONDecoder().decode(AccountInfo.self, from: data) else {
                    let wrongMessage = try? JSONDecoder().decode(OrdinaryMessage.self, from: data)
                    completion(.failure(wrongMessage ?? OrdinaryMessage(errorCode: 404, message: "请求异常", result: nil)))
                    return
                }
                switch accountInfo.code {
                case 0:
                    completion(.success(accountInfo))
                case 40001:
                    completion(.failure(OrdinaryMessage(errorCode: 404, message: "未登陆或登陆失效，请重新登陆", result: nil)))
                case 40002:
                    completion(.failure(OrdinaryMessage(errorCode: 404, message: "该用户不存在", result: nil)))
                case 40003:
                    completion(.failure(OrdinaryMessage(errorCode: 404, message: "用户名或密码错误", result: nil)))
                case 50001:
                    completion(.failure(OrdinaryMessage(errorCode: 404, message: "服务器错误", result: nil)))
                default:
                    completion(.failure( OrdinaryMessage(errorCode: 404, message: "网络问题", result: nil)))
                }
            case .failure(_):
                completion(.failure(OrdinaryMessage(errorCode: 404, message: "网络异常", result: nil)))
            }
        }
    }
}

struct AccountInfo: Codable {
    let message: String
    let result: AccountResult
    let code: Int
//    enum CodingKeys: String, CodingKey {
//        case code = "error_code"
//        case message, result
//    }
}

// MARK: - AccountResult
struct AccountResult: Codable {
    let userNumber:String
    var nickname: String
    var telephone: String?
    var email: String?
    let token, role, realname: String
    let gender, department, major, stuType: String
    let avatar, campus: String
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    func hash(into hasher: inout Hasher) {
        return
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - OrdinaryMessage
struct OrdinaryMessage: Codable, Error {
    let errorCode: Int
    let message: String
    let result: JSONNull?

    enum CodingKeys: String, CodingKey {
        case errorCode = "error_code"
        case message, result
    }
}


