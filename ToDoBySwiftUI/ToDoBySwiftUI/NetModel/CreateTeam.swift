//
//  CreateTeam.swift
//  CreateTeam
//
//  Created by 李佳林 on 2021/9/13.
//

import Foundation

struct CreateTeamManager {
    static func TeamPost(teamName:String,teamDescription:String,completion: @escaping (Result<TeamInfo, OrdinaryMessage>) -> Void) {
        Network.fetch(
            "http://42.193.115.210:8080/api/team",
            method: .post,
            body: [
                "teamName": teamName,
                "teamDescription": teamDescription
            ]
        ) {
            result in
            switch result {
            case .success(let(data, _)):
                guard let teamInfo = try?
                        JSONDecoder().decode(TeamInfo.self, from: data) else {
                            print(data)
                            let wrongMessage = try? JSONDecoder().decode(OrdinaryMessage.self, from: data)
                            completion(.failure(wrongMessage ?? OrdinaryMessage(errorCode: 404, message: "请求异常", result: nil)))
                            return
                        }
                switch teamInfo.code {
                case 0:
                    completion(.success(teamInfo))
                case 30001:
                    completion(.failure(OrdinaryMessage(errorCode: 404, message: "团队名称已存在", result: nil)))
                case 40001:
                    completion(.failure(OrdinaryMessage(errorCode: 404, message: "未登录", result: nil)))
                case 50001:
                    completion(.failure(OrdinaryMessage(errorCode: 404, message: "服务器错误", result: nil)))
                default:
                    print(teamInfo.code)
                    completion(.failure( OrdinaryMessage(errorCode: 404, message: "网络问题", result: nil)))
                }
            case .failure(_):
                completion(.failure(OrdinaryMessage(errorCode: 404, message: "网络异常", result: nil)))
            }
        }
    }
}

//MARK: - TeamInfo

struct TeamInfo: Codable {
    
    let message: String
//    let result: String
    let code: Int
}
