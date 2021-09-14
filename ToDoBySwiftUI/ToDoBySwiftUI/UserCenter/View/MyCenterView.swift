//
//  MyCenterView.swift
//  To-Do项目
//
//  Created by 李佳林 on 2021/7/24.
//

import SwiftUI
import UIKit
var sc = UIScrollView()

//MARK: - MyCenterView
struct MyCenter: View {
    @ObservedObject var networkManagerLoign = NetworkManagerLoignOut()
    @EnvironmentObject var database: UserStore
    @EnvironmentObject var databaseToDo: ToDoStore
    @Environment(\.colorScheme) var colorScheme
    @State var messagesOpen = false
    @State var isLogin = false
    var body: some View {
        ZStack{
        NavigationView{
            ZStack{
                VStack{
                    Form{
                        if !database.Users.isEmpty {
                            Section{
                                ForEach(database.Users){ item in
                                    HStack{
                                        Image(systemName: "person.crop.circle")
                                            .font(.system(size: 60))
                                            .padding()
                                        Spacer()
                                        VStack(alignment: .leading){
                                            Text("用户名：\(item.name)")
                                                .font(.system(size: 15))
                                                .padding(3)
                                            Text("学号：\(item.StudentNumber)")
                                                .font(.body)
                                                .padding(3)
                                        }
                                        Spacer()
                                    }
                                }
                            }
                            Section{
                                NavigationLink(destination: ChangeMyInfo(DetailItem: database.Users[0], item: database.Users[0])){
                                    HStack(spacing:30){
                                        Image(systemName: "highlighter")
                                        Text("个人信息修改")
                                    }
                                    .padding()
                                }
                                
                                NavigationLink(destination: DataStatistic(items:[ Card( id: 5, name: "全部待办", tasks: databaseToDo.ToDos.count, taskCompleted: databaseToDo.ToDos.filter{$0.isCompleted}.count), Card( id: 1, name: "学习" ,tasks: databaseToDo.ToDos.filter{$0.classification==1}.count,taskCompleted: databaseToDo.ToDos.filter{$0.classification==1 && $0.isCompleted}.count), Card( id: 4, name: "工作" ,tasks: databaseToDo.ToDos.filter{$0.classification==4}.count,taskCompleted: databaseToDo.ToDos.filter{$0.classification==4 && $0.isCompleted}.count), Card( id: 3, name: "生活" ,tasks: databaseToDo.ToDos.filter{$0.classification==2}.count,taskCompleted: databaseToDo.ToDos.filter{$0.classification==2 && $0.isCompleted}.count), Card( id: 2, name: "娱乐" ,tasks: databaseToDo.ToDos.filter{$0.classification==3}.count,taskCompleted: databaseToDo.ToDos.filter{$0.classification==3 && $0.isCompleted}.count), Card(id: 0, name: "无分类",tasks: databaseToDo.ToDos.filter{$0.classification==0}.count,taskCompleted: databaseToDo.ToDos.filter{$0.classification==0 && $0.isCompleted}.count)])){
                                    HStack(spacing:30){
                                        Image(systemName: "binoculars")
                                        Text("数据统计")
                                    }
                                    .padding()
                                }
                                
                                
                                HStack(spacing:30){
                                    Image(systemName: "personalhotspot")
                                    Text("绑定办公网")
                                }
                                .padding()
                                
                                HStack(spacing:30){
                                    Image(systemName: "filemenu.and.selection")
                                    Text("天外天消息")
                                }
                                .padding()
                                NavigationLink(destination: UsersColorView()){
                                    HStack(spacing:30){
                                        Image(systemName: "paintbrush")
                                        Text("调色板")
                                    }
                                    .padding()
                                }
                                
                                NavigationLink(destination: FeedBackView()){
                                    HStack(spacing:30){
                                        Image(systemName: "bubble.left.and.bubble.right")
                                        Text("用户反馈")
                                    }
                                    .padding()
                                }
                                
                                if colorScheme == .dark {
                                    Button(action:{
                                        isLogin = true
                                    }){
                                        HStack(spacing:30){
                                            Image(systemName: "figure.walk.diamond.fill")
                                            Text("登出")
                                        }
                                        .foregroundColor(.white)
                                    }
                                    .padding()
                                }else {
                                    Button(action:{
                                        isLogin = true
                                    }){
                                        HStack(spacing:30){
                                            Image(systemName: "figure.walk.diamond")
                                            Text("登出")
                                        }
                                        .foregroundColor(.black)
                                    }
                                    .padding()
                                }
                                
                                HStack(spacing:30){
                                    Image(systemName: "square.stack.3d.up")
                                    Text("版本更新")
                                }
                                .padding()
                            }
                        }else {
                            Section{
                                NavigationLink(destination: BeginView()){
                                    Text("点击登录/注册")
                                        .padding()
                                }
                            }
                        }
                    }
                }
                    .navigationBarTitleDisplayMode(.inline)
                    .alert(isPresented: $isLogin){
                        Alert(title: Text("提示"), message: Text("确定要登出吗"),primaryButton: .default(Text("确定"), action:{
                            database.Users.removeAll()
                            networkManagerLoign.placeOrder()
                        }) ,secondaryButton: .destructive(Text("取消")))
                    }
            }
        }
    }
    }
}



