//
//  ContentView.swift
//  To-Do项目
//
//  Created by 李佳林 on 2021/7/19.
//

import SwiftUI


struct ToDoView: View {
//    @EnvironmentObject var quickActionSettings: QuickActionSettings

    
    var body: some View {
        ZStack{
            VStack{
                TabView{
                    ToDoList()
                     .tabItem {
                        Image(systemName: "tray.full")
                        Text("我的待办")
                      }
                    MyTeam()
                         .tabItem {
                            Image(systemName: "paperplane")
                            Text("我的团队")
                          }
                    MeBook()
                        .tabItem {
                            Image(systemName: "square.and.pencil")
                            Text("备忘录")
                        }
                    MyCenter()
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                            Text("个人中心")
                        }
                }
            }
                
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoView()
            .environmentObject(ToDoStore())
            .environmentObject(TeamStore())
            .environmentObject(BookStore())
            .environmentObject(MessageStore())
        //    .environmentObject(quickActionSettings)
    }
}

/*struct QuickActionModel : Identifiable {
    let id = UUID()
    let name: String
    let tag: QuickActionSettings.QuickAction
}


let allQuickActions = [
    QuickActionModel(name: "待办DDL", tag: .details(name: "待办DDL")),
    QuickActionModel(name: "团队",tag: .details(name: "团队")),
    QuickActionModel(name: "备忘录", tag: .details(name: "备忘录")),
    QuickActionModel(name: "消息", tag: .details(name: "消息")),
]
*/
