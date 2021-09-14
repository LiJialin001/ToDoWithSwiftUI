//
//  AddBookView.swift
//  AddBookView
//
//  Created by 李佳林 on 2021/8/18.
//

import Foundation
import SwiftUI
import Combine

struct AddBookView: View {
    @EnvironmentObject var databaseBook: BookStore
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) private var viewContext
    var namespace: Namespace.ID
    @Binding var newBookOpen: Bool
    @State var addTitle = ""
    @State var mainText = ""
    @State var lastText = [""]
    @State var whichText = 0
    
    let mainTextLimit = 200
    
    func undo() -> Void {
        if whichText==0 {
            return
        }
        whichText -= 1
    }
    func nextdo() -> Void {
        if whichText == (lastText.count-1) {
            return
        }
        whichText += 1
    }
    func editOver() -> Void {
        if lastText[whichText].isEmpty {
            return
        }
        lastText.append("")
        lastText[whichText+1] = lastText[whichText]
        whichText += 1
    }
    func getCNDateYMD(Cdate: Date)-> String {
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy年MM月dd日"
        let datestr = dformatter.string(from: Cdate)
        return datestr
    }
    
    var body: some View {
        let binding = Binding<String>(get: {
                    self.lastText[whichText]
                }, set: {
                    self.lastText[whichText] = $0
                    lastText.append("")
                    lastText[whichText+1] = lastText[whichText]
                    whichText += 1
                    // do whatever you want here
                })
        ZStack{
            VStack{
                HStack{
                    Button(action:{
                        withAnimation {
                            newBookOpen = false
                        }
                    }){
                        HStack{
                            Image(systemName: "chevron.left")
                                .font(.body)
                            Text("备忘录")
                                .font(.body)
                                .padding()
                        }
                    }
                    .padding()
                    HStack{
                        Spacer()
                        Button(action:{
                            mainText = lastText[whichText]
                            if addTitle != "" {
                                Haptics.simpleSuccess()
                                self.databaseBook.Books.append(BookItem(title: self.addTitle,substance: self.mainText,eidtDate: Date(),textImages: [""] ))
                            }
                            withAnimation (.easeInOut(duration: 0.5)){
                                newBookOpen = false
                            }
                        }){
                            Image(systemName: "checkmark")
                                .font(.title)
                        }
                        .padding()
                    }
                    .matchedGeometryEffect(id: "button2", in: namespace)
                }
                
                
                ScrollView{
                    VStack(alignment:.leading){
                        
                        TextField("输入主题", text: $addTitle)
                            .font(.system(size: 20))
                            .padding(.leading, 10)
                            .padding(25)
                        
                        Text(getCNDateYMD(Cdate:Date()))
                            .foregroundColor(.gray)
                            .padding(.leading,30)
                        
                        
                        ZStack(alignment: .leading) {
                            if lastText[whichText].isEmpty {
                                VStack(alignment: .leading) {
                                    Text("输入备忘录内容")
                                        .font(Font.body)
                                        .foregroundColor(Color.gray)
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 4)
                                .zIndex(0)
                            }
                            TextEditor(text: binding)
                            
                                .frame(height: 200, alignment: .leading)
                                .frame(maxWidth: .infinity)
                                .lineSpacing(5)
                                .onReceive(Just(lastText)) { lastText in
                                    textChanged(upper: mainTextLimit, text: &self.lastText[whichText])
                                }
                                .zIndex(1)
                                .opacity(lastText[whichText].isEmpty ? 0.25 : 1)
                        }
                        .frame(height: 200, alignment: .leading)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 30)
                        Spacer()
                    }
                    .background(
                        Color.clear
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                        }
                    )
                }
            }
        }
    }
    
    func textChanged(upper: Int, text: inout String) {
        if text.count > upper {
            text = String(text.prefix(upper))
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    @Namespace static var namespace
    static var previews: some View {
        if #available(iOS 15.0, *) {
            AddBookView(namespace: namespace, newBookOpen: .constant(false))
                .environmentObject(BookStore())
        } else {
            // Fallback on earlier versions
        }
    }
}