struct ChangeMyInfo: View {
    @EnvironmentObject var database: UserStore
    @State var newPassword = ""
    @State var SurePassword = ""
    @State var showTip = false
    @State var DetailItem: UserItem
    var item: UserItem
    var body: some View {
        VStack{
            Form{
                if #available(iOS 15.0, *) {
                    Section("基本信息"){
                        Text("用户名：\(DetailItem.name)")
                        Text("学号：\(DetailItem.StudentNumber)")
                    }
                
                    Section("修改密码"){
                        TextField("新密码", text: $newPassword)
                        TextField("确认新密码", text: $SurePassword)
                    }
                }
                else {
                    VStack{
                        Text("基本信息")
                            .font(.footnote)
                        Section{
                            Text("用户名：\(DetailItem.name)")
                            Text("学号：\(DetailItem.StudentNumber)")
                        }
                        Text("修改密码")
                            .font(.footnote)
                        Section{
                            TextField("新密码", text: $newPassword)
                            TextField("确认新密码", text: $SurePassword)
                        }

                    }
                }
            }
            Spacer()
            if #available(iOS 15.0, *) {
                Button(action: {
                    if newPassword == SurePassword && (!newPassword.isEmpty && !SurePassword.isEmpty){
                        DetailItem.Password = newPassword
                        self.database.Users[self.database.Users.firstIndex(of: self.item)!] = DetailItem
                    }else{
                        withAnimation {
                            showTip.toggle()
                        }
                    }
                }, label: {
                    HStack {
                        Text("修改")
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
        .alert(isPresented: $showTip){
            Alert(title: Text("提示"), message: Text("两次新密码不一致"), dismissButton: .destructive(Text("确定")))
        }
    }
}

struct FileItem:Identifiable{
    var id = UUID()
    var file:URL
    var name = ""
}

struct DataStatistic: View {
    @EnvironmentObject var UIState: UIStateModel
    @EnvironmentObject var database: ToDoStore
    let spacing:            CGFloat = 16
    let widthOfHiddenCards: CGFloat = 32    // UIScreen.main.bounds.width - 10
    let cardHeight:         CGFloat = 279
    var items = [Card]()
    let classifyName = ["无分类", "学习", "生活", "娱乐", "工作"]
    @State var otherView = -1
    @State var counts = 0
    @State var fileItem:FileItem?
    @State private var showShareSheet = false

    func getCNDateYMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    
    var body: some View {
        ZStack{
            if otherView == -1 {
                VStack{
                    Canvas
                            {
                                Carousel(numberOfItems: CGFloat( items.count ), spacing: spacing, widthOfHiddenCards: widthOfHiddenCards )
                                {
                                    ForEach( items, id: \.self.id ) { item in
                                        
                                        Item( _id:                  Int(item.id),
                                              spacing:              spacing,
                                              widthOfHiddenCards:   widthOfHiddenCards,
                                              cardHeight:           cardHeight )
                                        {
                                            CategoryCards(category: item.name, color: .indigo, numberOfTasks: item.tasks, tasksDone: item.taskCompleted)
                                        }
                                        .transition( AnyTransition.slide )
                                        .animation( .spring() )
                                        .onLongPressGesture {
                                            Haptics.giveHaptic()
                                            if item.id == 5 {
                                                if !database.ToDos.isEmpty {
                                                    otherView = item.id
                                                }
                                            }else{
                                                if !database.ToDos.filter({$0.classification == item.id}).isEmpty {
                                                    otherView = item.id
                                                }
                                            }
                                        }
                                    }
                                }
                                .environmentObject( self.UIState )
                            }

                    Text("长按卡片查看细节")
                        .bold()
                        .padding()
                    
                }
                                        
            }
            if otherView == 5 {
                VStack{
                    HStack{
                        Text("点击任意处返回")
                            .bold()
                            .padding()
                        Spacer()
                        Button(action:{
                            let scs = sc.superview
                            sc.removeFromSuperview()
                            let image = sc.screenshot()
                            print(image)
                            let filename = getDocumentsDirectory().appendingPathComponent(getCNDate()+".jpg")
                           
                            if let data = image.jpegData(compressionQuality: 0.8) {
                                try? data.write(to: filename)
                                fileItem = FileItem(file: filename)
                                print(filename)
                            }
                            scs?.addSubview(sc)
                        }){
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                        }
                        .padding()
                    }
                    LegacyScrollView{
                                VStack(spacing: 30) {
                                    ForEach(
                                        database.ToDos.sorted(by: { (lhs, rhs) -> Bool in
                                        lhs.date < rhs.date
                                    })
                                    ){item in
                                        HStack(alignment: .top, spacing:30) {
                                                  VStack {
                                                      if item.date < Date() && !item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.red)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.date < Date() && item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.gray)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.isCompleted {
                                                          Image(systemName: "checkmark.circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.green)
                                                              .frame(width: 20, height: 20)
                                                      }else {
                                                          Image(systemName: "circle")
                                                              .resizable()
                                                              .frame(width: 20, height: 20)
                                                      }
                                                      
                                                      HStack {
                                                          Divider()
                                                      }
                                                  }
                                                  
                                                  VStack(alignment: .leading) {
                                                      if item.date<Date() && !item.isCompleted {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                              .foregroundColor(Color.red)
                                                      }else {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                      }
                                                      Text(item.title)
                                                          .font(.title3).bold()
                                                      Text(classifyName[item.classification])
                                                          .font(.body)
                                                          .bold()
                                                          .padding(.bottom)
                                                  }
                                            Spacer()
                                              }
                                              .fixedSize(horizontal: false, vertical: true)
                                              Divider()
                                    }
                                }
                          }
                          .padding()
                          .onTapGesture {
                              otherView = -1
                          }
                }
                .sheet(item: self.$fileItem, content: { one in
                    ShareSheet(activityItems: [one.file])
                })
                
            }else if otherView == 1 {
                VStack{
                    HStack{
                        Text("点击任意处返回")
                            .bold()
                            .padding()
                        Spacer()
                        Button(action:{
                            let scs = sc.superview
                            sc.removeFromSuperview()
                            let image = sc.screenshot()
                            print(image)
                            let filename = getDocumentsDirectory().appendingPathComponent(getCNDate()+".jpg")
                           
                            if let data = image.jpegData(compressionQuality: 0.8) {
                                try? data.write(to: filename)
                                fileItem = FileItem(file: filename)
                                print(filename)
                            }
                            scs?.addSubview(sc)
                        }){
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                        }
                        .padding()
                    }
                    LegacyScrollView{
                                VStack(spacing: 30) {
                                    ForEach(
                                        database.ToDos.filter{$0.classification==1}.sorted(by: { (lhs, rhs) -> Bool in
                                        lhs.date < rhs.date
                                    })
                                    ){item in
                                        HStack(alignment: .top, spacing:30) {
                                                  VStack {
                                                      if item.date < Date() && !item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.red)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.date < Date() && item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.gray)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.isCompleted {
                                                          Image(systemName: "checkmark.circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.green)
                                                              .frame(width: 20, height: 20)
                                                      }else {
                                                          Image(systemName: "circle")
                                                              .resizable()
                                                              .frame(width: 20, height: 20)
                                                      }
                                                      
                                                      HStack {
                                                          Divider()
                                                      }
                                                  }
                                                  
                                                  VStack(alignment: .leading) {
                                                      if item.date<Date() && !item.isCompleted {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                              .foregroundColor(Color.red)
                                                      }else {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                      }

                                                      Text(item.title)
                                                          .font(.title3).bold()
                                                      Text(classifyName[item.classification])
                                                          .font(.body)
                                                          .bold()
                                                          .padding(.bottom)
                                                  }
                                            Spacer()
                                              }
                                              .fixedSize(horizontal: false, vertical: true)
                                              Divider()
                                    }
                                }
                          }
                          .padding()
                          .onTapGesture {
                              otherView = -1
                          }
                }
                .sheet(item: self.$fileItem, content: { one in
                    ShareSheet(activityItems: [one.file])
                })
                
            }else if otherView == 2 {
                VStack{
                    HStack{
                        Text("点击任意处返回")
                            .bold()
                            .padding()
                        Spacer()
                        Button(action:{
                            let scs = sc.superview
                            sc.removeFromSuperview()
                            let image = sc.screenshot()
                            print(image)
                            let filename = getDocumentsDirectory().appendingPathComponent(getCNDate()+".jpg")
                           
                            if let data = image.jpegData(compressionQuality: 0.8) {
                                try? data.write(to: filename)
                                fileItem = FileItem(file: filename)
                                print(filename)
                            }
                            scs?.addSubview(sc)
                        }){
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                        }
                        .padding()
                    }
                    LegacyScrollView{
                                VStack(spacing: 30) {
                                    ForEach(
                                        database.ToDos.filter{$0.classification==2}.sorted(by: { (lhs, rhs) -> Bool in
                                        lhs.date < rhs.date
                                    })
                                    ){item in
                                        HStack(alignment: .top, spacing:30) {
                                                  VStack {
                                                      if item.date < Date() && !item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.red)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.date < Date() && item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.gray)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.isCompleted {
                                                          Image(systemName: "checkmark.circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.green)
                                                              .frame(width: 20, height: 20)
                                                      }else {
                                                          Image(systemName: "circle")
                                                              .resizable()
                                                              .frame(width: 20, height: 20)
                                                      }
                                                      
                                                      HStack {
                                                          Divider()
                                                      }
                                                  }
                                                  
                                                  VStack(alignment: .leading) {
                                                      if item.date<Date() && !item.isCompleted {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                              .foregroundColor(Color.red)
                                                      }else {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                      }

                                                      Text(item.title)
                                                          .font(.title3).bold()
                                                      Text(classifyName[item.classification])
                                                          .font(.body)
                                                          .bold()
                                                          .padding(.bottom)
                                                  }
                                            Spacer()
                                              }
                                              .fixedSize(horizontal: false, vertical: true)
                                              Divider()
                                    }
                                }
                          }
                          .padding()
                          .onTapGesture {
                              otherView = -1
                          }
                }
                .sheet(item: self.$fileItem, content: { one in
                    ShareSheet(activityItems: [one.file])
                })
                
            }else if otherView == 3 {
                VStack{
                    HStack{
                        Text("点击任意处返回")
                            .bold()
                            .padding()
                        Spacer()
                        Button(action:{
                            let scs = sc.superview
                            sc.removeFromSuperview()
                            let image = sc.screenshot()
                            print(image)
                            let filename = getDocumentsDirectory().appendingPathComponent(getCNDate()+".jpg")
                            if let data = image.jpegData(compressionQuality: 0.8) {
                                try? data.write(to: filename)
                                fileItem = FileItem(file: filename)
                                print(filename)
                            }
                            scs?.addSubview(sc)
                        }){
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                        }
                        .padding()
                    }
                    LegacyScrollView{
                                VStack(spacing: 30) {
                                    ForEach(
                                        database.ToDos.filter{$0.classification==3}.sorted(by: { (lhs, rhs) -> Bool in
                                        lhs.date < rhs.date
                                    })
                                    ){item in
                                        HStack(alignment: .top, spacing:30) {
                                                  VStack {
                                                      if item.date < Date() && !item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.red)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.date < Date() && item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.gray)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.isCompleted {
                                                          Image(systemName: "checkmark.circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.green)
                                                              .frame(width: 20, height: 20)
                                                      }else {
                                                          Image(systemName: "circle")
                                                              .resizable()
                                                              .frame(width: 20, height: 20)
                                                      }
                                                      
                                                      HStack {
                                                          Divider()
                                                      }
                                                  }
                                                  
                                                  VStack(alignment: .leading) {
                                                      if item.date<Date() && !item.isCompleted {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                              .foregroundColor(Color.red)
                                                      }else {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                      }

                                                      Text(item.title)
                                                          .font(.title3).bold()
                                                      Text(classifyName[item.classification])
                                                          .font(.body)
                                                          .bold()
                                                          .padding(.bottom)
                                                  }
                                            Spacer()
                                              }
                                              .fixedSize(horizontal: false, vertical: true)
                                              Divider()
                                    }
                                }
                          }
                          .padding()
                          .onTapGesture {
                              otherView = -1
                          }
                }
                .sheet(item: self.$fileItem, content: { one in
                    ShareSheet(activityItems: [one.file])
                })
                
            }else if otherView == 4 {
                VStack{
                    HStack{
                        Text("点击任意处返回")
                            .bold()
                            .padding()
                        Spacer()
                        Button(action:{
                            let scs = sc.superview
                            sc.removeFromSuperview()
                            let image = sc.screenshot()
                            print(image)
                            let filename = getDocumentsDirectory().appendingPathComponent(getCNDate()+".jpg")
                           
                            if let data = image.jpegData(compressionQuality: 0.8) {
                                try? data.write(to: filename)
                                fileItem = FileItem(file: filename)
                                print(filename)
                            }
                            scs?.addSubview(sc)
                        }){
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                        }
                        .padding()
                    }
                    LegacyScrollView{
                                VStack(spacing: 30) {
                                    ForEach(
                                        database.ToDos.filter{$0.classification==4}.sorted(by: { (lhs, rhs) -> Bool in
                                        lhs.date < rhs.date
                                    })
                                    ){item in
                                        HStack(alignment: .top, spacing:30) {
                                                  VStack {
                                                      if item.date < Date() && !item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.red)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.date < Date() && item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.gray)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.isCompleted {
                                                          Image(systemName: "checkmark.circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.green)
                                                              .frame(width: 20, height: 20)
                                                      }else {
                                                          Image(systemName: "circle")
                                                              .resizable()
                                                              .frame(width: 20, height: 20)
                                                      }
                                                      
                                                      HStack {
                                                          Divider()
                                                      }
                                                  }
                                                  
                                                  VStack(alignment: .leading) {
                                                      if item.date<Date() && !item.isCompleted {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                              .foregroundColor(Color.red)
                                                      }else {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                      }

                                                      Text(item.title)
                                                          .font(.title3).bold()
                                                      Text(classifyName[item.classification])
                                                          .font(.body)
                                                          .bold()
                                                          .padding(.bottom)
                                                  }
                                            Spacer()
                                              }
                                              .fixedSize(horizontal: false, vertical: true)
                                              Divider()
                                    }
                                }
                          }
                          .padding()
                          .onTapGesture {
                              otherView = -1
                          }
                }
                .sheet(item: self.$fileItem, content: { one in
                    ShareSheet(activityItems: [one.file])
                })
            }else if otherView == 0 {
                VStack{
                    HStack{
                        Text("点击任意处返回")
                            .bold()
                            .padding()
                        Spacer()
                        Button(action:{
                            let scs = sc.superview
                            sc.removeFromSuperview()
                            let image = sc.screenshot()
                            print(image)
                            let filename = getDocumentsDirectory().appendingPathComponent(getCNDate()+".jpg")
                           
                            if let data = image.jpegData(compressionQuality: 0.8) {
                                try? data.write(to: filename)
                                fileItem = FileItem(file: filename)
                                print(filename)
                            }
                            scs?.addSubview(sc)
                        }){
                            Image(systemName: "square.and.arrow.up")
                                .font(.title)
                        }
                        .padding()
                    }
                    LegacyScrollView{
                                VStack(spacing: 30) {
                                    ForEach(
                                        database.ToDos.filter{$0.classification==0}.sorted(by: { (lhs, rhs) -> Bool in
                                        lhs.date < rhs.date
                                    })
                                    ){item in
                                        HStack(alignment: .top, spacing:30) {
                                                  VStack {
                                                      if item.date < Date() && !item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.red)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.date < Date() && item.isCompleted {
                                                          Image(systemName: "circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.gray)
                                                              .frame(width: 20, height: 20)
                                                      }else if item.isCompleted {
                                                          Image(systemName: "checkmark.circle.fill")
                                                              .resizable()
                                                              .foregroundColor(Color.green)
                                                              .frame(width: 20, height: 20)
                                                      }else {
                                                          Image(systemName: "circle")
                                                              .resizable()
                                                              .frame(width: 20, height: 20)
                                                      }
                                                      
                                                      HStack {
                                                          Divider()
                                                      }
                                                  }
                                                  
                                                  VStack(alignment: .leading) {
                                                      if item.date<Date() && !item.isCompleted {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                              .foregroundColor(Color.red)
                                                      }else {
                                                          Text("DDL: \(getCNDateYMD(Cdate: item.date))")
                                                      }

                                                      Text(item.title)
                                                          .font(.title3).bold()
                                                      Text(classifyName[item.classification])
                                                          .font(.body)
                                                          .bold()
                                                          .padding(.bottom)
                                                  }
                                            Spacer()
                                              }
                                              .fixedSize(horizontal: false, vertical: true)
                                              Divider()
                                    }
                                }
                          }
                          .padding()
                          .onTapGesture {
                              otherView = -1
                          }
                }
                .sheet(item: self.$fileItem, content: { one in
                    ShareSheet(activityItems: [one.file])
                })
                
            }
        }
    }
}
   
