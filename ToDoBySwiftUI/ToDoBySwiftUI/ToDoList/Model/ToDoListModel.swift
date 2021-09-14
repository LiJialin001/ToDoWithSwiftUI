//
//  List.swift
//  To-Do项目
//
//  Created by 李佳林 on 2021/7/24.
//

import SwiftUI
import Combine


struct ToDoItem: Identifiable, Equatable, Codable {
    var id = UUID()
    var title: String = "New Item"
    var priorityLevel: Int = 0
    var classification: Int = 0
    var date: Date = Date()
    var lastDate: Date = Date()
    var isCompleted = false
    var isOverTime = false
    var isPersonal = true
    var isLoop = false
    var isStop = true
    var cyclePeriod = 2
    var Team: TeamItem?
}
var classifyName = ["无分类", "学习", "生活", "娱乐", "工作"]

struct ToDoItemRow: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var database: ToDoStore
    var item: ToDoItem
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    func simpleFalse() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    func getCNDateYMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    
    var body: some View {
        ZStack{
        VStack(alignment: .leading){
            HStack {
                if editMode?.wrappedValue != .active{
                    if !item.isLoop {
                        Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                            .font(.system(size: 25))
                            .foregroundColor(item.isCompleted ? .gray : .primary)
                            .onTapGesture {
                                Haptics.simpleSuccess()
                                self.database.ToDos[self.database.ToDos.firstIndex(of: self.item)!].isCompleted.toggle()
                            }
                    }
                    else {
                        if item.isStop{
                            Image(systemName: item.date<item.lastDate ? "circle" : "checkmark.circle.fill")
                                .imageScale(.large)
                                .foregroundColor(item.date<item.lastDate ? .primary : .gray)
                                .onTapGesture {
                                    Haptics.simpleSuccess()
                                    if item.cyclePeriod==1 && item.date<item.lastDate {
                                        self.database.ToDos[self.database.ToDos.firstIndex(of: self.item)!].date = Calendar.current.date(byAdding: .day, value: 1, to: item.date)!
                                    }
                                    else if item.cyclePeriod==2 && item.date<item.lastDate {
                                        self.database.ToDos[self.database.ToDos.firstIndex(of: self.item)!].date = Calendar.current.date(byAdding: .day, value: 7, to: item.date)!
                                    }
                                    else if item.cyclePeriod==3 && item.date<item.lastDate{
                                        self.database.ToDos[self.database.ToDos.firstIndex(of: self.item)!].date = Calendar.current.date(byAdding: .month, value: 1, to: item.date)!
                                    }
                                    if item.date>=item.lastDate {
                                        self.database.ToDos[self.database.ToDos.firstIndex(of: self.item)!].isCompleted.toggle()
                                    }
                                }
                                .onTapGesture (perform: item.date>item.lastDate ? simpleFalse : simpleSuccess)
                        }
                        else{
                            Image(systemName: "circle")
                                .font(.system(size: 30))
                                .foregroundColor(.primary)
                                .onTapGesture {
                                    Haptics.simpleSuccess()
                                    if item.cyclePeriod==1 {
                                        self.database.ToDos[self.database.ToDos.firstIndex(of: self.item)!].date = Calendar.current.date(byAdding: .day, value: 1, to: item.date)!
                                    }
                                    else if item.cyclePeriod==2 {
                                        self.database.ToDos[self.database.ToDos.firstIndex(of: self.item)!].date = Calendar.current.date(byAdding: .day, value: 7, to: item.date)!
                                    }
                                    else {
                                        self.database.ToDos[self.database.ToDos.firstIndex(of: self.item)!].date = Calendar.current.date(byAdding: .month, value: 1, to: item.date)!
                                    }
                                }
                                
                                .onTapGesture (perform: simpleSuccess)
                        }
                    }
                    
                }
                VStack{
                    HStack{
                        if !item.isLoop {
                            if item.isCompleted{
                                Text(item.title)
                                    .foregroundColor(.gray)
                                    .strikethrough()
                            }else {
                                Text(item.title)
                            }
                        }else {
                            if !item.isStop {
                                Text(item.title)
                            } else {
                                if item.date >= item.lastDate {
                                    Text(item.title)
                                        .foregroundColor(.gray)
                                        .strikethrough()
                                } else {
                                    Text(item.title)
                                }
                            }
                        }
                        Spacer()
                    }
                    
                    
                    HStack{
                        if !item.isLoop {
                            if item.isCompleted {
                                Text(classifyName[item.classification])
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }else{
                                Text(classifyName[item.classification])
                                    .font(.footnote)
                            }
                        } else {
                            if item.isStop {
                                if item.date<item.lastDate {
                                    Text(classifyName[item.classification])
                                        .font(.footnote)
                                } else{
                                    Text(classifyName[item.classification])
                                        .font(.footnote)
                                        .foregroundColor(Color.gray)
                                }
                            } else {
                                Text(classifyName[item.classification])
                                    .font(.footnote)
                            }
                        }
                            
                        if item.isCompleted {
                            Text(getCNDateYMD(Cdate: item.date))
                                .font(.footnote)
                                .foregroundColor(.gray)
                        }else {
                            if item.date<Date() {
                                Text(getCNDateYMD(Cdate: item.date))
                                    .font(.footnote)
                                    .foregroundColor(.red)
                            }
                            else {
                                Text(getCNDateYMD(Cdate: item.date))
                                    .font(.footnote)
                            }
                        }
                        Spacer()
                            
                            if item.priorityLevel == 0 {
                                if item.isCompleted {
                                    Text("无优先级")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }else {
                                    Text("无优先级")
                                        .font(.footnote)
                                }
                            }
                            else if item.priorityLevel == 1 {
                                if item.isCompleted {
                                    Text("I")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }else {
                                    Text("I")
                                        .font(.footnote)
                                }
                            }
                            else if item.priorityLevel == 2 {
                                if item.isCompleted {
                                    Text("II")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }else {
                                    Text("II")
                                        .font(.footnote)
                                }
                            }
                            else if item.priorityLevel == 3 {
                                if item.isCompleted {
                                    Text("III")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }else {
                                    Text("III")
                                        .font(.footnote)
                                }
                            }
                            else {
                                if item.isCompleted {
                                    Text("IV")
                                        .font(.footnote)
                                        .foregroundColor(.gray)
                                }else {
                                    Text("IV")
                                        .font(.footnote)
                                }
                            }
                        }
                }
                
                
                Spacer()
                
            }
            
        }
        }.contentShape(Rectangle())
    }
}



