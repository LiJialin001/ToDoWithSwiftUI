//
//  shakeSheetView.swift
//  shakeSheetView
//
//  Created by 李佳林 on 2021/9/3.
//

import Foundation
import SwiftUI

struct shakeSheetView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var database: ToDoStore
    @Binding var shakePage: Bool
    var body: some View {
        ZStack{
            if !database.ToDos.filter{!$0.isCompleted}.isEmpty {
                VStack{
                    HStack{
                        Text("摇一摇抽取待办")
                            .font(.system(size: 25, weight: .bold, design: .default))
                        Spacer()
                        Button(action: {
                            shakePage = false
                        }, label: {
                            if colorScheme == .dark {
                                Image(systemName: "xmark")
                                    .imageScale(.small)
                                    .frame(width: 32, height: 32)
                                    .background(Color.white.opacity(0.06))
                                    .cornerRadius(16)
                                    .foregroundColor(.white)
                            }else {
                                Image(systemName: "xmark")
                                    .imageScale(.small)
                                    .frame(width: 32, height: 32)
                                    .background(Color.black.opacity(0.06))
                                    .cornerRadius(16)
                                    .foregroundColor(.black)
                            }
                        })
                    }
                    .padding()
                    List{
                        ToDoItemRowForCrate(item: database.ToDos.filter{!$0.isCompleted}.randomElement()!)
                    }
                    .listStyle(.plain)
                    HStack{
                        Text("快去完成吧！")
                            .font(.system(size: 25, weight: .bold, design: .default))
                        Spacer()
                    }
                    .padding()
                    Spacer()
                }
            }else {
                VStack{
                    HStack{
                        Text("暂无待办")
                            .font(.system(size: 25, weight: .bold, design: .default))
                        Spacer()
                        Button(action: {
                            shakePage = false
                        }, label: {
                            if colorScheme == .dark {
                                Image(systemName: "xmark")
                                    .imageScale(.small)
                                    .frame(width: 32, height: 32)
                                    .background(Color.white.opacity(0.06))
                                    .cornerRadius(16)
                                    .foregroundColor(.white)
                            }else {
                                Image(systemName: "xmark")
                                    .imageScale(.small)
                                    .frame(width: 32, height: 32)
                                    .background(Color.black.opacity(0.06))
                                    .cornerRadius(16)
                                    .foregroundColor(.black)
                            }
                        })
                    }
                    .padding()
                    Spacer()
                    Image(systemName: "tray.fill")
                        .font(.system(size: 70))
                    Text("您还没有待办，快去创建吧！")
                        .font(.system(size: 25, weight: .bold, design: .default))
                        .padding()
                }
                
            }
            
        }
        .frame(height: 300)
        .padding()
    }
}

