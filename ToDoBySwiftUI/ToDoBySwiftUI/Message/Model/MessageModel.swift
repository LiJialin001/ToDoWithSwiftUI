//
//  MessageModel.swift
//  ToDowithSwiftUI
//
//  Created by 李佳林 on 2021/8/13.
//

import SwiftUI
import Combine


struct MessageItem: Identifiable, Equatable, Codable {
    var id = UUID()
    var title: String = "New Message"
    var mainMessage = ""
    var itsTeam: TeamItem
    var classification: Int = 0
    var date: Date = Date()
    var isRead = false
    var isPass = false
    var isJudge = false
}

var MessageClassify = ["通知", "待办", "验证"]

struct MessageRow:View {
    @Environment(\.editMode) var editMode
    @EnvironmentObject var databaseMessage: MessageStore
    
    @State var showAlert1 = false
    @State var showAlert2 = false

    @State var DetailItem: MessageItem
    var item: MessageItem
    
    func getCNDateMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    
    var body: some View {
        if item.classification != 2 {
            ZStack{
                VStack(alignment:.leading, spacing: 0){
                    HStack{
                        if #available(iOS 15.0, *) {
                            ZStack{
                                Text(MessageClassify[item.classification])
                                    .font(.footnote)
                                    .padding(5)
                                    .background(Color.indigo)
                                    .cornerRadius(10)
                                    .foregroundColor(Color.white)
                            }
                            
                        } else {
                            Text(MessageClassify[item.classification])
                                .font(.footnote)
                                .padding(5)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .foregroundColor(Color.white)
                        }
                        Text(item.title)
                            .font(.body)
                            .padding(5)
                        Spacer()
                        Text(getCNDateMD(Cdate: item.date))
                            .font(.footnote)
                            .padding(5)
                        Spacer()
                    }
                    Text("内容：\(item.mainMessage)")
                        .font(.footnote)
                        .frame(width: 250, height: 45,alignment: .leading)
                        .lineLimit(250)
                        .padding(5)
                }
                VStack{
                    HStack{
                        Spacer()
                        if !item.isRead {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 6))
                                .foregroundColor(Color.red)
                                .padding(2)
                        }
                    }
                    Spacer()
                }
            }
            .contentShape(Rectangle())
            

        }else {
            ZStack {
                VStack(alignment:.leading, spacing: 0){
                    HStack{
                        if #available(iOS 15.0, *) {
                            Text(MessageClassify[item.classification])
                                .font(.footnote)
                                .padding(5)
                                .background(Color.indigo)
                                .cornerRadius(10)
                                .foregroundColor(Color.white)
                        } else {
                            Text(MessageClassify[item.classification])
                                .font(.footnote)
                                .padding(5)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .foregroundColor(Color.white)
                        }
                        Text(item.title)
                            .font(.body)
                            .padding(5)
                        Text(getCNDateMD(Cdate: item.date))
                            .font(.footnote)
                            .padding(5)
                        Spacer()
                    }
                    Text("内容：\(item.mainMessage)")
                        .font(.body)
                        .frame(width: 250, height: 45,alignment: .leading)
                        .lineLimit(250)
                        .padding(5)
                    if !item.isJudge {
                        HStack{
                            Spacer()
                                
                            Text("拒绝")
                                .foregroundColor(Color.blue)
                                .onTapGesture {
                                    showAlert1.toggle()
                                }
                                .alert(isPresented: $showAlert1) {
                                    Alert(title: Text("提示"), message: Text("确定要拒绝邀请吗"), primaryButton: .default(Text("确定"), action: {
                                        DetailItem.isPass = false
                                        DetailItem.isJudge = true
                                        DetailItem.isRead = true
                                        self.databaseMessage.Messages[self.databaseMessage.Messages.firstIndex(of: self.item) ?? 0] = DetailItem
                                    }), secondaryButton: .destructive(Text("取消")))
                                }
                                .padding()
                            Spacer()
                            Divider()
                            Spacer()
                                Text("同意")
                                .foregroundColor(Color.blue)
                                .onTapGesture {
                                    showAlert2.toggle()
                                }
                                .alert(isPresented: $showAlert2) {
                                    Alert(title: Text("提示"), message: Text("确定要接受邀请吗"), primaryButton: .default(Text("确定"), action: {
                                        DetailItem.isPass = true
                                        DetailItem.isJudge = true
                                        DetailItem.isRead = true
                                        self.databaseMessage.Messages[self.databaseMessage.Messages.firstIndex(of: self.item) ?? 0] = DetailItem
                                    }), secondaryButton: .destructive(Text("取消")))
                                }
                                .padding()
                            Spacer()
                        }
                    }else {
                        HStack{
                            Spacer()
                            if item.isPass {
                                Text("已同意")
                                    .font(.footnote)
                            }else {
                                Text("已拒绝")
                                    .font(.footnote)
                            }
                        }
                    }
                    
                }
                VStack{
                    HStack{
                        Spacer()
                        if !item.isRead {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 6))
                                .foregroundColor(Color.red)
                                .onTapGesture {
                                    self.databaseMessage.Messages[self.databaseMessage.Messages.firstIndex(of: self.item)!].isRead = true
                                }
                                .padding(1)
                        }
                    }
                    Spacer()
                }
            }.contentShape(Rectangle())
        }
                
    }
}




class MessageStore: ObservableObject {
    @Published var Messages: [MessageItem] = []{
        didSet {
            if let data = try? JSONEncoder().encode(Messages){
                UserDefaults.standard.set(data, forKey: "Message")
            }
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Message") {
            if let Messages = try? JSONDecoder().decode([MessageItem].self, from: data){
                self.Messages = Messages
            }
        }
    }
}




