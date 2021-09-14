//
//  MessageView.swift
//  To-Do项目
//
//  Created by 李佳林 on 2021/8/13.
//

import SwiftUI

struct MessageView: View {
    @EnvironmentObject var databaseMessage: MessageStore
    @State var editMode: EditMode = .inactive
    @Binding var messagesOpen: Bool
    
    
    var body: some View {
        NavigationView{
            VStack{
                HStack{
                    Button(action: {
                        for Item in databaseMessage.Messages {
                            self.databaseMessage.Messages[self.databaseMessage.Messages.firstIndex(of: Item) ?? 0].isRead = true
                        }
                    }){
                        Text("全部已读")
                    }
                    .padding()
                    Spacer()
                    Button(action:{
                        messagesOpen = false
                    }){
                        Image(systemName: "chevron.down")
                            .font(.title)
                    }
                    .padding()
                }
                List {
                    Section("未读"){
                        ForEach(databaseMessage.Messages.filter{!$0.isRead}){ item in
                            NavigationLink(destination: MessageDetailView(item: item)){
                                MessageRow(DetailItem: item, item: item)
                                    .environment(\.editMode, self.$editMode)
                            }
                        }
                        .onDelete { (indices) in
                            self.databaseMessage.Messages.remove(at: indices.first!)
                        }
                        .navigationBarTitle("消息", displayMode: .inline)
                    }
                    Section("已读"){
                        ForEach(databaseMessage.Messages.filter{$0.isRead}){ item in
                            NavigationLink(destination: MessageDetailView(item: item)){
                                MessageRow(DetailItem: item, item: item)
                                    .environment(\.editMode, self.$editMode)
                            }
                        }
                        .onDelete { (indices) in
                            self.databaseMessage.Messages.remove(at: indices.first!)
                        }
                        .navigationBarTitle("我的消息", displayMode: .inline)
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                Spacer()

            }
        }
        
    }
}
