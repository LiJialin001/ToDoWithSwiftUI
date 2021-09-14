//
//  userModel.swift
//  userModel
//
//  Created by 李佳林 on 2021/8/2.
//

import SwiftUI

struct UserItem: Identifiable, Equatable, Codable {
    var id = UUID()
    var name: String
    var StudentNumber: String
    var Password: String
    var textImages: String = ""
}

class UserStore: ObservableObject {
    @Published var Users: [UserItem] = []{
        didSet {
            if let data = try? JSONEncoder().encode(Users){
                UserDefaults.standard.set(data, forKey: "User")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "User") {
            if let Users = try? JSONDecoder().decode([UserItem].self, from: data){
                self.Users = Users
            }
        }
    }
}
