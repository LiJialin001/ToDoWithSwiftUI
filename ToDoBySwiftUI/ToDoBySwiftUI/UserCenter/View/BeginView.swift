//
//  AddToDo.swift
//  AddToDo
//
//  Created by 李佳林 on 2021/8/4.
//

import SwiftUI

struct BeginView: View {
    @EnvironmentObject var database: UserStore
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    @State var account = ""
    @State var StudentName = ""
    @State var password = ""
    @State var judgr = 1
    @State var accountInfo = AccountInfo(message: "", result: AccountResult(userNumber: "", nickname: "", telephone: "", email: "", token: "", role: "", realname: "", gender: "", department: "", major: "", stuType: "", avatar: "", campus: ""),code: 4)
    func register() { print("注册新账号") }

    
    var body: some View {
        NavigationView{
        VStack{
            HStack{
                Text("使用天外天账号登录")
                    .font(.system(size: 25))
                    .padding()
                Image("twt")
                    .resizable()
                    .frame(width: 35, height: 35)
                Spacer()
            }
            HStack{
                TextField("学号/手机号/邮箱/用户名", text: $account)
                         .foregroundColor(.primary)
                         .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                         .foregroundColor(.secondary)
                         .background(Color(.secondarySystemBackground))
                         .cornerRadius(20)
                         .padding()
            }
            SecureField("密码", text: $password)
                .foregroundColor(.primary)
                .padding(EdgeInsets(top: 20, leading: 10, bottom: 20, trailing: 10))
                .foregroundColor(.secondary)
                .background(Color(.secondarySystemBackground))
                .cornerRadius(20.0)
                .padding()
                
                 HStack {
                     Button(action:{}){
                         Text("注册天外天账号")
                             .font(.footnote)
                     }
                     .padding()
                     Spacer()
                     Button(action:{}){
                         Text("以游客身份使用")
                             .font(.footnote)
                     }
                     .padding()
                    
                 }
            Spacer()
                if #available(iOS 15.0, *) {
                    Button(action: {
                        LgLoginManager.LoginPost(account: account, password: password, completion: {
                            result in
                                switch result {
                                case .success(let data):
                                    accountInfo = data
                                    print(data)
                                    print(accountInfo)
                                    self.database.Users.removeAll()
                                    self.database.Users.append(UserItem(name: accountInfo.result.realname, StudentNumber: accountInfo.result.userNumber, Password: password))
                                case .failure(let error):
                                    print(error.message)
                                    password = ""
                                }
                                })
                    }, label: {
                        HStack {
                            Text("登录")
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
            Spacer()
        }.navigationBarTitleDisplayMode(.inline)
    }
    }
}



//struct BeginView_Previews: PreviewProvider {
//    static var previews: some View{
//        BeginView()
//            .environmentObject(UserStore())
//    }
//}