extension UIView {
    func screenshot() -> UIImage {
        
        if(self is UIScrollView) {
            let scrollView = self as! UIScrollView
            
            let savedContentOffset = scrollView.contentOffset
            let savedFrame = scrollView.frame
            
            UIGraphicsBeginImageContext(scrollView.contentSize)
            scrollView.contentOffset = .zero
            self.frame = CGRect(x: 0, y: 0, width: scrollView.contentSize.width, height: scrollView.contentSize.height)
            self.layer.render(in: UIGraphicsGetCurrentContext()!)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext();
            
            scrollView.contentOffset = savedContentOffset
            scrollView.frame = savedFrame
            
            return image!
        }
        
        UIGraphicsBeginImageContext(self.bounds.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
}


func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}


struct LegacyScrollView: UIViewRepresentable {
    enum Action {
        case idle
        case offset(x: CGFloat, y: CGFloat, animated: Bool)
    }
    
    @Binding var action: Action
    private let uiScrollView: UIScrollView
    
    init<Content: View>(content: Content) {
        let hosting = UIHostingController(rootView: content)
        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        
        uiScrollView = UIScrollView()
        sc = uiScrollView
        uiScrollView.addSubview(hosting.view)
        
        let constraints = [
            hosting.view.leadingAnchor.constraint(equalTo: uiScrollView.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: uiScrollView.trailingAnchor),
            hosting.view.topAnchor.constraint(equalTo: uiScrollView.contentLayoutGuide.topAnchor),
            hosting.view.bottomAnchor.constraint(equalTo: uiScrollView.contentLayoutGuide.bottomAnchor),
            hosting.view.widthAnchor.constraint(equalTo: uiScrollView.widthAnchor)
        ]
        uiScrollView.addConstraints(constraints)
        
        self._action = Binding.constant(Action.idle)
    }
    
