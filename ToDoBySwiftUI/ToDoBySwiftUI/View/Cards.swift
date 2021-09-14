//
//  Cards.swift
//  Cards
//
//  Created by 李佳林 on 2021/8/29.
//

import Foundation
import SwiftUI

struct CategoryCards: View {
    var category: String
    var color: Color
    var numberOfTasks: Int
    var tasksDone: Int
    
    let maxProgress = 240.0
    
    var progress: Double {
        maxProgress*(Double(tasksDone)/Double(numberOfTasks))
    }
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(numberOfTasks) tasks")
                .font(.callout)
                .foregroundColor(.secondary)
            Text(category)
                .font(.title.bold())
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(maxWidth: maxProgress)
                    .frame(height: 5)
                    .foregroundColor(.gray.opacity(0.5))
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .frame(maxWidth: maxProgress)
                    .frame(width: numberOfTasks > 0 ? progress : 0, height: 5)
                    .foregroundColor(color.opacity(0.9))
            }
        }
        .padding(10)
        .frame(width: 270, height: 200, alignment: .leading)
        .background(
            ZStack {
            
            LinearGradient(colors: [color.opacity(0.95), color.opacity(0.3)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
            
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(20)
            
                if #available(iOS 15.0, *) {
                    VStack {
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
    }
}


struct ButtonCards: View {
    
    var category: String
    var ImageString: String
    var color: Color
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(spacing:20){
                Image(systemName: ImageString)
                    .font(.system(size: 30).bold())
                    .foregroundColor(color)
                Text(category)
                    .font(.body.bold())
                    .foregroundColor(color)
            }
        }
        .padding(10)
        .frame(width: 130, height: 60, alignment: .leading)
        .background(
            ZStack {
            LinearGradient(colors: [color.opacity(0.95), color.opacity(0.3)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(maxWidth: 300, maxHeight: 70)
            
                if #available(iOS 15.0, *) {
                    VStack {
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.thinMaterial)
                } else {
                    // Fallback on earlier versions
                }
        },
            alignment: .leading
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct ButtonCards2: View {
    var category: String
    var color: Color
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Text(category)
                    .font(.body.bold())
                    .foregroundColor(color)
                Spacer()
            }
        }
        .padding(10)
        .frame(width: 90, height: 50, alignment: .leading)
        .background(
            ZStack {
            LinearGradient(colors: [color.opacity(0.95), color.opacity(0.3)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(maxWidth: 300, maxHeight: 70)
            
                if #available(iOS 15.0, *) {
                    VStack {
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.thinMaterial)
                } else {
                    // Fallback on earlier versions
                }
        },
            alignment: .leading
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
        .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
    }
}

struct ButtonCards3: View {
    var imageName: String
    var category: String
    var color: Color
    
    var body: some View {
        VStack{
            HStack{
                Image(systemName: imageName)
                    .font(.body.bold())
                    .foregroundColor(color)
                    .padding(2)
                Spacer()
                Text(category)
                    .font(.body.bold())
                    .foregroundColor(color)
                    .padding(10)
            }
        }
        .padding(10)
        .frame(width: 200, height: 40, alignment: .leading)
        .background(
            ZStack {
            LinearGradient(colors: [color.opacity(0.95), color.opacity(0.3)],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .frame(maxWidth: 300, maxHeight: 70)
            
                if #available(iOS 15.0, *) {
                    VStack {
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.thinMaterial)
                } else {
                    // Fallback on earlier versions
                }
        },
            alignment: .leading
        )
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: .black.opacity(0.1), radius: 20, x: 5, y: 10)
        .shadow(color: .black.opacity(0.1), radius: 1, x: 1, y: 1)
    }
}



struct CategoryCards_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            if #available(iOS 15.0, *) {
                CategoryCards(category: "Business",color: Color.cyan,numberOfTasks: 40,tasksDone: 20)
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 15.0, *) {
                ButtonCards(category: "Hello",ImageString: "person", color: Color.cyan)
            } else {
                // Fallback on earlier versions
            }
            if #available(iOS 15.0, *) {
                ButtonCards2(category: "Hello", color: Color.cyan)
            } else {
                // Fallback on earlier versions
            }
            ButtonCards3(imageName: "4.square", category: "不重要且不紧急", color: .blue)
        }
        
    }
}
