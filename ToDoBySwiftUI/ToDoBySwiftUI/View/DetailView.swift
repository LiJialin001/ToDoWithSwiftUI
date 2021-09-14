//
//  DetailView.swift
//  DetailView
//
//  Created by 李佳林 on 2021/8/9.
//

/*import SwiftUI


struct DetailView: View {
    @EnvironmentObject var database: ToDoStore
    @Environment(\.presentationMode) var presentation
    @State var DetailItem: ToDoItem
    @State private var showAlert = false
    @State var StopButton:Bool = true
    var Item: ToDoItem
    
    var body: some View {
        ZStack{
            ScrollView{
                VStack{
                    TextField(DetailItem.title, text: $DetailItem.title)
                        .font(.title)
                        .padding(.leading, 10)
                        .padding()
                    
                    if #available(iOS 15.0, *) {
                        DatePicker("DDL",selection: $DetailItem.date, displayedComponents: [.date, .hourAndMinute])
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .accentColor(Color.indigo)
                        .padding()
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    if !DetailItem.isLoop {
                        HStack(spacing:89){
                            Text("是否循环")
                            
                            Button(action: {
                                DetailItem.isLoop = true
                            }) {
                                Image( systemName: "checkmark.circle")
                                    .font(.title)
                            }
                            Button(action: {
                                DetailItem.isLoop = false
                            }) {
                                Image( systemName: DetailItem.isLoop ? "xmark.circle"  : "xmark.circle.fill")
                                    .font(.title)
                            }
                        }
                    }
                    
                    if DetailItem.isLoop {
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
                                DetailItem.isLoop = false
                            }){
                                Image(systemName: "arrowshape.turn.up.left.circle")
                                    .font(.system(size: 25))
                                    
                            }.padding(.init(top: 9, leading: 40, bottom: -19, trailing: 13))
                        }
                        
                        
                        
                        if StopButton {
                            if #available(iOS 15.0, *) {
                                DatePicker("循环截止",selection: $DetailItem.lastDate, displayedComponents: [.date, .hourAndMinute])
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
                                if DetailItem.cyclePeriod==1 {
                                    DetailItem.cyclePeriod = 2
                                }else {
                                    DetailItem.cyclePeriod = 1
                                }
                            }){
                                if DetailItem.cyclePeriod==1{
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
                                DetailItem.cyclePeriod = 2
                            }){
                                if DetailItem.cyclePeriod==2 {
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
                                if DetailItem.cyclePeriod==3 {
                                    DetailItem.cyclePeriod = 2
                                }else {
                                    DetailItem.cyclePeriod = 3
                                }
                            }){
                                if DetailItem.cyclePeriod==3{
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
                    
                    Text("设置分类:")
                        .padding(.init(top: 30, leading: -157, bottom: -15, trailing: 10))
                    
                    VStack{
                        HStack(spacing: -40){
                            Button(action: {
                                if DetailItem.classification != 1 {
                                    DetailItem.classification = 1
                                }else{
                                    DetailItem.classification = 0
                                }
                            }){
                                VStack(spacing: 10) {
                                    if #available(iOS 15.0, *) {
                                        Image(systemName: DetailItem.classification==1 ? "graduationcap.fill" : "graduationcap")
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
                                if DetailItem.classification != 2{
                                    DetailItem.classification = 2
                                }else{
                                    DetailItem.classification = 0
                                }
                            }){
                                VStack(spacing: 10) {
                                    Image(systemName: DetailItem.classification==2 ? "paintpalette.fill" : "paintpalette")
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
                                if DetailItem.classification != 3 {
                                    DetailItem.classification = 3
                                }else{
                                    DetailItem.classification = 0
                                }
                            }){
                                VStack(spacing: 10) {
                                    if #available(iOS 15.0, *) {
                                        Image(systemName: DetailItem.classification==3 ? "gamecontroller.fill" : "gamecontroller")
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
                                if DetailItem.classification != 4 {
                                    DetailItem.classification = 4
                                }else{
                                    DetailItem.classification = 0
                                }
                            }){
                                VStack(spacing: 10) {
                                    if #available(iOS 15.0, *) {
                                        Image(systemName: DetailItem.classification==4 ? "pencil.circle.fill" : "pencil.circle")
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
                            if DetailItem.priorityLevel != 1{
                                DetailItem.priorityLevel = 1
                            }else{
                                DetailItem.priorityLevel = 0
                            }
                        }){
                            if #available(iOS 15.0, *) {
                                HStack(spacing:40){
                                    Image(systemName: DetailItem.priorityLevel==1 ? "1.square.fill" : "1.square")
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
                            if DetailItem.priorityLevel != 2 {
                                DetailItem.priorityLevel = 2
                            }else{
                                DetailItem.priorityLevel = 0
                            }
                        }){
                            HStack(spacing:20){
                                Image(systemName: DetailItem.priorityLevel==2 ? "2.square.fill" : "2.square")
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
                            if DetailItem.priorityLevel != 3 {
                                DetailItem.priorityLevel = 3
                            }else{
                                DetailItem.priorityLevel = 0
                            }
                        }){
                            if #available(iOS 15.0, *) {
                                HStack(spacing:20){
                                    Image(systemName: DetailItem.priorityLevel==3 ? "3.square.fill" : "3.square")
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
                            if DetailItem.priorityLevel != 4 {
                                DetailItem.priorityLevel = 4
                            }else{
                                DetailItem.priorityLevel = 0
                            }
                        }){
                            HStack{
                                Image(systemName: DetailItem.priorityLevel==4 ? "4.square.fill" : "4.square")
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
                    }
                    
                    if #available(iOS 15.0, *) {
                        Button(action: {
                            
                            self.database.ToDos[self.database.ToDos.firstIndex(of: self.Item) ?? 0] = DetailItem
                        }, label: {
                            HStack {
                                Text("更改待办")
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
        }
    }
}




struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(DetailItem: ToDoItem(id: UUID(), title: "hhhhh", priorityLevel: 1, classification: 1, date: Date(), lastDate: Date(), isCompleted: false, isOverTime: true, isPersonal: true, isLoop: false, isStop: true, cyclePeriod: 1), Item: ToDoItem(id: UUID(), title: "hhhhh", priorityLevel: 1, classification: 1, date: Date(), lastDate: Date(), isCompleted: false, isOverTime: true, isPersonal: true, isLoop: false, isStop: true, cyclePeriod: 1))
            .environmentObject(ToDoStore())
    }
}
*/
