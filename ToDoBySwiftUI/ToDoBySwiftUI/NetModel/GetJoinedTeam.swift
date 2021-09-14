//
//  GetJoinedTeam.swift
//  GetJoinedTeam
//
//  Created by 李佳林 on 2021/9/14.
//

import Foundation
import SwiftUI

struct JoinedTeam: Codable {
    var message: String
    var code: Int
    var result: [JoinedTeamResult]
}
    

struct JoinedTeamResult: Codable {
    var team_id: Int
    var team_name: String
    var team_description: String
    var team_owner_id: Int
    var created_time: String
    var updated_time: String
}

class GetJoinedTeamManager: ObservableObject {
    @Published var joinedTeam = JoinedTeam(message: "",  code: 404, result: [JoinedTeamResult(team_id: 0, team_name: "", team_description: "", team_owner_id: 0, created_time: "", updated_time: "")])

    func placeOrder() {
        let url = URL(string: "http://42.193.115.210:8080/api/team")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data{
                    do{
                        let results = try decoder.decode(JoinedTeam.self, from: safeData)
                        DispatchQueue.main.async { [self] in
                            self.joinedTeam = results
                            print(results)
                            print(self.joinedTeam)
                    }
                    }catch{
                        print(error)
                    }
                }
            }
      }
        task.resume()
    }

}

