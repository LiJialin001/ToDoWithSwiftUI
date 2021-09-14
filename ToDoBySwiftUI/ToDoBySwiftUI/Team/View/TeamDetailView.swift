//
//  TeamDetailView.swift
//  TeamDetailView
//
//  Created by 李佳林 on 2021/8/24.
//

import Foundation
import SwiftUI


struct TeamDetailView: View {
    
    @State var searchTerm = ""
    @State var showCancelButton = false
    
    var item: TeamItem
    
    var body: some View {
        VStack{
            HStack{
                Text("简介：\(item.synopsis)")
                    .font(.body)
                    .padding()
                Spacer()
            }
            
            
            HStack{
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("团队成员", text: $searchTerm, onEditingChanged: {
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
      //      .listStyle(<#T##style: ListStyle##ListStyle#>)
            
        }
    }
}
