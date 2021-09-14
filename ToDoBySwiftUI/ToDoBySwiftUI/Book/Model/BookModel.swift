//
//  BookModel.swift
//  BookModel
//
//  Created by 李佳林 on 2021/8/15.
//

import Foundation
import SwiftUI

struct BookItem: Identifiable, Equatable, Codable {
    var id = UUID()
    var title: String
    var substance: String
    var eidtDate = Date()
    var textImages: [String] = [""]
    var Team: TeamItem?
    var isTeams = false
}


struct BookItemRow: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var databaseBook: BookStore
    var item: BookItem
    
    func getCNDateMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Text(item.title)
                    .font(.body)
                if item.isTeams {
                    Image(systemName: "person.3")
                        .font(.system(size: 10))
                }
            }
            
            HStack(spacing:0){
                Text(getCNDateMD(Cdate: item.eidtDate))
                    .font(.footnote)
                    .frame(width: 70, height: 8)
                Divider()
                Text("内容：\(item.substance)")
                    .font(.footnote)
                    .frame(width: 200, height: 1,alignment: .leading)
                    .lineLimit(200)
             //       .padding()
                Spacer()
                
            }
        }
    }
    
}


class BookStore: ObservableObject {
    @Published var Books: [BookItem] = []{
        didSet {
            if let data = try? JSONEncoder().encode(Books){
                UserDefaults.standard.set(data, forKey: "Book")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Book") {
            if let Books = try? JSONDecoder().decode([BookItem].self, from: data){
                self.Books = Books
            }
        }
    }
}
