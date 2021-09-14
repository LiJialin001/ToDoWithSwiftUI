//
//  DetailPopView.swift
//  DetailPopView
//
//  Created by 李佳林 on 2021/8/31.
//
import Foundation
import SwiftUI

struct DetailPopView: View {
    @EnvironmentObject var database: ToDoStore
    @Environment(\.colorScheme) var colorScheme
    @Binding var DetailPopOpen: Bool
    @State var whichOneButton = 1
    @State var DetailItem: ToDoItem
    @State var choosePerson = false
    @Binding var showAlert: Bool
    var item: ToDoItem
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 16) {
                HStack{
                    Text("更改待办内容")
                        .font(.system(size: 25, weight: .bold, design: .default))
                    Spacer()
                    Button(action: {
                        DetailPopOpen = false
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
                    if DetailItem.Team != nil {
                        Button(action:{
                            UIApplication.shared.endEditing()
                            Haptics.giveSmallHaptic()
                            choosePerson = true
                        }){
                            Image(systemName: "person.crop.circle.badge.plus")
                                .font(.system(size: 30))
                        }

                    }
                    Spacer()
                    Button(action:{
                        UIApplication.shared.endEditing()
                        DetailPopOpen = false
                        if DetailItem.title != "" {
                            showAlert.toggle()
                            Haptics.simpleSuccess()
                            self.database.ToDos[self.database.ToDos.firstIndex(of: self.item) ?? 0] = DetailItem
                        }
                    }){
                        Image(systemName: "capslock")
                            .font(.system(size: 30))
                    }
                }
                TextField(DetailItem.title, text: $DetailItem.title)
                    .frame(height: 36)
                    .padding([.leading, .trailing], 10)
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                if whichOneButton==1 {
                    VStack{
                        Spacer()
                        HStack{
                            Button(action:{
                                Haptics.giveSmallHaptic()
                                if DetailItem.classification==1 {
                                    DetailItem.classification = 0
                                }else {
                                    DetailItem.classification = 1
                                }
                            }){
                                if DetailItem.classification==1 {
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
                                Haptics.giveSmallHaptic()
                                if DetailItem.classification==3 {
                                    DetailItem.classification = 0
                                }else {
                                    DetailItem.classification = 3
                                }
                            }){
                                if DetailItem.classification==3 {
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
                                Haptics.giveSmallHaptic()
                                if DetailItem.classification==2 {
                                    DetailItem.classification = 0
                                }else {
                                    DetailItem.classification = 2
                                }
                            }){
                                if DetailItem.classification==2{
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
                                Haptics.giveSmallHaptic()
                                if DetailItem.classification==4 {
                                    DetailItem.classification = 0
                                }else {
                                    DetailItem.classification = 4
                                }
                            }){
                                if DetailItem.classification==4 {
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
                        DatePicker2(date: $DetailItem.date)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 10)
                            .padding()
                    }
                }else if whichOneButton==3 {
                    if DetailItem.isLoop{
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
                                    DetailItem.cyclePeriod = 1
                                }){
                                    if DetailItem.cyclePeriod==1 {
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
                                    DetailItem.cyclePeriod = 2
                                }){
                                    if DetailItem.cyclePeriod==2 {
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
                                    DetailItem.cyclePeriod = 3
                                }){
                                    if DetailItem.cyclePeriod==3 {
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
                                    DetailItem.isStop.toggle()
                                }){
                                    if DetailItem.isStop {
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
                                if DetailItem.isStop {
                                    DatePicker2(date: $DetailItem.lastDate)
                                }
                            }
                            HStack{
                                Text("设置循环")
                                    .font(.body.smallCaps())
                                    .foregroundColor(.secondary)
                                Spacer()
                                Button(action:{
                                    Haptics.giveSmallHaptic()
                                    DetailItem.isLoop = false
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
                                DetailItem.isLoop = true
                            }){
                                Text("设置循环")
                            }
                        }
                    }
                }else if whichOneButton==5 {
                    VStack{
                        HStack{
                            Text("设置优先级")
                                .font(.body.smallCaps())
                                .foregroundColor(.secondary)
                            Spacer()
                        }
                        Spacer()
                        Button(action:{
                            Haptics.giveSmallHaptic()
                            if DetailItem.priorityLevel==1 {
                                DetailItem.priorityLevel = 0
                            }else {
                                DetailItem.priorityLevel = 1
                            }
                        }){
                            if DetailItem.priorityLevel==1 {
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
                            if DetailItem.priorityLevel==2 {
                                DetailItem.priorityLevel = 0
                            }else {
                                DetailItem.priorityLevel = 2
                            }
                        }){
                            if DetailItem.priorityLevel==2 {
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
                            if DetailItem.priorityLevel==3 {
                                DetailItem.priorityLevel = 0
                            }else {
                                DetailItem.priorityLevel = 3
                            }
                        }){
                            if DetailItem.priorityLevel==3 {
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
                            if DetailItem.priorityLevel==4 {
                                DetailItem.priorityLevel = 0
                            }else {
                                DetailItem.priorityLevel = 4
                            }
                        }){
                            if DetailItem.priorityLevel==4 {
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
}

