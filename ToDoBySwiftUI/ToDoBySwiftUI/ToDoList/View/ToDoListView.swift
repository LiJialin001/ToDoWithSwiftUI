//
//  ToDoContent.swift
//  To-Do项目
//
//  Created by 李佳林 on 2021/7/21.
//


import SwiftUI

//MARK:-ToDoListView
struct ToDoList: View {
    
  //  @EnvironmentObject var quickActionSettings: QuickActionSettings
    @EnvironmentObject var database: ToDoStore
    @EnvironmentObject var databaseMessage: MessageStore
    @Namespace private var namespace
    @State var chooseToDo = false
    @State var messagesOpen = false
    @State var calenderOpen = false
    @State var newItemOpen = false
    @State var text = ""
    @State var changeToDoItemTitle = ""
    @State var newToDoItemClassification = ""
    @State var newToDOItemPriorityLevel = ""
    @State var editMode: EditMode = .inactive
    @State private var ToDoListsearchTerm : String = ""
    @State private var showCancelButton: Bool = false
    @State var isBeginSearch = false
    @State var size = "全部待办"
    @State var sort = "DDL"
    @State var select = "所有"
    @State var isTeamButton = 0
    @State var DDLbutton = false
    @State var PriorityLevelButton = false
    @State var isPresented = false
    @State var DetailPopOpen = false
    @State var showAlert = false
    @State var shakePage = false
    @State var DetailItem: ToDoItem?
    
