//
//  TeamModle.swift
//  To-Do项目
//
//  Created by 李佳林 on 2021/8/11.
//

import SwiftUI
import Combine


struct TeamItem: Identifiable, Equatable, Codable {
    var id = UUID()
    var name: String
    var synopsis: String
    var isMyTeam: Bool
    var theBoss: String
    var theFollowers = [String]()
}

struct TeamRowForJoin: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var teamdatabase: TeamStore
    @EnvironmentObject var database: ToDoStore
    @EnvironmentObject var databaseMessage: MessageStore
    var item: TeamItem
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                if editMode?.wrappedValue != .active{
                    Text(item.name)
                }
                Spacer()
                if TeamsToDoNotComplete.count != 0 {
                    Text("\(TeamsToDoNotComplete.count)个待办未完成")
                        .font(.footnote)
                } else {
                    HStack(spacing:5){
                        Text("待办均已完成")
                        Image(systemName: "checkmark.circle.fill")
                    }
                    .font(.footnote)
                }
            }
            .padding()
            Spacer()
            
            
//            if TeamNotReadMessage.count != 0 {
//                Button(action: {}, label: {
//                    Image(systemName: "bell")
//                        .font(.title)
//                })
//                .padding()
//                .overlay(
//
//                    Text("\(TeamNotReadMessage.count)")
//                        .font(.caption)
//                        .fontWeight(.heavy)
//                        .frame(width: 20, height: 20)
//                        .background(TeamNotReadMessage.count > 0 ? Color.red : Color(UIColor.clear))
//                        .clipShape(Circle())
//                        .offset(x: 10, y: -12)
//                )
//            }
        }
    }
    
    var TeamsToDoNotComplete: [ToDoItem] {
        return database.ToDos.filter{
            $0.Team == item && !$0.isCompleted
        }
    }
    var TeamNotReadMessage: [MessageItem] {
        return databaseMessage.Messages.filter{
            $0.itsTeam == item && !$0.isRead
        }
    }
}

struct TeamRowForCrate: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var teamdatabase: TeamStore
    @EnvironmentObject var database: ToDoStore
    var item: TeamItem
    var body: some View {
        HStack{
            VStack(alignment:.leading){
                if editMode?.wrappedValue != .active{
                    Text(item.name)
                }
                Spacer()
                Text("\(TeamsToDo.count)个待办正在进行")
                    .font(.footnote)
            }
            .padding()
            Spacer()
            Text("\(item.theFollowers.count)个成员")
                .padding()
        }
    }
    var TeamsToDo: [ToDoItem] {
        return database.ToDos.filter{
            $0.Team == item
        }
    }
}


class TeamStore: ObservableObject {
    @Published var Teams: [TeamItem] = []{
        didSet {
            if let data = try? JSONEncoder().encode(Teams){
                UserDefaults.standard.set(data, forKey: "Team")
            }
        }
    }
    init() {
        if let Teamdata = UserDefaults.standard.data(forKey: "Team") {
            if let Teams = try? JSONDecoder().decode([TeamItem].self, from: Teamdata){
                self.Teams = Teams
            }
        }
    }
}


