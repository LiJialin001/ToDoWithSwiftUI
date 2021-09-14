//
//  AddPopupView.swift
//  AddPopupView
//
//  Created by 李佳林 on 2021/8/29.
//

import Foundation
import SwiftUI

struct AddPopupView: View {
    @EnvironmentObject var database: ToDoStore
    @Environment(\.colorScheme) var colorScheme
    @Binding var isPresented: Bool
    @State var whichOneButton = 1
    @State var classify = 0
    @State var loopTime = 2
    @State var priority = 0
    @State var isStop = false
    @State var isLoop = false
    @State var date2 = Date()
    @State var title = ""
    @State private var date = Date()
    var body: some View {
            VStack(alignment: .leading, spacing: 16) {
                HStack{
                    Text("建立新待办")
                        .font(.system(size: 25, weight: .bold, design: .default))
                    Spacer()
                    Button(action: {
                        isPresented = false
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
                HStack(spacing:20) {
                    Button(action:{
                        UIApplication.shared.endEditing()
                        Haptics.giveSmallHaptic()
                        whichOneButton = 1
                    }){
                        Image(systemName: whichOneButton==1 ? "bookmark.circle.fill" : "bookmark.circle")
                            .font(.system(size: 30))
                    }
                    Button(action:{
                        UIApplication.shared.endEditing()
                        Haptics.giveSmallHaptic()
                        whichOneButton = 2
                    }){
                        Image(systemName: whichOneButton==2 ? "calendar.circle.fill" : "calendar.circle")
                            .font(.system(size: 30))
                    }
                    Button(action:{
                        UIApplication.shared.endEditing()
                        Haptics.giveSmallHaptic()
                        whichOneButton = 3
                    }){
                        Image(systemName: whichOneButton==3 ? "repeat.circle.fill" : "repeat.circle")
                            .font(.system(size: 30))
                    }
                    Button(action:{
                        UIApplication.shared.endEditing()
                        Haptics.giveSmallHaptic()
                        whichOneButton = 5
                    }){
                        Image(systemName: whichOneButton==5 ? "flag.circle.fill" : "flag.circle")
                            .font(.system(size: 30))
                    }
                    Spacer()
                    Button(action:{
                        UIApplication.shared.endEditing()
                        isPresented = false
                        if title != "" {
                            Haptics.simpleSuccess()
                            self.database.ToDos.append(ToDoItem(title: self.title, priorityLevel: self.priority ,classification: self.classify, date: self.date, lastDate: self.date2, isPersonal: true, isLoop: isLoop ,isStop: isStop, cyclePeriod: loopTime))
                        }
                    }){
                        Image(systemName: "capslock")
                            .font(.system(size: 30))
                    }
                }
                TextField("待办名称", text: $title)
                    .frame(height: 36)
                    .padding([.leading, .trailing], 10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                if whichOneButton==1 {
                    VStack{
                        Spacer()
                        HStack{
                            Button(action:{
                                UIApplication.shared.endEditing()
                                Haptics.giveSmallHaptic()
                                if classify==1 {
                                    classify = 0
                                }else {
                                    classify = 1
                                }
                            }){
                                if classify==1 {
                                    if #available(iOS 15.0, *) {
                                        ButtonCards(category: "学习", ImageString: "graduationcap.fill", color: Color.indigo)
                                    } else {
                                        ButtonCards(category: "学习", ImageString: "graduationcap.fill", color: Color.blue)
                                    }
                                }else {
                                    if colorScheme == .dark {
                                        ButtonCards(category: "学习", ImageString: "graduationcap", color: Color.white)
                                    }else {
                                        ButtonCards(category: "学习", ImageString: "graduationcap", color: Color.black)
                                    }
                                    
                                }
                            }
                            .padding()
                            Button(action:{
                                UIApplication.shared.endEditing()
                                Haptics.giveSmallHaptic()
                                if classify==3 {
                                    classify = 0
                                }else {
                                    classify = 3
                                }
                            }){
                                if classify==3 {
                                    if #available(iOS 15.0, *) {
                                        ButtonCards(category: "娱乐", ImageString: "gamecontroller.fill", color: Color.indigo)
                                    } else {
                                        ButtonCards(category: "娱乐", ImageString: "gamecontroller.fill", color: Color.blue)
                                    }
                                }else {
                                    if colorScheme == .dark {
                                        ButtonCards(category: "娱乐", ImageString: "gamecontroller", color: Color.white)
                                    } else {
                                        ButtonCards(category: "娱乐", ImageString: "gamecontroller", color: Color.black)
                                    }
                                }
                            }
                            .padding()
                            
                        }
                        HStack{
                            Button(action:{
                                UIApplication.shared.endEditing()
                                Haptics.giveSmallHaptic()
                                if classify==2 {
                                    classify = 0
                                }else {
                                    classify = 2
                                }
                            }){
                                if classify==2{
                                    if #available(iOS 15.0, *) {
                                        ButtonCards(category: "生活", ImageString: "paintpalette.fill", color: Color.indigo)
                                    } else {
                                        ButtonCards(category: "生活", ImageString: "paintpalette.fill", color: Color.blue)
                                    }
                                }else {
                                    if colorScheme == .dark {
                                        ButtonCards(category: "生活", ImageString: "paintpalette", color: Color.white)
                                    }else {
                                        ButtonCards(category: "生活", ImageString: "paintpalette", color: Color.black)
                                    }
                                    
                                }
                                
                            }
                            .padding()
                            Button(action:{
                                UIApplication.shared.endEditing()
                                Haptics.giveSmallHaptic()
                                if classify==4 {
                                    classify = 0
                                }else {
                                    classify = 4
                                }
                            }){
                                if classify==4 {
                                    if #available(iOS 15.0, *) {
                                        ButtonCards(category: "工作", ImageString: "tv.fill", color: Color.indigo)
                                    } else {
                                        ButtonCards(category: "工作", ImageString: "tv.fill", color: Color.blue)
                                    }
                                }else {
                                    if colorScheme == .dark {
                                        ButtonCards(category: "工作", ImageString: "tv", color: Color.white)
                                    }else {
                                        ButtonCards(category: "工作", ImageString: "tv", color: Color.black)
                                    }
                                    
                                }
                            }
                            .padding()
                        }
                    }
                    
                    
                }else if whichOneButton==2 {
                    VStack{
                        Spacer()
                        Text("设置此待办的DDL")
                            .font(.title2.bold())
                            .padding()
                        DatePicker2(date: $date)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                            .padding()
                    }
                }else if whichOneButton==3 {
                    if isLoop{
                        VStack{
                            HStack{
                                Text("设置循环时间")
                                    .font(.body.smallCaps())
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            HStack{
                                Spacer()
                                Button(action:{
                                    Haptics.giveSmallHaptic()
                                    loopTime = 1
                                }){
                                    if loopTime==1 {
                                        if #available(iOS 15.0, *) {
                                            ButtonCards2(category: "每月", color: .indigo)
                                        } else {
                                            ButtonCards2(category: "每月", color: .blue)
                                        }
                                    }else {
                                        if colorScheme == .dark {
                                            ButtonCards2(category: "每月", color: .white)
                                        }else {
                                            ButtonCards2(category: "每月", color: .black)
                                        }
                                        
                                    }
                                }
                                Spacer()
                                Button(action:{
                                    Haptics.giveSmallHaptic()
                                    loopTime = 2
                                }){
                                    if loopTime==2 {
                                        if #available(iOS 15.0, *) {
                                            ButtonCards2(category: "每周", color: .indigo)
                                        } else {
                                            ButtonCards2(category: "每周", color: .blue)
                                        }
                                    }else {
                                        if colorScheme == .dark {
                                            ButtonCards2(category: "每周", color: .white)
                                        }else {
                                            ButtonCards2(category: "每周", color: .black)
                                        }
                                    }
                                }
                                Spacer()
                                Button(action:{
                                    Haptics.giveSmallHaptic()
                                    loopTime = 3
                                }){
                                    if loopTime==3 {
                                        if #available(iOS 15.0, *) {
                                            ButtonCards2(category: "每日", color: .indigo)
                                        } else {
                                            ButtonCards2(category: "每日", color: .blue)
                                        }
                                    }else {
                                        if colorScheme == .dark {
                                            ButtonCards2(category: "每日", color: .white)
                                        }else {
                                            ButtonCards2(category: "每日", color: .black)
                                        }
                                    }
                                }
                                Spacer()
                            }
                            Spacer()
                            HStack{
                                Text("设置循环截止日期")
                                    .font(.body.smallCaps())
                                    .foregroundColor(.secondary)
                                Spacer()
                            }
                            HStack{
                                Button(action:{
                                    Haptics.giveSmallHaptic()
                                    isStop.toggle()
                                }){
                                    if isStop {
                                        if colorScheme == .dark {
                                            ButtonCards2(category: "截止：", color: .white)
                                        }else {
                                            ButtonCards2(category: "截止：", color: .black)
                                        }
                                    }else {
                                        if #available(iOS 15.0, *) {
                                            ButtonCards2(category: "不截止", color: .indigo)
                                        } else {
                                            ButtonCards2(category: "不截止", color: .blue)
                                        }
                                    }
                                }
                                if isStop {
                                    DatePicker2(date: $date2)
                                }
                            }
                            HStack{
                                Text("设置循环")
                                    .font(.body.smallCaps())
                                    .foregroundColor(.secondary)
                                Spacer()
                                Button(action:{
                                    Haptics.giveSmallHaptic()
                                    isLoop = false
                                }){
                                    Text("不循环")
                                }
                            }
                        }
                    }else {
                        HStack{
                            Text("设置循环")
                                .font(.body.smallCaps())
                                .foregroundColor(.secondary)
                            Spacer()
                            Button(action:{
                                Haptics.giveSmallHaptic()
                                isLoop = true
                            }){
                                Text("设置循环")
                            }
                        }
                    }
                }else if whichOneButton==5 {
                    VStack{
                    //    Spacer()
                        HStack{
                            Text("设置优先级")
                                .font(.body.smallCaps())
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        Spacer()
                        Button(action:{
                            Haptics.giveSmallHaptic()
                            if priority==1 {
                                priority = 0
                            }else {
                                priority = 1
                            }
                        }){
                            if priority==1 {
                                if #available(iOS 15.0, *) {
                                    ButtonCards3(imageName: "1.square.fill", category: "重要且紧急", color: .indigo)
                                } else {
                                    ButtonCards3(imageName: "1.square.fill", category: "重要且紧急", color: .blue)
                                }
                            }else {
                                if colorScheme == .dark {
                                    ButtonCards3(imageName: "1.square", category: "重要且紧急", color: .white)
                                }else {
                                    ButtonCards3(imageName: "1.square", category: "重要且紧急", color: .black)
                                }
                            }
                        }
                        Button(action:{
                            Haptics.giveSmallHaptic()
                            if priority==2 {
                                priority = 0
                            }else {
                                priority = 2
                            }
                        }){
                            if priority==2 {
                                if #available(iOS 15.0, *) {
                                    ButtonCards3(imageName: "2.square.fill", category: "重要且不紧急", color: .indigo)
                                } else {
                                    ButtonCards3(imageName: "2.square.fill", category: "重要且不紧急", color: .blue)
                                }
                            }else {
                                if colorScheme == .dark {
                                    ButtonCards3(imageName: "2.square", category: "重要且不紧急", color: .white)
                                }else {
                                    ButtonCards3(imageName: "2.square", category: "重要且不紧急", color: .black)
                                }
                            }
                        }
                        Button(action:{
                            Haptics.giveSmallHaptic()
                            if priority==3 {
                                priority = 0
                            }else {
                                priority = 3
                            }
                        }){
                            if priority==3 {
                                if #available(iOS 15.0, *) {
                                    ButtonCards3(imageName: "3.square.fill", category: "不重要且紧急", color: .indigo)
                                } else {
                                    ButtonCards3(imageName: "3.square.fill", category: "不重要且紧急", color: .blue)
                                }
                            }else {
                                if colorScheme == .dark {
                                    ButtonCards3(imageName: "3.square", category: "不重要且紧急", color: .white)
                                }else {
                                    ButtonCards3(imageName: "3.square", category: "不重要且紧急", color: .black)
                                }
                            }
                        }
                        Button(action:{
                            Haptics.giveSmallHaptic()
                            if priority==4 {
                                priority = 0
                            }else {
                                priority = 4
                            }
                        }){
                            if priority==4 {
                                if #available(iOS 15.0, *) {
                                    ButtonCards3(imageName: "4.square.fill", category: "不重要且不紧急", color: .indigo)
                                } else {
                                    ButtonCards3(imageName: "4.square.fill", category: "不重要且不紧急", color: .blue)
                                }
                            }else {
                                if colorScheme == .dark {
                                    ButtonCards3(imageName: "4.square", category: "不重要且不紧急", color: .white)
                                }else {
                                    ButtonCards3(imageName: "4.square", category: "不重要且不紧急", color: .black)
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .frame(height: 400)
            .padding()
    }
}


struct AddPopupView_Previews: PreviewProvider {
    static var previews: some View {
        AddPopupView(isPresented: .constant(true))
            .previewLayout(.sizeThatFits)
    }
}