struct ToDoItemRowForCrate: View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var database: ToDoStore
    var item: ToDoItem
    
    func getCNDateYMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                
                HStack{
                    Text(item.title)
                   
                   Spacer()
               
               
                   ZStack{
                       if #available(iOS 15.0, *) {
                               RoundedRectangle(cornerRadius: 10.0)
                                   .fill()
                                   .frame(width: 60,  alignment: .center)
                                   .foregroundColor(.indigo)
                           }
                           
                        else {
                           // Fallback on earlier versions
                       }
                       Text(classifyName[item.classification])
                           .foregroundColor(Color.white)
                   }
                }
                
                HStack(spacing:20){
                        if item.date<Date() {
                            Text(getCNDateYMD(Cdate: item.date))
                                .foregroundColor(.red)
                        }
                        else {
                            Text(getCNDateYMD(Cdate: item.date))
                        }
                    
                    Spacer()
                    
                    if item.priorityLevel == 0 {
                            Text("无优先级")
                    }
                    else if item.priorityLevel == 1 {
                            Text("I")
                    }
                    else if item.priorityLevel == 2 {
                            Text("II")
                    }
                    else if item.priorityLevel == 3 {
                            Text("III")
                    }
                    else {
                            Text("IV")
                    }
                }
            }
            
        }.contentShape(Rectangle())
    }
}







class ToDoStore: ObservableObject {
    @Published var ToDos: [ToDoItem] = []{
        didSet {
            if let data = try? JSONEncoder().encode(ToDos){
                UserDefaults.standard.set(data, forKey: "ToDo")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "ToDo") {
            if let ToDos = try? JSONDecoder().decode([ToDoItem].self, from: data){
                self.ToDos = ToDos
            }
        }
    }
}