    init<Content: View>(@ViewBuilder content: () -> Content) {
        self.init(content: content())
    }
    
    init<Content: View>(action: Binding<Action>, @ViewBuilder content: () -> Content) {
        self.init(content: content())
        self._action = action
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> UIScrollView {
        return uiScrollView
    }
    
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        switch self.action {
        case .offset(let x, let y, let animated):
            uiView.setContentOffset(CGPoint(x: x, y: y), animated: animated)
            DispatchQueue.main.async {
                self.action = .idle
            }
        default:
            break
        }
    }
    
    class Coordinator: NSObject {
        let legacyScrollView: LegacyScrollView
        
        init(_ legacyScrollView: LegacyScrollView) {
            self.legacyScrollView = legacyScrollView
        }
    }
    
}


struct ShareSheet: UIViewControllerRepresentable {
    typealias Callback = (_ activityType: UIActivity.ActivityType?, _ completed: Bool, _ returnedItems: [Any]?, _ error: Error?) -> Void

    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    let excludedActivityTypes: [UIActivity.ActivityType]? = nil
    let callback: Callback? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(
            activityItems: activityItems,
            applicationActivities: applicationActivities)
        controller.excludedActivityTypes = excludedActivityTypes
        controller.completionWithItemsHandler = callback
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // nothing to do here
    }
}


