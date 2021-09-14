//
//  CrateTeamDetail.swift
//  CrateTeamDetail
//
//  Created by 李佳林 on 2021/8/21.
//

import Foundation
import SwiftUI
import Combine

struct CrateTeamDetailView: View {
    
    @EnvironmentObject var databaseTeam: TeamStore
    @EnvironmentObject var database: ToDoStore
    @EnvironmentObject var databaseMessage: MessageStore
    @Environment(\.presentationMode) var presentation
    @State var editMode: EditMode = .inactive
    @State var DetailItem: TeamItem
    @State var whatItem = "待办"
    @State var ChooseButton = 1
    @State var PutOutToDo = false
    @State var SureToDelete = false
    @State var choosePerson = false
    @State var DetailPopOpen = false
    @State var showAlert = false
    @State var DetailItem2: ToDoItem?
    
    
    var Item: TeamItem
    var theNumber: Int
    
    var body: some View {
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
                            ChooseButton = 1
                        }, label: {
                            Text("显示待办")
                        })
                        Button(action: {
                            whatItem = "消息"
                            ChooseButton = 2
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
                            PutOutToDo = true
                        }){
                            Text("发布待办")
                        }
                        Button(action: {
                            ChooseButton = 4
                        }, label: {
                            Text("发布通知")
                        })
                        Button(action: {
                            ChooseButton = 5
                        }, label: {
                            Text("邀请成员")
                        })
                        Button(action: {
                            ChooseButton = 6
                        }, label: {
                            Text("团队详情")
                        })
                        Button(action: {
                            SureToDelete = true
                        }, label: {
                            Text("解散团队")
                        })
                }){
                    Label(title: {}) {
                        Image(systemName: "line.horizontal.3.decrease")
                            .font(.title)
                    }
                  }
                .padding()
            }
                if ChooseButton == 1 {
                    List{
                        Section(header:
                            Text("进行中")
                        ){
                            ForEach(NotOverTimeItems){ item in
                                    ToDoItemRowForCrate(item: item)
                                        .environment(\.editMode, self.$editMode)
                                        .onTapGesture(perform: {
                                            Haptics.giveSmallHaptic()
                                            DetailPopOpen = true
                                            DetailItem2 = item
                                        })
                            }

                        }
                        Section(header:
                                    Text("已过期")
                        ){
                            ForEach(OverTimeItems){ item in
                                
                                    ToDoItemRowForCrate(item: item)
                                        .environment(\.editMode, self.$editMode)
                                        .onTapGesture(perform: {
                                            Haptics.giveSmallHaptic()
                                            DetailPopOpen = true
                                            DetailItem2 = item
                                        })
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                }
                else if ChooseButton == 2 {
                    List{
                        ForEach(SentMassage){ item in
                            NavigationLink(destination: ChangeMessagesView(DetailItem: item, Item: item)){
                                MessageRow(DetailItem: item, item: item)
                                    .environment(\.editMode, self.$editMode)
                            }
                        }
                    }
                }
                else if ChooseButton == 4 {
                    PutOutMessagesView(ChooseButton: $ChooseButton, DetailItem: $DetailItem)
                }
                else if ChooseButton == 5 {
                    InviteNewMemberView(DetailItem: $DetailItem, ChooseButton: $ChooseButton)
                }
                else {
                    TeamDetailView(item: DetailItem)
                }
              Spacer()
                
            }
        }
        .sheet(isPresented: $choosePerson, onDismiss: {choosePerson = false}){
            ChoosePersonView(choosePerson: $choosePerson)
        }
        .popup(isPresented: $DetailPopOpen) {
            BottomPopupView {
                DetailPopView(DetailPopOpen: $DetailPopOpen, DetailItem: DetailItem2!, showAlert: $showAlert, item: DetailItem2!)
            }
        }
        .popup(isPresented: $PutOutToDo) {
            BottomPopupView {
                AddPopforTeamView(isPresented: $PutOutToDo, choosePerson: $choosePerson, DetailItem: DetailItem)
            }
        }
        .actionSheet(isPresented: $SureToDelete){
            ActionSheet(
                title: Text("提示"), message: Text("您确定要解散团队吗"), buttons:[
                    .default(Text("确定")){
                        self.databaseTeam.Teams.remove(at: theNumber)
                        //[self.database.ToDos.firstIndex(of: self.Item) ?? 0] = DetailItem
                    },
                    .cancel()
                ])
        }
    }
    
    var NotOverTimeItems: [ToDoItem] {
        return database.ToDos.filter{
            $0.Team == DetailItem && !$0.isOverTime
        }
    }
    
    
    var OverTimeItems: [ToDoItem] {
        return database.ToDos.filter{
            $0.Team == DetailItem && $0.isOverTime
        }
    }
    
    var SentMassage: [MessageItem] {
        return databaseMessage.Messages.filter{
            $0.itsTeam == DetailItem
        }
    }
}


