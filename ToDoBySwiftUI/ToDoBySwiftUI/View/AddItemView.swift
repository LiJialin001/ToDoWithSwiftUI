//
//  AddItemView.swift
//  AddItemView
//
//  Created by 李佳林 on 2021/8/5.
//

/*import SwiftUI
import Combine

struct AddItemView: View {
    @EnvironmentObject var database: ToDoStore
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    var namespace: Namespace.ID
    @Binding var newItemOpen: Bool
    @State var addTitle = ""
    @State private var date = Date()
    @State var date2 = Date()
    @State var classify = 0
    @State var priority = 0
    @State var loopTime = 2
    @State var showAlert = false
    @State var isloop = false
    @State var xbutton = false
    @State var StopButton = true
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    Text("新待办")
                        .font(.title)
                        .padding(.leading, -190)
                        .padding(.horizontal)
                   //     .padding(.vertical, 10)
                        .padding()
                    
                    
                    TextField("待办名称", text: $addTitle)
                        .font(.title)
                        .padding(.leading, 10)
                        .padding()
           
                    
                    if #available(iOS 15.0, *) {
                        DatePicker("DDL",selection: $date, displayedComponents: [.date, .hourAndMinute])
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .accentColor(Color.indigo)
                        .padding()
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    if !isloop {
                        HStack{
                            Text("是否循环")
                                .padding()
                            Spacer()
                            HStack(spacing:60){
                                Button(action: {
                                    isloop = true
                                    xbutton = false
                                }) {
                                    Image( systemName: "checkmark.circle")
                                        .font(.title)
                                }
                                Button(action: {
                                    isloop = false
                                    xbutton = true
                                }) {
                                    Image( systemName: xbutton ? "xmark.circle.fill" : "xmark.circle")
                                        .font(.title)
                                }
                            }
                            Spacer()
                        }
                    }
                    
                    if isloop {
                        HStack{
                            Text("设置循环:")
                               .padding(.init(top: 9, leading: -10, bottom: -19, trailing: -20))
                            Button(action:{
                                StopButton.toggle()
                            }){
                                if #available(iOS 15.0, *) {
                                    if !StopButton {
                                        Text("无截止日期")
                                            .padding(8)
                                            .background(Color.indigo)
                                            .cornerRadius(40)
                                            .foregroundColor(.white)
                                    } else {
                                        Text("有截止日期")
                                            .padding(8)
                                            .background(Color.cyan)
                                            .cornerRadius(40)
                                            .foregroundColor(.white)
                                    }
                                    
                                } else {
                                    // Fallback on earlier versions
                                }
                            }
                            .padding(.init(top: 9, leading: 40, bottom: -19, trailing: 10))
                            Button(action:{
                                isloop = false
                            }){
                                Image(systemName: "arrowshape.turn.up.left.circle")
                                    .font(.system(size: 25))
                                    
                            }.padding(.init(top: 9, leading: 40, bottom: -19, trailing: 13))
                        }
                        
                        
                        
                        if StopButton {
                            if #available(iOS 15.0, *) {
                                DatePicker("循环截止",selection: $date2, displayedComponents: [.date, .hourAndMinute])
                                .padding(.horizontal)
                                .padding(.vertical, 10)
                                .accentColor(Color.indigo)
                                .padding()
                                .padding(.init(top: 5, leading: 1, bottom: -35, trailing: -10))
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                        

                        HStack(alignment: .center, spacing:35){
                            
                            Button(action: {
                                if loopTime==1 {
                                    loopTime = 2
                                }else {
                                    loopTime = 1
                                }
                            }){
                                if loopTime==1{
                                    if #available(iOS 15.0, *) {
                                        Text("每天")
                                            .foregroundColor(Color.indigo)
                                            .padding(20)
                                            .background(
                                                ZStack {
                                                
                                                    if #available(iOS 15.0, *) {
                                                        LinearGradient(colors: [.indigo.opacity(0.95), .indigo.opacity(0.3)],
                                                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                                                        
                                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                            .padding(20)
                                                    } else {
                                                        // Fallback on earlier versions
                                                    }
                                                
                                                    if #available(iOS 15.0, *) {
                                                        VStack {
                                                            // empty VStack for the blur
                                                        }
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .background(.thinMaterial)
                                                    } else {
                                                        // Fallback on earlier versions
                                                    }
                                            },
                                                alignment: .leading
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                            .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                            .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                            .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                            .cornerRadius(20)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                                else {
                                    Text("每天")
                                        .foregroundColor(Color.black)
                                        .padding(20)
                                        .background(
                                            ZStack {
                                            
                                                if #available(iOS 15.0, *) {
                                                    LinearGradient(colors: [.black.opacity(0.98), .black.opacity(0.9)],
                                                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .padding(20)
                                                } else {
                                                    // Fallback on earlier versions
                                                }
                                            
                                                if #available(iOS 15.0, *) {
                                                    VStack {
                                                        // empty VStack for the blur
                                                    }
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .background(.thinMaterial)
                                                } else {
                                                    // Fallback on earlier versions
                                                }
                                        },
                                            alignment: .leading
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                        .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                        .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                        .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                        .cornerRadius(20)
                                }
                            }
                            .padding(.init(top: 35, leading: 5, bottom: 10, trailing: -10))
                            .buttonStyle(BorderlessButtonStyle())
                            
                            
                            Button(action: {
                                loopTime = 2
                            }){
                                if loopTime==2 {
                                    if #available(iOS 15.0, *) {
                                        Text("每周")
                                            .foregroundColor(Color.indigo)
                                            .padding(20)
                                            .background(
                                                ZStack {
                                                    
                                                    if #available(iOS 15.0, *) {
                                                        LinearGradient(colors: [.indigo.opacity(0.95), .indigo.opacity(0.3)],
                                                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                                                        
                                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                            .padding(20)
                                                    } else {
                                                        // Fallback on earlier versions
                                                    }
                                                    
                                                    if #available(iOS 15.0, *) {
                                                        VStack {
                                                            // empty VStack for the blur
                                                        }
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .background(.thinMaterial)
                                                    } else {
                                                        // Fallback on earlier versions
                                                    }
                                                },
                                                alignment: .leading
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                            .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                            .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                            .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                            .cornerRadius(20)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                                else {
                                    Text("每周")
                                        .foregroundColor(Color.black)
                                        .padding(20)
                                        .background(
                                            ZStack {
                                            
                                                if #available(iOS 15.0, *) {
                                                    LinearGradient(colors: [.black.opacity(0.98), .black.opacity(0.9)],
                                                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .padding(20)
                                                } else {
                                                    // Fallback on earlier versions
                                                }
                                            
                                                if #available(iOS 15.0, *) {
                                                    VStack {
                                                        // empty VStack for the blur
                                                    }
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .background(.thinMaterial)
                                                } else {
                                                    // Fallback on earlier versions
                                                }
                                        },
                                            alignment: .leading
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                        .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                        .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                        .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                        .cornerRadius(20)
                                }
                            }
                            .padding(.init(top: 35, leading: 10, bottom: 10, trailing: -10))
                            .buttonStyle(BorderlessButtonStyle())
                            
                            
                            Button(action: {
                                if loopTime==3 {
                                    loopTime = 2
                                }else {
                                    loopTime = 3
                                }
                            }){
                                if loopTime==3{
                                    if #available(iOS 15.0, *) {
                                        Text("每月")
                                            .foregroundColor(Color.indigo)
                                            .padding(20)
                                            .background(
                                                ZStack {
                                                    
                                                    if #available(iOS 15.0, *) {
                                                        LinearGradient(colors: [.indigo.opacity(0.95), .indigo.opacity(0.3)],
                                                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                                                        
                                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                            .padding(20)
                                                    } else {
                                                        // Fallback on earlier versions
                                                    }
                                                    
                                                    if #available(iOS 15.0, *) {
                                                        VStack {
                                                            // empty VStack for the blur
                                                        }
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .background(.thinMaterial)
                                                    } else {
                                                        // Fallback on earlier versions
                                                    }
                                                },
                                                alignment: .leading
                                            )
                                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                            .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                            .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                            .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                            .cornerRadius(20)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                                else {
                                    Text("每月")
                                        .foregroundColor(Color.black)
                                        .padding(20)
                                        .background(
                                            ZStack {
                                            
                                                if #available(iOS 15.0, *) {
                                                    LinearGradient(colors: [.black.opacity(0.98), .black.opacity(0.9)],
                                                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                                                    
                                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                        .padding(20)
                                                } else {
                                                    // Fallback on earlier versions
                                                }
                                            
                                                if #available(iOS 15.0, *) {
                                                    VStack {
                                                        // empty VStack for the blur
                                                    }
                                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                    .background(.thinMaterial)
                                                } else {
                                                    // Fallback on earlier versions
                                                }
                                        },
                                            alignment: .leading
                                        )
                                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                        .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                        .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                        .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                        .cornerRadius(20)
                                }
                            }
                            .padding(.init(top: 35, leading: 10, bottom: 10, trailing: -10))
                            .buttonStyle(BorderlessButtonStyle())
                        }
                        
                    }
                    
                    
                    
                    
            /*           */
                    
                    
                    Text("设置分类:")
                        .padding(.init(top: 30, leading: -157, bottom: -15, trailing: 10))
                    VStack{
                        HStack(spacing: -40){
                            Button(action: {
                                if classify != 1 {
                                    classify = 1
                                }else{
                                    classify = 0
                                }
                            }){
                                VStack(spacing: 10) {
                                    if #available(iOS 15.0, *) {
                                        Image(systemName: classify==1 ? "graduationcap.fill" : "graduationcap")
                                            .font(.title)
                                            .foregroundColor(.indigo)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                    if #available(iOS 15.0, *) {
                                        Text("学习")
                                            .font(.system(size: 15, design: .rounded))
                                            .foregroundColor(.indigo)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                    
                                }
                                .frame(minWidth: 40, maxWidth: 50, maxHeight: 60)
                                .padding(15)
                                .background(
                                    ZStack {
                                    
                                        if #available(iOS 15.0, *) {
                                            LinearGradient(colors: [.indigo.opacity(0.95), .indigo.opacity(0.3)],
                                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                            
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .padding(20)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                    
                                        if #available(iOS 15.0, *) {
                                            VStack {
                                                // empty VStack for the blur
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(.thinMaterial)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                },
                                    alignment: .leading
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                .cornerRadius(10)
                            }
                            .buttonStyle(GradientBackgroundStyle())
                            
                            
                            Button(action: {
                                if classify != 2{
                                    classify = 2
                                }else{
                                    classify = 0
                                }
                            }){
                                VStack(spacing: 10) {
                                    Image(systemName: classify==2 ? "paintpalette.fill" : "paintpalette")
                                        .font(.title)
                                        .foregroundColor(.black)
                                    Text("生活")
                                        .font(.system(size: 15, design: .rounded))
                                        .foregroundColor(.black)
                                }
                                .frame(minWidth: 40, maxWidth: 50, maxHeight: 60)
                                .padding(15)
                                .background(
                                    ZStack {
                                    
                                        if #available(iOS 15.0, *) {
                                            LinearGradient(colors: [.black.opacity(0.98), .black.opacity(0.9)],
                                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                            
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .padding(20)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                    
                                        if #available(iOS 15.0, *) {
                                            VStack {
                                                // empty VStack for the blur
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(.thinMaterial)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                },
                                    alignment: .leading
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                .cornerRadius(10)
                            }
                            .buttonStyle(GradientBackgroundStyle())
                            
                            Button(action: {
                                if classify != 3 {
                                    classify = 3
                                }else{
                                    classify = 0
                                }
                            }){
                                VStack(spacing: 10) {
                                    if #available(iOS 15.0, *) {
                                        Image(systemName: classify==3 ? "gamecontroller.fill" : "gamecontroller")
                                            .font(.title)
                                            .foregroundColor(.indigo)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                    if #available(iOS 15.0, *) {
                                        Text("娱乐")
                                            .font(.system(size: 15, design: .rounded))
                                            .foregroundColor(.indigo)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                                .frame(minWidth: 40, maxWidth: 50, maxHeight: 60)
                                .padding(15)
                                .background(
                                    ZStack {
                                    
                                        if #available(iOS 15.0, *) {
                                            LinearGradient(colors: [.indigo.opacity(0.95), .indigo.opacity(0.3)],
                                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                            
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .padding(20)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                    
                                        if #available(iOS 15.0, *) {
                                            VStack {
                                                // empty VStack for the blur
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(.thinMaterial)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                },
                                    alignment: .leading
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                .cornerRadius(10)
                            }
                            
                            .buttonStyle(GradientBackgroundStyle())
                            
                            Button(action: {
                                if classify != 4 {
                                    classify = 4
                                }else{
                                    classify = 0
                                }
                            }){
                                VStack(spacing: 10) {
                                    if #available(iOS 15.0, *) {
                                        Image(systemName: classify==4 ? "pencil.circle.fill" : "pencil.circle")
                                            .font(.title)
                                            .foregroundColor(.black)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                    Text("工作")
                                        .font(.system(size: 15, design: .rounded))
                                        .foregroundColor(.black)
                                }
                                .frame(minWidth: 40, maxWidth: 50, minHeight: 60, maxHeight: 90)
                                .padding(15)
                                .background(
                                    ZStack {
                                    
                                        if #available(iOS 15.0, *) {
                                            LinearGradient(colors: [.black.opacity(0.98), .black.opacity(0.9)],
                                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                            
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .padding(20)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                    
                                        if #available(iOS 15.0, *) {
                                            VStack {
                                                // empty VStack for the blur
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(.thinMaterial)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                },
                                    alignment: .leading
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                .cornerRadius(10)
                            }
                            .buttonStyle(GradientBackgroundStyle())
                        }
                    }
                    
                    
                    
                    Text("设置优先级:")
                        .padding(.init(top: 30, leading: -157, bottom: -15, trailing: 10))
                    VStack(spacing: -10){
                        Button(action: {
                            if priority != 1{
                                priority = 1
                            }else{
                                priority = 0
                            }
                        }){
                            if #available(iOS 15.0, *) {
                                HStack(spacing:40){
                                    Image(systemName: priority==1 ? "1.square.fill" : "1.square")
                                        .font(.title)
                                    Text("重要且紧急")
                                        .font(.system(size: 18))
                                }
                                .frame(minWidth: 190, maxWidth: 220)
                                .padding(10)
                                .background(
                                    ZStack {
                                        
                                        if #available(iOS 15.0, *) {
                                            LinearGradient(colors: [.indigo.opacity(0.95), .indigo.opacity(0.9)],
                                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                            
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .padding(20)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                        
                                        if #available(iOS 15.0, *) {
                                            VStack {
                                                // empty VStack for the blur
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(.thinMaterial)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                    },
                                    alignment: .leading
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                .cornerRadius(10)
                                .foregroundColor(.indigo)
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                        .buttonStyle(GradientBackgroundStyle())
                        
                        Button(action: {
                            if priority != 2 {
                                priority = 2
                            }else{
                                priority = 0
                            }
                        }){
                            HStack(spacing:20){
                                Image(systemName: priority==2 ? "2.square.fill" : "2.square")
                                    .font(.title)
                                Text("重要且不紧急")
                                    .font(.system(size: 18))
                            }
                            .frame(minWidth: 190, maxWidth: 220)
                            .padding(10)
                            .background(
                                ZStack {
                                
                                    if #available(iOS 15.0, *) {
                                        LinearGradient(colors: [.black.opacity(0.98), .black.opacity(0.9)],
                                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                                        
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .padding(20)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                
                                    if #available(iOS 15.0, *) {
                                        VStack {
                                            // empty VStack for the blur
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .background(.thinMaterial)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                            },
                                alignment: .leading
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                            .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                            .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                            .cornerRadius(10)
                            .foregroundColor(Color.black)
                        }
                        .buttonStyle(GradientBackgroundStyle())
                        
                        
                        Button(action: {
                            if priority != 3 {
                                priority = 3
                            }else{
                                priority = 0
                            }
                        }){
                            if #available(iOS 15.0, *) {
                                HStack(spacing:20){
                                    Image(systemName: priority==3 ? "3.square.fill" : "3.square")
                                        .font(.title)
                                    Text("不重要且紧急")
                                        .font(.system(size: 18))
                                }
                                .frame(minWidth: 190, maxWidth: 220)
                                .padding(10)
                                .background(
                                    ZStack {
                                        
                                        if #available(iOS 15.0, *) {
                                            LinearGradient(colors: [.indigo.opacity(0.95), .indigo.opacity(0.9)],
                                                           startPoint: .topLeading, endPoint: .bottomTrailing)
                                            
                                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                                .padding(20)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                        
                                        if #available(iOS 15.0, *) {
                                            VStack {
                                                // empty VStack for the blur
                                            }
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .background(.thinMaterial)
                                        } else {
                                            // Fallback on earlier versions
                                        }
                                    },
                                    alignment: .leading
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                                .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                                .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                .cornerRadius(10)
                                .foregroundColor(Color.indigo)
                            } else {
                                // Fallback on earlier versions
                            }
                        }
                        .buttonStyle(GradientBackgroundStyle())
                        
                        
                        Button(action: {
                            if priority != 4 {
                                priority = 4
                            }else{
                                priority = 0
                            }
                        }){
                            HStack{
                                Image(systemName: priority==4 ? "4.square.fill" : "4.square")
                                    .font(.title)
                                Text("不重要且不紧急")
                                    .font(.system(size: 18))
                            }
                            .frame(minWidth: 190, maxWidth: 220)
                            .padding(10)
                            .background(
                                ZStack {
                                    if #available(iOS 15.0, *) {
                                        LinearGradient(colors: [.black.opacity(0.98), .black.opacity(0.9)],
                                                       startPoint: .topLeading, endPoint: .bottomTrailing)
                                        
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .padding(20)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                
                                    if #available(iOS 15.0, *) {
                                        VStack {
                                            // empty VStack for the blur
                                        }
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .background(.thinMaterial)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                            },
                                alignment: .leading
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
                            .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
                            .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                            .cornerRadius(10)
                            .foregroundColor(Color.black)
                        }
                        .buttonStyle(GradientBackgroundStyle())
                        Spacer()
                        if #available(iOS 15.0, *) {
                            Button(action: {
                                self.database.ToDos.append(ToDoItem(title: self.addTitle, priorityLevel: self.priority ,classification: self.classify, date: self.date, lastDate: self.date2, isPersonal: true, isLoop: isloop ,isStop: StopButton, cyclePeriod: loopTime))
                                withAnimation {
                                    newItemOpen = false
                                }
                            }, label: {
                                HStack {
                                    Text("建立待办")
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
                                .shadow(color: .white.opacity(1), radius: 5, x: -1, y: -1)
                                .padding()
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                }
                .padding(.top, 10)
                .background(
                    Color.clear
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    })
         }
           
            VStack{
                HStack{
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            newItemOpen = false
                        }
                    }) {
                        if #available(iOS 15.0, *) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.indigo)
                                .shadow(color: .indigo.opacity(0.3), radius: 10, x: 0, y: 10)
                                .padding()
                                
                        } else {
                            // Fallback on earlier versions
                        }
                    }
                    
                }
                .matchedGeometryEffect(id: "button", in: namespace)
                
                Spacer()
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        if #available(iOS 15.0, *) {
            AddItemView(namespace: namespace, newItemOpen: .constant(false))
                .environmentObject(ToDoStore())
        } else {
            // Fallback on earlier versions
        }
    }
}

*/
