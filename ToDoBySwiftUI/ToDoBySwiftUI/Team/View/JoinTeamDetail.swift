//
//  JionTeamDetail.swift
//  JionTeamDetail
//
//  Created by 李佳林 on 2021/8/21.
//

import Foundation
import SwiftUI

struct JoinTeamDetailView: View {
    @EnvironmentObject var databaseTeam: TeamStore
    @EnvironmentObject var database: ToDoStore
    @EnvironmentObject var databaseMessage: MessageStore
    @Environment(\.presentationMode) var presentation
    @State var editMode: EditMode = .inactive
    @State var DetailItem: TeamItem
    @State var whatItem = "待办"
    @State var whatToDo = ""
    @State var isToDoItem = true
    @State var isTeamDetail = false
    
    var Item: TeamItem
    
    var body: some View {
        ZStack{
   //         NavigationView{
                ZStack{
                    VStack{
                        HStack(spacing:10){
                            Text(DetailItem.name)
                                .font(.system(size: 20))
                                .padding()
                            Spacer()
                            Menu(content: {
                                Button(action: {
                                    whatItem = "待办"
                                    isTeamDetail = false
                                    isToDoItem = true
                                }, label: {
                                    Text("显示待办")
                                })
                                Button(action: {
                                    whatItem = "消息"
                                    isToDoItem = false
                                    isTeamDetail = false
                                }, label: {
                                    Text("显示消息")
                                })
                        }){
                            Label(title: {}) {
                                    Text(whatItem)
                            }
                          }
                        .padding()
                            Menu(content: {
                                Button(action: {
                                    isToDoItem = false
                                    isTeamDetail = true
                                }, label: {
                                    Text("团队详情")
                                })
                                Button(action: {
                                 //   isToDoItem = false
                                }, label: {
                                    Text("退出团队")
                                })
                        }){
                            Label(title: {}) {
                                Image(systemName: "line.horizontal.3.decrease")
                                    .font(.title)
                            }
                          }
                        .padding()
                    }
                        
                        if isToDoItem{
                            List{
                                Section(header:
                                    Text("未完成")
                                ){
                                    ForEach(NotCompletedItems){ item in
                                        ToDoItemRow(item: item)
                                            .environment(\.editMode, self.$editMode)
                                    }
                                }
                                Section(header:
                                            Text("已完成")
                                ){
                                    ForEach(CompletedItems){ item in
                                        ToDoItemRow(item: item)
                                            .environment(\.editMode, self.$editMode)
                                    }
                                }
                                                                
                                
                            }
                            .navigationBarTitleDisplayMode(.inline)
                        }
                        else if isTeamDetail{
                            TeamDetailView(item: DetailItem)
                        }
                        else{
                            List{
                                ForEach(MessageOfTeam){ item in
                                    NavigationLink(destination: MessageDetailView(item: item)){
                                        MessageRow(DetailItem: item, item: item)
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                }
            }
  //      }
      }
    
}
    var NotCompletedItems: [ToDoItem] {
        return database.ToDos.filter{
            $0.Team == DetailItem && !$0.isCompleted
        }
    }
    
    var CompletedItems: [ToDoItem] {
        return database.ToDos.filter{
            $0.Team == DetailItem && $0.isCompleted
        }
    }
    var MessageOfTeam: [MessageItem] {
        return databaseMessage.Messages.filter{
            $0.itsTeam == DetailItem
        }
    }
    
    
}



struct JoinTeamDetail_Previews: PreviewProvider {
    static var previews: some View {
        JoinTeamDetailView(DetailItem: TeamItem(name: "TeamText", synopsis: "kjhiugufufhohgiyfyfuf",  isMyTeam: false, theBoss: "Boss"), Item: TeamItem(name: "TeamText", synopsis: "kjhiugufufhohgiyfyfuf", isMyTeam: false, theBoss: "Boss"))
       //     .environmentObject(ToDoStore())
    }
}

