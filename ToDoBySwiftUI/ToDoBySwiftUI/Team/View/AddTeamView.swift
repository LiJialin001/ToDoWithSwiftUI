//
//  AddTeamView.swift
//  AddTeamView
//
//  Created by 李佳林 on 2021/8/20.
//

import Foundation
import SwiftUI
import Combine

struct AddTeamView: View {
    @EnvironmentObject var databaseTeam: TeamStore
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    @State var addName = ""
    @State var addSynopsis = ""
    @State var searchTerm = ""
    @State var showCancelButton: Bool = false
    @State var teamInfo = TeamInfo(message: "", code: 4)
    @Binding var newTeamOpen: Bool
    
    @available (iOSApplicationExtension, unavailable)
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    Spacer()
                    HStack{
                        Text("创建团队")
                            .padding()
                        Spacer()
                        Button(action:{
                            newTeamOpen = false
                        }){
                            Image(systemName: "multiply")
                                .font(.title)
                        }
                        .padding()
                    }
                    
                    HStack{
                        Text("团队名称：")
                            .padding()
                        TextField("不得超过十个字符", text: $addName)
                            .padding()
                    }
                    HStack{
                        Text("团队简介：")
                            .padding()
                        TextField("不得超过五十个字符", text: $addSynopsis)
                            .padding()
                    }
                    HStack{
                        Text("邀请成员：")
                            .padding()
                        Spacer()
                        Button(action:{}){
                            Text("导入名单")
                        }
                        .padding()
                    }
                    HStack{
                        Spacer()
                        HStack {
                            Image(systemName: "magnifyingglass")
                            TextField("姓名/学号", text: $searchTerm, onEditingChanged: {
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
                        Spacer()
                    }
                    List{
                        HStack{
                            Text("name + StudentID")
                        }
                        
                    }
                    
                    if #available(iOS 15.0, *) {
                        Button(action: {
                            if addName != "" {
                                CreateTeamManager.TeamPost(teamName: addName, teamDescription: addSynopsis,  completion: {
                                    result in
                                    switch result {
                                    case .success(let data):
                                        teamInfo = data
                                        print(data)
                                        print(teamInfo)
                                        self.databaseTeam.Teams.append(TeamItem(name: self.addName, synopsis: self.addSynopsis, isMyTeam: true, theBoss: "Boss"))
                                    case.failure(let error):
                                        print(error.message)
                                    }
                                })
                                self.databaseTeam.Teams.append(TeamItem(name: self.addName, synopsis: self.addSynopsis, isMyTeam: true, theBoss: "Boss"))
                            }
                            withAnimation {
                                newTeamOpen = false
                            }
                        }, label: {
                            HStack {
                                Text("建立团队")
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
    
}



struct AddTeamView_Previews: PreviewProvider {
 //   @Namespace static var namespace
    static var previews: some View {
  //      if #available(iOS 15.0, *) {
            AddTeamView(newTeamOpen: .constant(false))
                .environmentObject(TeamStore())
//        } else {
            // Fallback on earlier versions
 //       }
    }
}
