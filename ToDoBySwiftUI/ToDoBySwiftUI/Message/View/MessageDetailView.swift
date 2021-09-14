//
//  MessageDetailView.swift
//  MessageDetailView
//
//  Created by 李佳林 on 2021/8/22.
//

import Foundation
import SwiftUI


struct MessageDetailView: View {
    @EnvironmentObject var databaseMessage: MessageStore
    @EnvironmentObject var databaseBook: BookStore
    @State var item: MessageItem
    @Environment(\.presentationMode) var presentation
    @State var editMode: EditMode = .inactive
    @State var showAlert = false
    
    
    func getCNDateMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    
    var body: some View {
        
        VStack(alignment: .leading){
            VStack(alignment: .leading, spacing: 5){
                Text(item.title)
                    .font(.title)
                Text("团队：\(item.itsTeam.name)")
                Text(getCNDateMD(Cdate:item.date))
                    .font(.footnote)
            }
            .padding()
            
            Text("\(item.mainMessage)")
                .font(.body)
                .frame(width: 280, alignment: .center)
                .padding()
            
            Spacer()

            
            if #available(iOS 15.0, *) {
                Button(action: {
                    Haptics.simpleSuccess()
                    showAlert = true
                    self.databaseBook.Books.append(BookItem(title: self.item.title,substance: self.item.mainMessage,eidtDate: Date(),textImages: [""],Team: item.itsTeam ,isTeams: true ))
                }, label: {
                    HStack {
                        Text("添加到备忘录")
                        Image(systemName: "bookmark.circle")
                    }
                    .frame(maxWidth: .infinity)
                })
                    .buttonStyle(BorderedButtonStyle(shape: .roundedRectangle))
                    .tint(.indigo)
                    .controlProminence(.increased)
                    .controlSize(.large)
                    .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                    .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                    .padding()
            } else {
                // Fallback on earlier versions
            }
        }
        .alertDialog(show: $showAlert,duration: 1){
            AlertToast(type: .complete(Color.green), title: "已添加")
        }
        .onDisappear{
            self.databaseMessage.Messages[self.databaseMessage.Messages.firstIndex(of: self.item)!].isRead = true
        }
    }
}
