//
//  AddTeamMember.swift
//  AddTeamMember
//
//  Created by 李佳林 on 2021/9/14.
//

import Foundation

struct AddTeamMemberManager {
    static func
    AddTeamMemberPost
    (teamId:Int,userId:Int,completion: @escaping (Result<AddTeamMemberInfo, OrdinaryMessage>) -> Void) {
        Network.fetch(
            "http://42.193.115.210:8080/api/team/member",
            method: .post,
            body: [
                "teamId": teamId,
                "userId": userId
            ]
        ) {
            result in
            switch result {
            case .success(let(data, _)):
                guard let addTeamMemberInfo = try?
                        JSONDecoder().decode(AddTeamMemberInfo.self, from: data) else {
                            print(data)
                            let wrongMessage = try? JSONDecoder().decode(OrdinaryMessage.self, from: data)
                            completion(.failure(wrongMessage ?? OrdinaryMessage(errorCode: 404, message: "请求异常", result: nil)))
                            return
                        }
                switch addTeamMemberInfo.code {
                case 0:
                    completion(.success(addTeamMemberInfo))
                case 30002:
                    completion(.failure(OrdinaryMessage(errorCode: 404, message: "没有权限", result: nil)))
                case 40001:
                    completion(.failure(OrdinaryMessage(errorCode: 404, message: "未登录", result: nil)))
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

struct AddTeamMemberInfo: Codable {
    
    let message: String
    let result: String
    let code: Int
}