struct ChoosePersonView: View {
    @Binding var choosePerson: Bool
    @State var showCancelButton = false
    @State var searchTerm = ""
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("从团队中选择接收人")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .padding()
                    Spacer()
                    Button(action:{}){
                        Text("全选")
                    }
                    .padding()
                }
                HStack{
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("search", text: $searchTerm, onEditingChanged: {
                            isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        })
                            .foregroundColor(.primary)

                        Button(action: {
                            self.searchTerm = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .opacity(searchTerm == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20.0)
                    .padding(1)

                    if showCancelButton  {
                        Button("取消") {
                            UIApplication.shared.endEditing()
                            self.searchTerm = ""
                            self.showCancelButton = false
                        }
                        .padding()
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                
                List{
                    HStack{
                        Text("姓名+学号")
                            .padding()
                        Spacer()
                        Button(action:{}){
                            Image(systemName: "square")
                        }
                        .padding()
                    }
                    HStack{
                        Text("姓名+学号")
                            .padding()
                        Spacer()
                        Button(action:{}){
                            Image(systemName: "square")
                        }
                        .padding()
                    }

                    HStack{
                        Text("姓名+学号")
                            .padding()
                        Spacer()
                        Button(action:{}){
                            Image(systemName: "square")
                        }
                        .padding()
                    }

                    HStack{
                        Text("姓名+学号")
                            .padding()
                        Spacer()
                        Button(action:{}){
                            Image(systemName: "square")
                        }
                        .padding()
                    }
                }
                
                Spacer()
                
                if #available(iOS 15.0, *) {
                    Button(action: {
                        withAnimation{
                            choosePerson.toggle()
                        }
                    }, label: {
                        HStack {
                            Text("确定")
                            Image(systemName: "checkmark.circle")
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
         }
    }
}

struct InviteNewMemberView: View {
    @EnvironmentObject var databaseTeam: TeamStore
    @EnvironmentObject var databaseMessage: MessageStore
    @EnvironmentObject var databaseUser: UserStore
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    
    @Binding var DetailItem: TeamItem
    @Binding var ChooseButton: Int
    
    @State var showCancelButton = false
    @State var searchTerm = ""
    
    @State var addTeamMemberInfo = AddTeamMemberInfo(message: "", result: "", code: 4)

    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    Text("搜索邀请人")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .padding()
                    Spacer()
                }
                HStack{
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("search", text: $searchTerm, onEditingChanged: {
                            isEditing in
                            self.showCancelButton = true
                        }, onCommit: {
                            print("onCommit")
                        })
                            .foregroundColor(.primary)

                        Button(action: {
                            self.searchTerm = ""
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .opacity(searchTerm == "" ? 0 : 1)
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                    .foregroundColor(.secondary)
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(20.0)
                    .padding(1)

                    if showCancelButton  {
                        Button("取消") {
                            UIApplication.shared.endEditing()
                            self.searchTerm = ""
                            self.showCancelButton = false
                        }
                        .padding()
                        .foregroundColor(Color(.systemBlue))
                    }
                }
                
                List{
                    
                }
                Spacer()
                if #available(iOS 15.0, *) {
                    Button(action: {
                        AddTeamMemberManager.AddTeamMemberPost(teamId: 11, userId: 6, completion: {
                            result in
                            switch result {
                            case .success(let data):
                                addTeamMemberInfo = data
                                print(data)
                                print(addTeamMemberInfo)
                            case.failure(let error):
                                print(error.message)
                            }
                        })
                        self.databaseMessage.Messages.append(MessageItem( title: DetailItem.name, mainMessage: "\(DetailItem.name)邀请你加入团队", itsTeam: DetailItem, classification: 2, date: Date(), isRead: false))
                    }, label: {
                        HStack {
                            Text("确定邀请")
                            Image(systemName: "checkmark.circle")
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
        }
    }
}

struct PutOutMessagesView: View {
    
    @EnvironmentObject var databaseTeam: TeamStore
    @EnvironmentObject var databaseMessage: MessageStore
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var showCancelButton = false
    @State var ChoosePerson = true
    @State var searchTerm = ""
    
    @State var title = ""
    @State var mainMessage = ""
    
    @Binding var ChooseButton: Int
    @Binding var DetailItem: TeamItem
    
    let mainTextLimit = 300
    
    func textChanged(upper: Int, text: inout String) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
    
    var body: some View {
        ZStack{
            if !ChoosePerson {
                ZStack{
                VStack{
                    ScrollView{
                        VStack{
                            TextField("主题", text: $title)
                                .font(.title)
                                .padding(.leading, 10)
                                .padding()
                            
                            ZStack(alignment: .leading) {
                                if mainMessage.isEmpty {
                                    VStack(alignment: .leading) {
                                        Text("输入通知内容")
                                            .font(Font.body)
                                            .foregroundColor(Color.gray)
                                        Spacer()
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 4)
                                    .zIndex(0)
                                }
                                TextEditor(text: $mainMessage)
                                
                                    .frame(height: 200, alignment: .leading)
                                    .frame(maxWidth: .infinity)
                                    .lineSpacing(5)
                                    .onReceive(Just(mainMessage)) { mainText in
                                        textChanged(upper: mainTextLimit, text: &self.mainMessage)
                                    }
                                    .zIndex(1)
                                    .opacity(mainMessage.isEmpty ? 0.25 : 1)
                                
                            }
                            .frame(height: 200, alignment: .leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 30)
                        }
                        
                    }
                    
                    Spacer()
                    
                    if #available(iOS 15.0, *) {
                        Button(action: {
                            self.databaseMessage.Messages.insert(MessageItem(title: self.title,mainMessage: self.mainMessage,itsTeam: DetailItem, date: Date()), at: .zero)
                      /*      self.databaseMessage.Messages.append(MessageItem(title: self.title,mainMessage: self.mainMessage,itsTeam: DetailItem, date: Date()))   */
                            withAnimation (.easeInOut(duration: 0.5)){
                                ChooseButton = 1
                            }
                        }, label: {
                            HStack {
                                Text("发布")
                                Image(systemName: "checkmark.circle")
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
                        Button(action: {
                            self.databaseMessage.Messages.insert(MessageItem(title: self.title,mainMessage: self.mainMessage,itsTeam: DetailItem, date: Date()), at: .zero)
                            withAnimation (.easeInOut(duration: 0.5)){
                                ChooseButton = 1
                            }
                        }, label: {
                            HStack {
                                Text("发布")
                                Image(systemName: "checkmark.circle")
                            }
                            .frame(maxWidth: .infinity)
                        })
                            .buttonStyle(BorderedButtonStyle(shape: .roundedRectangle))
                            .tint(.blue)
                            .controlProminence(.increased)
                            .controlSize(.large)
                            .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                            .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                            .padding()
                    }
                }
                }
            }
            
            if ChoosePerson {
                VStack{
                    HStack{
                        Text("从团队中选择接收人")
                            .padding()
                        Spacer()
                        Button(action:{}){
                            Text("全选")
                        }
                        .padding()
                    }
                    HStack{
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("search", text: $searchTerm, onEditingChanged: {
                                isEditing in
                                self.showCancelButton = true
                            }, onCommit: {
                                print("onCommit")
                            })
                                .foregroundColor(.primary)

                            Button(action: {
                                self.searchTerm = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .opacity(searchTerm == "" ? 0 : 1)
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(20.0)
                        .padding(1)

                        if showCancelButton  {
                            Button("Cancel") {
                                UIApplication.shared.endEditing()
                                self.searchTerm = ""
                                self.showCancelButton = false
                            }
                            .padding()
                            .foregroundColor(Color(.systemBlue))
                        }
                    }
                    
                    List{
                        HStack{
                            Text("姓名+学号")
                                .padding()
                            Spacer()
                            Button(action:{}){
                                Image(systemName: "square")
                            }
                            .padding()
                        }
                        HStack{
                            Text("姓名+学号")
                                .padding()
                            Spacer()
                            Button(action:{}){
                                Image(systemName: "square")
                            }
                            .padding()
                        }

                        HStack{
                            Text("姓名+学号")
                                .padding()
                            Spacer()
                            Button(action:{}){
                                Image(systemName: "square")
                            }
                            .padding()
                        }

                        HStack{
                            Text("姓名+学号")
                                .padding()
                            Spacer()
                            Button(action:{}){
                                Image(systemName: "square")
                            }
                            .padding()
                        }
                    }
                    
                    Spacer()
                    
                    if #available(iOS 15.0, *) {
                        Button(action: {
                            withAnimation{
                                ChoosePerson.toggle()
                            }
                        }, label: {
                            HStack {
                                Text("确定")
                                Image(systemName: "checkmark.circle")
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
            }

        }
        .background(
            Color.clear
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        )
    }
}

struct ChangeMessagesView: View {
    
    @EnvironmentObject var databaseMessage: MessageStore
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    
    @State var isActionSheet = false
    @State var showCancelButton = false
    @State var ChoosePerson = false
    @State var showAlert = false
    @State var searchTerm = ""
    
    
    @State var DetailItem: MessageItem
    var Item: MessageItem
    
    let mainTextLimit = 300
    
    func textChanged(upper: Int, text: inout String) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
    
    var body: some View {
        ZStack {
            if !ChoosePerson {
                VStack{
                    ScrollView{
                        VStack{
                            TextField(DetailItem.title, text: $DetailItem.title)
                                .font(.title)
                                .padding(.leading, 10)
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .padding()
                            
                            ZStack(alignment: .leading) {
                                if DetailItem.mainMessage.isEmpty {
                                    VStack(alignment: .leading) {
                                        Text("输入通知内容")
                                            .font(Font.body)
                                            .foregroundColor(Color.gray)
                                        Spacer()
                                    }
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 4)
                                    .zIndex(0)
                                }
                                TextEditor(text: $DetailItem.mainMessage)
                                
                                    .frame(height: 200, alignment: .leading)
                                    .frame(maxWidth: .infinity)
                                    .lineSpacing(5)
                                    .onReceive(Just(DetailItem.mainMessage)) { mainText in
                                        textChanged(upper: mainTextLimit, text: &self.DetailItem.mainMessage)
                                    }
                                    .zIndex(1)
                                    .opacity(DetailItem.mainMessage.isEmpty ? 0.25 : 1)
                            }
                            .frame(height: 200, alignment: .leading)
                            .frame(maxWidth: .infinity)
                            .padding(.horizontal, 30)
                        }
                    }
                    
                    Spacer()
                    
                    if #available(iOS 15.0, *) {
                        Button(action: {
                            UIApplication.shared.endEditing()
                            isActionSheet = true
                        }, label: {
                            HStack {
                                Text("修改并发布")
                                Image(systemName: "checkmark.circle")
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
            }
            
            
            
            if ChoosePerson {
                VStack{
                    HStack{
                        Text("从团队中选择接收人")
                            .padding()
                        Spacer()
                        Button(action:{}){
                            Text("全选")
                        }
                        .padding()
                    }
                    HStack{
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("search", text: $searchTerm, onEditingChanged: {
                                isEditing in
                                self.showCancelButton = true
                            }, onCommit: {
                                print("onCommit")
                            })
                                .foregroundColor(.primary)

                            Button(action: {
                                self.searchTerm = ""
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .opacity(searchTerm == "" ? 0 : 1)
                            }
                        }
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .foregroundColor(.secondary)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(20.0)
                        .padding(1)

                        if showCancelButton  {
                            Button("Cancel") {
                                UIApplication.shared.endEditing()
                                self.searchTerm = ""
                                self.showCancelButton = false
                            }
                            .padding()
                            .foregroundColor(Color(.systemBlue))
                        }
                    }
                    
                    List{
                        HStack{
                            Text("姓名+学号")
                                .padding()
                            Spacer()
                            Button(action:{}){
                                Image(systemName: "square")
                            }
                            .padding()
                        }
                        HStack{
                            Text("姓名+学号")
                                .padding()
                            Spacer()
                            Button(action:{}){
                                Image(systemName: "square")
                            }
                            .padding()
                        }

                        HStack{
                            Text("姓名+学号")
                                .padding()
                            Spacer()
                            Button(action:{}){
                                Image(systemName: "square")
                            }
                            .padding()
                        }

                        HStack{
                            Text("姓名+学号")
                                .padding()
                            Spacer()
                            Button(action:{}){
                                Image(systemName: "square")
                            }
                            .padding()
                        }
                    }
                    
                    Spacer()
                    
                    if #available(iOS 15.0, *) {
                        Button(action: {
                            withAnimation{
                                ChoosePerson.toggle()
                            }
                        }, label: {
                            HStack {
                                Text("确定")
                                Image(systemName: "checkmark.circle")
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
            }

        }
        .alertDialog(show: $showAlert,duration: 1){
            AlertToast(type: .complete(Color.green), title: "已发送")
        }
        .actionSheet(isPresented: $isActionSheet) {
            ActionSheet(title: Text("提示"), message: Text("是否修改并重新发送待办"), buttons: [
                .default(Text("修改并发送")){
                    showAlert = true
                    DetailItem.isRead = false
                    self.databaseMessage.Messages[self.databaseMessage.Messages.firstIndex(of: self.Item) ?? 0] = DetailItem
                },
                .cancel()
            ])
        }
    }
}



struct CrateTeamDetail_Previews: PreviewProvider {
    static var previews: some View {
        CrateTeamDetailView(DetailItem: TeamItem(name: "TeamText", synopsis: "kjhiugufufhohgiyfyfuf", isMyTeam: false, theBoss: "Boss"), Item: TeamItem(name: "TeamText", synopsis: "kjhiugufufhohgiyfyfuf", isMyTeam: false, theBoss: "Boss"), theNumber: 0)
            .environmentObject(TeamStore())
            .environmentObject(ToDoStore())
            .environmentObject(MessageStore())
    }
}
