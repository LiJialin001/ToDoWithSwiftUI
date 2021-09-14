//
//  NetManager.swift
//  NetManager
//
//  Created by 李佳林 on 2021/9/10.
//

import Foundation
import SwiftUI

struct LoignOutResult: Codable {
    var message: String
    var code: Int
}

class NetworkManagerLoignOut: ObservableObject {
    @Published var loignOutResult = LoignOutResult(message: "",  code: 404)
    @EnvironmentObject var database: UserStore

    func placeOrder() {
        let url = URL(string: "http://42.193.115.210:8080/api/logout")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: request){ (data, response, error) in
            if error == nil {
                let decoder = JSONDecoder()
                if let safeData = data{
                    do{
                        let results = try decoder.decode(LoignOutResult.self, from: safeData)
                        DispatchQueue.main.async { [self] in
                            self.loignOutResult = results
                            print(results)
                            print(self.loignOutResult)
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

//MARK: - unused
//
//
//struct LoignOrder: Codable {
//    var account: String
//    var password: String
//}
//
//
//class Order: ObservableObject, Codable {
//    @Published var account: String
//    @Published var password: String
//    enum CodingKeys: CodingKey {
//        case account, password
//    }
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(account, forKey: .account)
//        try container.encode(password, forKey: .password)
//    }
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        account = try container.decode(String.self, forKey: .account)
//        password = try container.decode(String.self, forKey: .password)
//    }
//    init() {
//        account = "3020234369"
//        password = "lin12914"
//    }
//}