struct UsersColorView: View {
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    HStack{
                        Button(action:{}){
                            Image(systemName: "circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 124/255, green: 77/255, blue: 255/255))
                        }
                        .padding()
                        Button(action:{}){
                            Image(systemName: "circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 141/255, green: 110/255, blue: 99/255))
                        }
                        .padding()
                        Button(action:{}){
                            Image(systemName: "circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 158/255, green: 157/255, blue: 36/255))
                        }
                        .padding()
                        Button(action:{}){
                            Image(systemName: "circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 0/255, green: 131/255, blue: 143/255))
                        }
                        .padding()
                        Button(action:{}){
                            Image(systemName: "circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(Color(red: 173/255, green: 20/255, blue: 87/255))
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
            .navigationTitle(Text("选择您喜欢的颜色主题"))
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}


struct FeedBackView: View {
    
    @Environment(\.openURL) var openURL
    
    let QQGroupUrl = URL(string: "mqqapi://card/show_pslcard?src_type=internal&version=1&uin=481242552&key=44a6e01f2dab126f87ecd2ec7b7e66ae259b30535fd0c2c25776271e8c0ac08f&card_type=group&source=external")!

    
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    Form{
                        if #available(iOS 15.0, *) {
                            Section("QQ反馈渠道"){
                                Text("QQ群：481242552")
                                Button("点击加入反馈群聊"){
                                    openURL.callAsFunction(QQGroupUrl){ result in
                                        print(result)
                                    }
                                }
                            }
                            Section("其他渠道"){
                                Text("AppStore评论")
                            }
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                }
            }
            .navigationTitle(Text("反馈问题给开发者"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}




func getCNDate()-> String {
    let dformatter = DateFormatter()
    
    dformatter.dateFormat = "yyyyMMddHHmmss"
    
    let datestr = dformatter.string(from: Date())
    return datestr
    
}

struct MyCenter_Previews: PreviewProvider {
    static var previews: some View {
        MyCenter()
            .environmentObject(UserStore())
    }
}