    func getCNDateYMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }

    
    var body: some View {
        ZStack{
            NavigationView{
                ZStack{
                    VStack{
                        Spacer()
                        //搜索筛选栏
                        HStack {
                            if !isBeginSearch {
                                Menu(content: {
                                    Button(action: {
                                        size = "全部待办"
                                        isTeamButton = 0
                                    }, label: {
                                        Text("全部待办")
                                    })
                                    Button(action: {
                                        size = "个人待办"
                                        isTeamButton = 1
                                    }, label: {
                                        Text("个人待办")
                                    })
                                    Button(action: {
                                        size = "团队待办"
                                        isTeamButton = 2
                                    }, label: {
                                        Text("团队待办")
                                    })
                               }){
                                    Label(title: {}) {
                                            Text(size)
                                    }
                                  }
                            }
                            HStack {
                                Image(systemName: "magnifyingglass")
                                TextField("search", text: $ToDoListsearchTerm, onEditingChanged: {
                                    isEditing in
                                    self.showCancelButton = true
                                    isBeginSearch = true
                                }, onCommit: {
                                    print("onCommit")
                                }).foregroundColor(.primary)

                                Button(action: {
                                    self.ToDoListsearchTerm = ""
                                }) {
                                    Image(systemName: "xmark.circle.fill")
                                        .opacity(ToDoListsearchTerm == "" ? 0 : 1)
                                }
                            }
                            .padding(EdgeInsets(top: 6, leading: 6, bottom: 8, trailing: 6))
                            .foregroundColor(.secondary)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(20.0)

                    
                            if showCancelButton  {
                                Button("取消") {
                                    UIApplication.shared.endEditing()
                                    self.ToDoListsearchTerm = ""
                                    self.showCancelButton = false
                                    isBeginSearch = false
                                }
                                .foregroundColor(Color(.systemBlue))
                            }
                            
                            if !isBeginSearch {
                                Menu(content: {
                                    Button(action: {
                                        select = "所有"
                                    }, label: {
                                        Text("所有待办")
                                    })
                                    Button(action: {
                                        select = "优先级"
                                    }, label: {
                                        Text("按优先级筛选")
                                        Menu(content: {
                                            Button(action: {
                                            }, label: {
                                                Text("1 重要且紧急")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("2 不重要且紧急")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("3 重要且不紧急")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("4 不重要且不紧急")
                                            })
                                        }) {
                                            Label(title: {}) {}
                                        }
                                    })
                                    Button(action:{
                                        select = "分类"
                                    }, label: {
                                        Text("按分类筛选")
                                        Menu(content: {
                                            Button(action: {
                                            }, label: {
                                                Text("学习")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("工作")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("生活")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("娱乐")
                                            })
                                        }) {
                                            Label(title: {}) {}
                                        }
                                    })
                                    Button(action:{
                                        select = "DDL"
                                    }, label: {
                                        Text("按DDL筛选")
                                        Menu(content: {
                                            Button(action: {
                                            }, label: {
                                                Text("今天")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("三天之内")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("一周之内")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("一月之内")
                                            })
                                        }) {
                                            Label(title: {}) {}
                                        }
                                    })
                                    Button(action:{
                                        select = "状态"
                                    }, label: {
                                        Text("按状态筛选")
                                        Menu(content: {
                                            Button(action: {
                                            }, label: {
                                                Text("已过期")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("已完成")
                                            })
                                            Button(action: {
                                            }, label: {
                                                Text("未完成")
                                            })
                                        }) {
                                            Label(title: {}) {}
                                        }
                                    })
                                    }) {
                                    Label(title: {}) {
                                            Image(systemName: "tag")
                                            .font(.title)
                                    }
                                }
                            
                                Menu(content: {
                                    Button(action: {
                                        DDLbutton = false
                                        PriorityLevelButton = false
                                        sort = "建立顺序"
                                    }, label: {
                                        Text("按建立顺序排序")
                                    })
                                    Button(action: {
                                        DDLbutton = true
                                        PriorityLevelButton = false
                                        sort = "DDL"
                                    }, label: {
                                        Text("按DDL排序")
                                    })
                                    Button(action: {
                                        DDLbutton = false
                                        PriorityLevelButton = true
                                        sort = "优先级"
                                    }, label: {
                                        Text("按优先级排序")
                                    })
                                    }) {
                                    Label(title: {}) {
                                            Image(systemName: "list.number")
                                            .font(.title)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                        
//                        if #available(iOS 15.0, *) {
                            List{
                                if DDLbutton && !PriorityLevelButton{
                                    Section(header:
                                        Text(ToDoListsearchTerm.isEmpty ? "未完成" : "搜索结果")
                                                .font(.footnote)
                                    ){
                                        if ToDoListsearchTerm.isEmpty {
                                            ForEach(database.ToDos.filter{!$0.title.isEmpty && !$0.isCompleted}.sorted(by: { (lhs, rhs) -> Bool in
                                                lhs.date < rhs.date
                                            }))
                                            { item in
                                                    if isTeamButton == 2 {
                                                        if !item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else if isTeamButton == 1 {
                                                        if item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                            }
                                            
                                        }else{
                                            ForEach(database.ToDos.filter {
                                                $0.title.lowercased().contains(ToDoListsearchTerm.lowercased())
                                            }.sorted(by: { (lhs, rhs) -> Bool in
                                                lhs.date < rhs.date
                                            }))
                                            { item in
                                                    if isTeamButton == 2 {
                                                        if !item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else if isTeamButton == 1 {
                                                        if item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                            }
                                        }
                                    }
                                    
                                    Section(header:
                                            Text("已完成")
                                                .font(.footnote)
                                    ){
                                        ForEach(database.ToDos.filter{
                                            $0.isCompleted
                                        }.sorted(by: { (lhs, rhs) -> Bool in
                                            lhs.date < rhs.date
                                        }))
                                        { item in
                                                if isTeamButton == 2 {
                                                    if !item.isPersonal {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                                }
                                                else if isTeamButton == 1 {
                                                    if item.isPersonal {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                                }
                                                else {
                                                    ToDoItemRow(item: item)
                                                        .environment(\.editMode, self.$editMode)
                                                        .onTapGesture(perform: {
                                                            Haptics.giveSmallHaptic()
                                                            DetailPopOpen = true
                                                            DetailItem = item
                                                        })
                                                }
                                        }
                                    }
                                }
                                else if !DDLbutton && PriorityLevelButton {
                                    Section(header:
                                        Text( ToDoListsearchTerm.isEmpty ? "未完成" : "搜索结果")
                                                .font(.footnote)
                                    ){
                                        ForEach(searchResults.sorted(by: { (lhs, rhs) -> Bool in
                                            lhs.priorityLevel < rhs.priorityLevel
                                        }))
                                        { item in
                                                if isTeamButton == 2 {
                                                    if !item.isPersonal {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                                }
                                                else if isTeamButton == 1 {
                                                    if item.isPersonal {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                                }
                                                else {
                                                    ToDoItemRow(item: item)
                                                        .environment(\.editMode, self.$editMode)
                                                        .onTapGesture(perform: {
                                                            Haptics.giveSmallHaptic()
                                                            DetailPopOpen = true
                                                            DetailItem = item
                                                        })
                                                }
                                        }
                                    }
                                    Section(header:Text("已完成")
                                                .font(.footnote)){
                                        ForEach(database.ToDos.filter{
                                            $0.isCompleted
                                        }.sorted(by: { (lhs, rhs) -> Bool in
                                            lhs.priorityLevel < rhs.priorityLevel
                                        }))
                                        { item in
                                                if isTeamButton == 2 {
                                                    if !item.isPersonal {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                                }
                                                else if isTeamButton == 1 {
                                                    if item.isPersonal {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                                }
                                                else {
                                                    ToDoItemRow(item: item)
                                                        .environment(\.editMode, self.$editMode)
                                                        .onTapGesture(perform: {
                                                            Haptics.giveSmallHaptic()
                                                            DetailPopOpen = true
                                                            DetailItem = item
                                                        })
                                                }
                                        }
                                    }
                                }else {
                                    Section(header:
                                        Text( ToDoListsearchTerm.isEmpty ? "未完成" : "搜索结果")
                                                .font(.footnote)
                                    ){
                                        ForEach(searchResults)
                                        { item in
                                                if isTeamButton == 2 {
                                                    if !item.isPersonal {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                                }
                                                else if isTeamButton == 1 {
                                                    if item.isPersonal {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                                }
                                                else {
                                                    ToDoItemRow(item: item)
                                                        .environment(\.editMode, self.$editMode)
                                                        .onTapGesture(perform: {
                                                            Haptics.giveSmallHaptic()
                                                            DetailPopOpen = true
                                                            DetailItem = item
                                                        })
                                                }
                                        }
                                        .onDelete { (indices) in
                                            self.database.ToDos.remove(at: indices.first!)
                                        }
                                    }
                                    Section(header:Text("已完成")
                                                .font(.footnote)){
                                        if isTeamButton == 0 {
                                            ForEach(
                                                database.ToDos.filter{
                                                    $0.isCompleted
                                                }
                                            )
                                            { item in
                                                    if isTeamButton == 2 {
                                                        if !item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else if isTeamButton == 1 {
                                                        if item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                                
                                            }
                                            .onDelete { (indices) in
                                                self.database.ToDos.remove(at: indices.first!)
                                            }
                                        }
                                        else if isTeamButton == 1 {
                                            ForEach(
                                                database.ToDos.filter{
                                                    $0.isCompleted && $0.isPersonal
                                                }
                                            )
                                            { item in
                                                    if isTeamButton == 2 {
                                                        if !item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else if isTeamButton == 1 {
                                                        if item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                            }
                                            .onDelete { (indices) in
                                                self.database.ToDos.remove(at: indices.first!)
                                            }
                                        }
                                        else{
                                            ForEach(
                                                database.ToDos.filter{
                                                    $0.isCompleted && !$0.isPersonal
                                                }
                                            )
                                            { item in
                                                    if isTeamButton == 2 {
                                                        if !item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else if isTeamButton == 1 {
                                                        if item.isPersonal {
                                                            ToDoItemRow(item: item)
                                                                .environment(\.editMode, self.$editMode)
                                                                .onTapGesture(perform: {
                                                                    Haptics.giveSmallHaptic()
                                                                    DetailPopOpen = true
                                                                    DetailItem = item
                                                                })
                                                        }
                                                    }
                                                    else {
                                                        ToDoItemRow(item: item)
                                                            .environment(\.editMode, self.$editMode)
                                                            .onTapGesture(perform: {
                                                                Haptics.giveSmallHaptic()
                                                                DetailPopOpen = true
                                                                DetailItem = item
                                                            })
                                                    }
                                            }
                                            .onDelete { (indices) in
                                                self.database.ToDos.remove(at: indices.first!)
                                            }
                                        }
                                        
                                    }
                                }
                            }
                            .navigationBarTitleDisplayMode(.inline)
                            .toolbar {
                                ToolbarItem(placement: .principal) {
                                    HStack {
                                        Button(action:{
                                            withAnimation {
                                                messagesOpen.toggle()
                                            }
                                            Haptics.giveHaptic()
                                        }){
                                            ZStack{
                                                Image(systemName: "message")
                                                    .font(.title)
                                                if notReadMessage.count != 0 {
                                                    Image(systemName: "\(notReadMessage.count).circle.fill")
                                                        .font(.body)
                                                        .foregroundColor(Color.red)
                                                        .background(Color.white)
                                                        .clipShape(Circle())
                                                        .padding(.init(top: -10, leading: 30, bottom: 10, trailing: 1))
                                                }
                                            }
                                        }
                                        .sheet(isPresented: $messagesOpen, onDismiss: {messagesOpen = false}) {MessageView(messagesOpen: $messagesOpen)}
                                        Spacer()
                                        Text(getCNDateYMD(Cdate: Date()))
                                            .font(.headline)
                                        Spacer()
                                        Button(action: {
                                            withAnimation {
                                                calenderOpen.toggle()
                                            }
                                            Haptics.giveHaptic()
                                        }){
                                            Image(systemName: "calendar")
                                                .font(.title)
                                        }
                                        .sheet(isPresented: $calenderOpen, onDismiss: {calenderOpen = false}){
                                            RootView(calenderOpen: $calenderOpen)
                                        }
                                    }
                                }
                            }
//                        } else {
                            // Fallback on earlier versions
//                        }
                        
                    }
                    
                    
//MARK: - PlusButton
                    VStack{
                        Spacer()
                        HStack{
                            Spacer()
                            Button(action: {
                                Haptics.giveHaptic()
                                withAnimation (.easeInOut(duration: 0.6)){
                                    isPresented.toggle()
                                }
                            })
                            {
                                if #available(iOS 15.0, *) {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(Color.indigo)
                                        .shadow(color: .indigo.opacity(0.3), radius: 10, x: 0, y: 10)
                                        .background(.white)
                                        .clipShape(Circle())
                                        .padding(20)
                                       
                                } else {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                        .foregroundColor(Color.blue)
                                        .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 10)
                                        .background(.white)
                                        .clipShape(Circle())
                                        .padding()
                                }
                            }
                        }
                        .matchedGeometryEffect(id: "button", in: namespace)
                    }
                }
                .popup(isPresented: $DetailPopOpen) {
                    BottomPopupView {
                        DetailPopView(DetailPopOpen: $DetailPopOpen, DetailItem: DetailItem!, showAlert: $showAlert, item: DetailItem!)
                    }
                }
                .popup(isPresented: $isPresented) {
                    BottomPopupView {
                        AddPopupView(isPresented: $isPresented)
                    }
                }
                .popup(isPresented: $shakePage) {
                    shakePopupView {
                        shakeSheetView(shakePage: $shakePage)
                    }
                }
            }
    }
        .onShake{
            Haptics.simpleSuccess()
            shakePage = true
            print("Shake")
        }
        .alertDialog(show: $showAlert,duration: 1){
            AlertToast(type: .complete(Color.green), title: "已更改")
        }
        
    }
    
    var notReadMessage: [MessageItem] {
        return databaseMessage.Messages.filter{
            !$0.isRead
        }
    }
    
    var searchResults: [ToDoItem] {
        if isTeamButton==0 {
            if ToDoListsearchTerm.isEmpty {
                return database.ToDos.filter{
                    !$0.title.isEmpty && !$0.isCompleted
                }
            }else{
                return database.ToDos.filter {
                    $0.title.lowercased().contains(ToDoListsearchTerm.lowercased())
                }
            }
        }
        else if isTeamButton==1 {
            if ToDoListsearchTerm.isEmpty {
                return database.ToDos.filter{
                    !$0.title.isEmpty && !$0.isCompleted && $0.isPersonal
                }
            }else{
                return database.ToDos.filter {
                    $0.title.lowercased().contains(ToDoListsearchTerm.lowercased()) && $0.isPersonal
                }
            }
        }
        else {
            if ToDoListsearchTerm.isEmpty {
                return database.ToDos.filter{
                    !$0.title.isEmpty && !$0.isCompleted && !$0.isPersonal
                }
            }else{
                return database.ToDos.filter {
                    $0.title.lowercased().contains(ToDoListsearchTerm.lowercased()) && !$0.isPersonal
                }
            }
        }
    }
}


//struct ToDoList_Previews: PreviewProvider {
//    static var previews: some View {
//        ToDoList()
//            .environmentObject(ToDoStore())
//    }
//}
//


